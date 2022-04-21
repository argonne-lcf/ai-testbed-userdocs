# Example Programs

Sambanova provides examples of some well known AI applications under the path: /opt/sambaflow/apps/. Make a copy of this to your home directory:

```bash
cd ~/
cp -r /opt/sambaflow/apps/ .
```

## LeNet

Change directory

```bash
cd ~/apps/starters/
```

### Common Arguments

Below are some of the common arguments used across most of the models in the example code.

| Argument               | Default   | Help                           |
|------------------------|-----------|--------------------------------|
| --b                    | 1         | Batch size for training        |
|                        |           |                                |
| -n,                    | 100       | Number of iterations to run    |
| --num-iterations       |           | the pef for                    |
|                        |           |                                |
| -e,                    | 1         | Number epochs for training     |
| --num-epochs           |           |                                |
|                        |           |                                |
| --log-path             | 'check    | Log path                       |
|                        | points'   |                                |
|                        |           |                                |
| --num-workers          | 0         | Number of workers              |
|                        |           |                                |
| --measure-train-       | None      | Measure training performance   |
| performance            |           |                                |
|                        |           |                                |

### LeNet Arguments

| Argument               | Default   | Help                           |
|------------------------|-----------|--------------------------------|
| --lr                   | 0.01      | Learning rate for training     |
|                        |           |                                |
| --momentum             | 0.0       | Momentum value for training    |
|                        |           |                                |
| --weight-decay         | 0.01      | Weight decay for training      |
|                        |           |                                |
| --data-path            | './data'  | Data path                      |
|                        |           |                                |
| --data-folder          | 'mnist_   | Folder containing mnist data   |
|                        | data'     |                                |
|                        |           |                                |

**NOTE:  If you receive an "HTTP error" message on any of the
following commands, run the command again. Such errors (e.g 503) are
commonly an intermittent failure to download a dataset.**

Run these commands:

```bash
srun python lenet.py compile -b=1 --pef-name="lenet" --output-folder="pef"
srun python lenet.py test --pef="pef/lenet/lenet.pef"
srun python lenet.py run --pef="pef/lenet/lenet.pef"
srun python lenet.py measure-performance --pef="pef/lenet/lenet.pef"
```

To use Slurm sbatch, create submit-lenet-job.sh with the following
contents:

```bash
#!/bin/sh

python lenet.py compile -b=1 --pef-name="lenet" --output-folder="pef"
python lenet.py test --pef="pef/lenet/lenet.pef"
python lenet.py run --pef="pef/lenet/lenet.pef"
python lenet.py measure-performance --pef="pef/lenet/lenet.pef"
```

Then

```bash
sbatch --output=pef/lenet/output.log submit-lenet-job.sh
```

Squeue will give you the queue status.

```bash
squeue
```

The output file, pef/lenet/output.log, will look something like:

```text
[Info][SAMBA][Default] # Placing log files in
pef/lenet/lenet.samba.log

[Info][MAC][Default] # Placing log files in
pef/lenet/lenet.mac.log

[Warning][SAMBA][Default] #

--------------------------------------------------

Using patched version of torch.cat and torch.stack

--------------------------------------------------

[Warning][SAMBA][Default] # The dtype of "targets" to
CrossEntropyLoss is torch.int64, however only int16 is currently
supported, implicit conversion will happen

[Warning][MAC][GraphLoweringPass] # lenet__reshape skip
set_loop_to_air

[Warning][MAC][GraphLoweringPass] # lenet__reshape_bwd skip
set_loop_to_air

...

Epoch [1/1], Step [59994/60000], Loss: 0.1712

Epoch [1/1], Step [59995/60000], Loss: 0.1712

Epoch [1/1], Step [59996/60000], Loss: 0.1712

Epoch [1/1], Step [59997/60000], Loss: 0.1712

Epoch [1/1], Step [59998/60000], Loss: 0.1712

Epoch [1/1], Step [59999/60000], Loss: 0.1712

Epoch [1/1], Step [60000/60000], Loss: 0.1712

Test Accuracy: 98.06 Loss: 0.0628

2021-6-10 10:52:28 : [INFO][SC][53607]: SambaConnector: PEF File:
pef/lenet/lenet.pef

Log ID initialized to: [ALCFUserID][python][53607] at
/var/log/sambaflow/runtime/sn.log
```

Please note that there is no measure-performance command handled
currently in lenet.py and some of the other files in the pytorch starter
code. Hence if you run measure-performance on lenet.py, it will not
display anything. One way to run performance measure for lenet is, add
the following in the main function:

```text
elif args.command == "measure-performance":
        common_app_driver(args, model, inputs, optimizer, name='ffn_mnist_torch', app_dir=utils.get_file_dir(__file__))
```

## LeNet3D

Change directory (if necessary)

```bash
cd ~/apps/starters/
```

LeNet3D does compile but its "run" command is missing data at this
time.

```bash
srun python lenet3d.py compile --pef-name=lenet3d --output-folder="pef"
srun python lenet3d.py test -p pef/lenet3d/lenet3d.pef
srun python lenet3d.py measure-performance -p pef/lenet3d/lenet3d.pef
```

## MNIST - Feed Forward Network

Change directory (if necessary)

```bash
cd ~/apps/starters/
```

Copy data files:

```bash
cp -r /software/sambanova/dataset/mnist_data/ .
```

## Logistic Regression

Change directory (if necessary)

```bash
cd ~/apps/starters/
```

### Logistic Regression Arguments

This is not an exhaustive list of arguments.

Arguments

| Argument            | Default     | Help                         | Step     |
|---------------------|-------------|------------------------------|----------|
| --lr                | 0.001       | Learning rate for training   | Compile  |
|                     |             |                              |          |
| --momentum          | 0.0         | Momentum value for training  | Compile  |
|                     |             |                              |          |
| --weight-decay      | 1e-4        | Weight decay for training    | Compile  |
|                     |             |                              |          |
| --num-features      | 784         | Number features for training | Compile  |
|                     |             |                              |          |
| --num-classes       | 10          | Number classes for training  | Compile  |
|                     |             |                              |          |
| --weight-norm       | na          | Enable weight normalization  | Compile  |
|                     |             |                              |          |

Run these commands:

```bash
srun python logreg.py compile --pef-name="logreg" --output-folder="pef"
srun python logreg.py test --pef="pef/logreg/logreg.pef"
srun python logreg.py run --pef="pef/logreg/logreg.pef"
srun python logreg.py measure-performance --pef="pef/logreg/logreg.pef"
```

To use Slurm, create submit-logreg-job.sh with the following contents:

```bash
!/bin/sh

python logreg.py compile --pef-name="logreg" --output-folder="pef"
python logreg.py test --pef="pef/logreg/logreg.pef"
python logreg.py run --pef="pef/logreg/logreg.pef"
python logreg.py measure-performance --pef="pef/logreg/logreg.pef"
```

Then

```bash
sbatch --output=pef/logreg/output.log submit-logreg-job.sh
```

The output file, pef/logreg/output.log, will look something like:

```text
pef/logreg/output.log

[Info][SAMBA][Default] # Placing log files in
pef/logreg/logreg.samba.log
[Info][MAC][Default] # Placing log files in
pef/logreg/logreg.mac.log
[Warning][SAMBA][Default] #
--------------------------------------------------
Using patched version of torch.cat and torch.stack
--------------------------------------------------

[Warning][SAMBA][Default] # The dtype of "targets" to
CrossEntropyLoss is torch.int64, however only int16 is currently
supported, implicit conversion will happen
[Warning][MAC][MemoryOpTransformPass] # Backward graph is trimmed
according to requires_grad to save computation.
[Warning][MAC][WeightShareNodeMergePass] # Backward graph is
trimmed according to requires_grad to save computation.
[Warning][MAC][ReduceCatFaninPass] # Backward graph is trimmed
according to requires_grad to save computation.
[info ] [PLASMA] Launching plasma compilation! See log file:
/lambda_stor/homes/ALCFUserID/apps/starters/pytorch/pef/logreg//logreg.plasma_compile.log
...

[Warning][SAMBA][Default] # The dtype of "targets" to
CrossEntropyLoss is torch.int64, however only int16 is currently
supported, implicit conversion will happen
Epoch [1/1], Step [10000/60000], Loss: 0.4763
Epoch [1/1], Step [20000/60000], Loss: 0.4185
Epoch [1/1], Step [30000/60000], Loss: 0.3888
Epoch [1/1], Step [40000/60000], Loss: 0.3721
Epoch [1/1], Step [50000/60000], Loss: 0.3590
Epoch [1/1], Step [60000/60000], Loss: 0.3524
Test Accuracy: 90.07 Loss: 0.3361
2021-6-11 8:38:49 : [INFO][SC][99185]: SambaConnector: PEF File:
pef/logreg/logreg.pef
Log ID initialized to: [ALCFUserID][python][99185] at
/var/log/sambaflow/runtime/sn.log
```

## **UNet**

Change directory

```bash
cd ~/apps/image/pytorch/unet
export OUTDIR=~/apps/image/pytorch/unet
export DATADIR=/var/tmp/kaggle_3m/
```

Export the path to the dataset which is required for the training.

Run these commands for training (compile + train):

```bash
srun python unet.py compile --in-channels=3 --in-width=32 --in-height=32 --init-features 32 --batch-size 1 --pef-name="unet_train" --output-folder=${OUTDIR}
srun python unet.py run --do-train --in-channels=3 --in-width=32 --in-height=32 --init-features 32 --batch-size 1 --data-dir $DATADIR --log-dir ${OUTDIR} --epochs 5 --pef=${OUTDIR}/unet_train/unet_train.pef
```

Run these commands for inference (compile + test +
measure-performance):

```bash
srun python unet.py compile --in-channels=3 --in-width=32 --in-height=32 --init-features 32 --batch-size=1 --inference --pef-name=unet_inf --default-par-factors --output-folder=${OUTDIR}
srun python unet.py run --do-train --in-channels=3 --in-width=32 --in-height=32 --init-features 32 --batch-size=1 --inference --pef=${OUTDIR}/unet_inf/unet_inf.pef --log-dir mylogs
srun python unet.py measure-performance --in-channels=3 --in-width=32 --in-height=32 --init-features 32 --batch-size=1 --inference --pef=${OUTDIR}/unet_inf/unet_inf.pef
```

Using SLURM :To use Slurm, create submit-unet-job.sh with the following
contents:

```bash
!/bin/sh
export OUTDIR=~/apps/image/pytorch/unet
export DATADIR=/var/tmp/kaggle_3m/
python unet.py compile --in-channels=3 --in-width=32 --in-height=32 --init-features 32 --batch-size 1 --pef-name="unet_train" --output-folder=${OUTDIR}
python unet.py run --do-train  --in-channels=3  --in-width=32  --in-height=32 --init-features 32 --batch-size=1? --data-dir $DATADIR --log-dir ${OUTDIR}/log_dir_unet32_train --epochs 5 --pef=${OUTDIR}/unet_train/unet_train.pef
python unet.py compile --in-channels=3  --in-width=32 --in-height=32 --init-features 32  --batch-size=1  --inference --pef-name=unet_inf  --default-par-factors --output-folder=${OUTDIR}
python unet.py run --do-train --in-channels=3 --in-width=32 --in-height=32 --init-features 32 --batch-size=1 --inference --pef=${OUTDIR}/unet_inf/unet_inf.pef --log-dir mylogs
python unet.py measure-performance  --in-channels=3 --in-width=32 --in-height=32  --init-features 32  --batch-size=1 --inference  --pef=${OUTDIR}/unet_inf/unet_inf.pef
```

Then

```bash
sbatch submit-unet-job.sh
```
