# CosmicTagger Conversion

The intent of this page is to show conceptually how to convert a model to run on the Graphcore system.  It is not necessary to convert CosmicTagger because it has already been converted and is
located at https://github.com/BruceRayWilsonAtANL/CosmicTagger.git.

1. (Done) Make sure you can run it on CPU
2. Set batch size to 1
3. Create a training model with loss,
4. and wrap it in poptorch.trainingModel, see [documentation](https://docs.graphcore.ai/projects/poptorch-user-guide/en/latest/overview.html#poptorch-trainingmodel) and [tutorial](https://github.com/graphcore/tutorials/tree/master/tutorials/pytorch/basics#build-the-model) - this line seems a good place to start from: [trainer.py](https://github.com/coreyjadams/CosmicTagger/blob/master/src/utils/torch/trainer.py#L742)
4. Wrap the inference model in  poptorch.inferenceModel (link)
5. Run to see if it fits in memory
6. If it does not: create a profile with the Graph Analyser (link), set precision to fp16/half (link), if needed run pipeline-parallel (link)

## Run CosmicTagger

The first step to converting a model is to verify that it runs on the CPU.

## Config.py

CosmicTagger can run on multiple machines.  As such, it is necessary to specify the architecture
that one is using.  For example, **CPU** or **GPU**.  The architecture is stored in the
**ComputeMode** class.

Edit **src/config/config.py**.  Add **IPU** to the **ComputeMode** class.

```python
class ComputeMode(Enum):
    CPU   = 0
    #...
    IPU   = 5
```

## Trainer.py

Edit **src/utils/torch/trainer.py**.

### Import PopTorch

**PopTorch** is Graphcore's extension of **PyTorch**.

Import **poptorch** at the top of the file.

```python
import poptorch
```

### Wrap Model

Wrap the model using **poptorch.trainingModel()** so that it may be ran on IPUs.

Find the following code around line 90.

```python
        # Foregoing any fusions as to not disturb the existing ingestion pipeline
        if self.is_training() and self.args.mode.quantization_aware:
            self._raw_net.qconfig = torch.quantization.get_default_qat_qconfig('fbgemm')
            self._net = torch.quantization.prepare_qat(self._raw_net)
        else:
            self._net = self._raw_net
```

**After** the above code, add:

```python
        if self.args.run.compute_mode == ComputeMode.IPU:
            opts = poptorch.Options()
            self._net = poptorch.trainingModel(self._net, opts, optimizer=torch.optim.SGD(self._net.parameters(), lr=1e-3))
```

See [poptorch.trainingModel()](https://docs.graphcore.ai/projects/poptorch-user-guide/en/latest/overview.html#poptorch-trainingmodel) for more information.

There is also a [Build the Model](https://github.com/graphcore/tutorials/tree/master/tutorials/pytorch/basics#build-the-model) tutorial.

### Update Optimizer

Update **init_optimizer()** to use the **poptorch** class instead of the **torch** class as needed.

Change:

```pytorch
        if self.args.mode.optimizer.name == OptimizerKind.rmsprop:
            self._opt = torch.optim.RMSprop(self._net.parameters(), 1.0, eps=1e-4)
        else:
            self._opt = torch.optim.Adam(self._net.parameters(), 1.0)
```

to:

```python
        if self.args.mode.optimizer.name == OptimizerKind.rmsprop:
            if self.args.run.compute_mode == ComputeMode.IPU:
                self._opt = poptorch.optim.RMSprop(self._net.parameters(), 1.0, eps=1e-4)
            else:
                self._opt = torch.optim.RMSprop(self._net.parameters(), 1.0, eps=1e-4)
        else:
            if self.args.run.compute_mode == ComputeMode.IPU:
                self._opt = poptorch.optim.Adam(self._net.parameters(), 1.0)
            else:
                self._opt = torch.optim.Adam(self._net.parameters(), 1.0)
```

### 2

### 3

### 4

### 5

## UResNet2D Model

### Update Model

The Graphcore system is more computationally efficient if the loss function is on the
IPU.  This is accomplished by using the loss function within the model's **forward** method.

Edit **src/networks/torch/uresnet2D.py**.

#### Update the Forward Declaration

Find the **forward** method.

```python
def forward(self, input_tensor):
```

Update the argument list to include the loss function, i.e., **loss_calculator**
and the image labels, i.e., **labels_image**.

```python
def forward(self, input_tensor, loss_calculator=None, labels_image=None):
```

#### Add Loss Calculation

Add the loss calculation just before the **forward** method returns.

```python
        if loss_calculator is not None:

            labels_image = labels_image.long()
            labels_image = torch.chunk(labels_image, chunks=3, dim=1)
            shape =  labels_image[0].shape
            labels_image = [ _label.view([shape[0], shape[-2], shape[-1]]) for _label in labels_image ]

            loss = loss_calculator(labels_image, x)
            import poptorch
            loss = poptorch.identity_loss(loss , reduction="mean")
            return x, labels_image, loss

        # This return already exists.
        return x
```

The **poptorch.identity_loss** method takes a single PyTorch tensor and will backpropagate a gradient of ones through it.  You may find an example at [here](https://docs.graphcore.ai/projects/poptorch-user-guide/en/latest/overview.html#poptorch-identity-loss)




## Data Loader

Use **poptorch.DataLoader**.

```python
opts = poptorch.Options()

train_dataloader = poptorch.DataLoader(
    opts, train_dataset, batch_size=16, shuffle=True, num_workers=20
)
```

> ***Note for IPU benchmarking***:
>
> The warmup time can be avoided by calling `training_model.compile(data,
> labels)` before any other call to the model. If not, the first call will
> include the compilation time, which can take few minutes.
>
> ```python
> # Warmup
> print("Compiling + Warmup ...")
> training_model.compile(data, labels)
> ```

See tutorials/pytorch/efficient_data_loading/walkthrough.ipynb for more infomation

## Optimizer

```python
optimizer = poptorch.optim.SGD(model.parameters(), lr=0.001, momentum=0.9)
```

## TrainingModel

```python
poptorch_model = poptorch.trainingModel(model, options=opts, optimizer=optimizer)
```

## Training Loop

```python
epochs = 5
for epoch in tqdm(range(epochs), desc="epochs"):
    total_loss = 0.0
    for data, labels in tqdm(train_dataloader, desc="batches", leave=False):
        output, loss = poptorch_model(data, labels)
        total_loss += loss
```

The model is now trained! There's no need to retrieve the weights from the
device as you would by calling `model.cpu()` with PyTorch. PopTorch has
managed that step for us. We can now save and evaluate the model.
