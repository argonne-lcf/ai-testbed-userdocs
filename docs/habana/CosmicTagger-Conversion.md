# CosmicTagger Conversion

The intent of this page is to show conceptually how to convert a model to run on the **Habana** system.
It is not necessary to convert CosmicTagger because it has already been converted and is
located at [CosmicTagger](https://github.com/BruceRayWilsonAtANL/CosmicTagger.git) on the **Habana** branch.  The original is
located at [CosmicTagger](https://github.com/coreyjadams/CosmicTagger.git).

## Run CosmicTagger

The first step to converting a model is to verify that it runs on the CPU.  This step has been verified for CosmicTagger.

## Requirements.txt #Check

Comment out the following lines in **requirements.txt**:

```text
# tensorflow>=2.4.0
# torch>=1.3
```

## Config.py #Check

CosmicTagger can run on multiple machines.  As such, it is necessary to specify the architecture
that one is using.  For example, **CPU** or **GPU**.  The architecture is stored in the
**ComputeMode** class.

Edit **src/config/config.py**.  Add **HPU** to the **ComputeMode** class.

```python
class ComputeMode(Enum):
    CPU   = 0
    #...
    HPU   = 4
```

Habana has **lazy** and **eager** execution options.

Specify **lazy_mode** as **False** in the **Run** class.

```python
class Run:
    distributed:        bool        = True
    #...
    lazy_mode:          bool        = False
```

## Torch Distributed_trainer.py

Edit ./src/utils/torch/distributed_trainer.py.

### Import Contextlib #Check

Above:

```python
import logging
```

add:

```python
import contextlib
```

### Import Habana Collective Communications Library (HCCL) #Check

Habana Collective Communications Library (HCCL) is Habana’s emulation layer of the NVIDIA
Collective Communication Library (NCCL) and must be imported.

After:

```python
            size = MPI.COMM_WORLD.Get_size()
            rank = MPI.COMM_WORLD.Get_rank()
```

change:

```python
            torch.cuda.set_device(int(local_rank))
```

to:

```python
            if self.args.run.compute_mode == ComputeMode.HPU:
                import habana_frameworks.torch.distributed.hccl
            else:
                torch.cuda.set_device(int(local_rank))
```

### Specify HCCL as the Backend #Check

After:

```python
            elif self.args.run.compute_mode == ComputeMode.GPU: backend = 'nccl'
            elif self.args.run.compute_mode == ComputeMode.CPU: backend = 'gloo'
```

add:

```python
            elif self.args.run.compute_mode == ComputeMode.HPU: backend = 'hccl'
```

### Establish Init_process_group #Check

**Torch.distributed.init_process_group()** is called differently on the Habana system.
There are also two evironment variables that need to be assigned.

The code that you find will be replaced in the **else** section with the same code but, indented.

Find:

```python
            torch.distributed.init_process_group(
                backend     = backend,
                init_method = init_method,
                world_size  = size,
                rank        = rank,
                timeout     = datetime.timedelta(seconds=120)
            )
```

**Replace** it with:

```python
            if self.args.run.compute_mode == ComputeMode.HPU:
                # Here we assume the number of process per node is 8
                os.environ["ID"] = str(rank % 8 )
                os.environ["LOCAL_RANK"] = str(rank % 8 )
                torch.distributed.init_process_group(backend=backend, rank=rank, world_size=size)
            else:
                torch.distributed.init_process_group(
                    backend     = backend,
                    init_method = init_method,
                    world_size  = size,
                    rank        = rank,
                    timeout     = datetime.timedelta(seconds=120)
                )
```

### Fix lksjdflsdkfj #Check

Go to:

```python
        else:
            return contextlib.nullcontext
            # device = torch.device('cpu')
```

and replace it with:

```python
        else:
            return contextlib.nullcontext()
            # device = torch.device('cpu')
```

### Establish Torch.Device("hpu") #Check

Go to:

```python
    def default_device(self):
```

Before the last **else** statement, add **HPU** as a device option.

```python
        elif self.args.run.compute_mode == ComputeMode.HPU:
            device = torch.device("hpu")
```

## TensorFlow 2 Trainer.py (src/utils/tensorflow2/trainer.py) #Check

Edit **src/utils/tensorflow2/trainer.py**.

The only change required in this file is to call **load_habana_module()**.

Find:

```python
    def initialize(self, io_only=False):
```

Immediately after that method declaration, add:

```python
        if self.args.run.compute_mode == ComputeMode.HPU:
            from habana_frameworks.tensorflow import load_habana_module
            load_habana_module()
```

## Torch Trainer.py (src/utils/torch/trainer.py)

Edit **src/utils/torch/trainer.py**.

### Add Imports #Check

Add:

```python
from pickle import TRUE
from re import I
```

### Environment Variables #Check

lsdkjf lksdjf lksjdf

Find:

```python
        if self.is_training():
            self.build_lr_schedule()
```

Insert after:

```python
        if self.args.run.compute_mode == ComputeMode.HPU:

            import habana_frameworks.torch.core as htcore
            self.htcore = htcore

            if self.args.run.lazy_mode:
                os.environ["PT_HPU_LAZY_MODE"]="1"
            else:
                os.environ["PT_HPU_LAZY_MODE"]="2"
```

###

The only change required in this file is to call **load_habana_module()**.

Find:

```python
    def initialize(self, io_only=False):
```

Immediately after that method declaration, add:

```python
        if self.args.run.compute_mode == ComputeMode.HPU:
            from habana_frameworks.tensorflow import load_habana_module
            load_habana_module()
```







## bin/exec.py #Check

The following is included for completeness.  One will not likely find this in other code.

Open **bin/exec.py** in your favorite editor.  Change:

```python
@hydra.main(version_base=None, config_path="../src/config", config_name="config")
```

to

```python
@hydra.main(config_path="../src/config", config_name="config")
```
