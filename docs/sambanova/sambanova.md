# SambaNova

-   [Getting Started](#SambaNova-GettingStarted)

    -   [Setup](#SambaNova-Setup)

        -   [Aliases](#SambaNova-Aliases)

        -   [Overview](#SambaNova-Overview)

            -   [Compile](#SambaNova-Compile)

            -   [Test (optional)](#SambaNova-Test(optional))

            -   [Run](#SambaNova-Run)

            -   [Measure Performance](#SambaNova-MeasurePerformance)

        -   [Copy Examples](#SambaNova-CopyExamples)

        -   [MNIST Using Feed Forward Network,
            Etc.](#SambaNova-MNISTUsingFeedForwardNetwork,)

        -   [Logistic Regression](#SambaNova-LogisticRegression)

        -   [UNet](#SambaNova-UNet)

-   [PyTorch Mirrors](#SambaNova-PyTorchMirrors)

-   [Further Information](#SambaNova-FurtherInformation)

-   [Creating a SambaNova Portal Account to access the documentation
    portal ](#SambaNova-CreatingaSambaNovaPortalAccou)

## Accounts

Get an account on the SambaNova (SN) system. Contact <support@alcf.anl.gov> for access.

## Setup

You will first need to login to one of the CELS machines.

```bash
ssh homes-gce
```

alternatively,

```bash
ssh ___ANL_username___@homes.cels.anl.gov
```

You will automatically be logged in if you have done this before. Use
the ssh \"-v\" switch to debug ssh problems.

### Aliases

The SambaNova system that has 2 nodes sm-01 and sm-02. Host names for
SambaNova are [sm-01.cels.anl.gov](http://sm-01.cels.anl.gov) and [sm-02.cels.anl.gov](http://sm-02.cels.anl.gov)

This would be good to put into your homes computer .bashrc file.  Or,
execute them from the command line.

```bash
alias sm1='ssh sm-01.cels.anl.gov'
alias sm2='ssh sm-02.cels.anl.gov'
```

Now

```text
source .bashrc
sm1
 ___your_username___@sm-01.cels.anl.gov's password: < MobilPass+ code >
```

These four commands could be put into your .bashrc file on a SambaNova
node. 

They can also be executed from the command line.

```bash
alias snpath='export PATH=$PATH:/opt/sambaflow/bin'
alias snthreads='export OMP_NUM_THREADS=1'
alias snvenv='source /opt/sambaflow/venv/bin/activate'
alias snp='snpath;snthreads;snvenv'
```

New ssh connections will run .bashrc. The first time it is created, you
can 

```bash
source .bashrc
```

or just log out and then ssh back in to sm-01.

Next, activate the SambaNova virtual environment.

```bash
snp
(venv) < your ANL username >@sm-01:~$
```

**NOTE:  SambaNova operations will fail unless the SambaNova venv is set
up.**

You may deactivate the environment if finished.

```bash
deactivate
```

SambaNova-supplied Examples

### Overview

The workflow includes the following four steps to run a model.

#### Compile

Compiles the model and generates a .pef file. This file contains
information on how to reconfigure the hardware like how many compute and
memory resources are required, and will be used in all subsequent steps.
The pef files are by default saved in the \'out\' directory; the
SambaNova documentation advises to save pef files in separate
directories with the \'\--output-folder\' option.

Example:

```bash
srun python myapp.py compile --pef-name="myapp.pef" --output-folder="pef"
```

#### Test (optional)

Runs the model on both the host CPU and the SambaNova node.  It compares
the answers from the CPU and SambaNova RDU and will raise errors if any
discrepancies are found. Pass the pef file generated above as the input.

```bash
srun python myapp.py test --pef="out/myapp/myapp.pef"
```

#### Run

This will run the application on SN nodes.

```bash
srun python myapp.py run --pef="out/myapp/myapp.pef"
```

#### Measure Performance

This step will report the measured performance. The parameters depend on
the model and can include latency, samples/sec.

```bash
srun python myapp.py measure-performance --pef="out/myapp/myapp.pef
```

**Using the SLURM scheduling system and workload manager for running
jobs**

The system uses the [SLURM job
scheduler](https://slurm.schedmd.com/quickstart.html) to run jobs. 

### Copy Examples

Copy starters to your personal directory structure:

```bash
cd ~/
cp -r /opt/sambaflow/apps/ .
```

#### LeNet

Change directory

```bash
cd ~/apps/starters/pytorch/
```

**Arguments**

This is not an exhaustive list of arguments.

Arguments

| Argument               | Default   | Help                           |
|------------------------|-----------|--------------------------------|
| --b                    | 1         | Batch size for training        |
|                        |           |                                |
| \--mb                  | None      | Microbatch size for training   |
|                        |           |                                |
|                        |           | **Note: Do not use or set only |
|                        |           | to 1.**                        |
|                        |           |                                |
| \--lr                  | 0.01      | Learning rate for training     |
|                        |           |                                |
| \--momentum            | 0.0       | Momentum value for training    |
|                        |           |                                |
| \--weight-decay        | 0.01      | Weight decay for training      |
|                        |           |                                |
| \-n,                   | 100       | Number of iterations to run    |
| \--num-iterations      |           | the pef for                    |
|                        |           |                                |
| \-e,                   | 1         | Number epochs for training     |
| \--num-epochs          |           |                                |
|                        |           |                                |
| \--log-path            | 'check    | Log path                       |
|                        | points'   |                                |
|                        |           |                                |
| \--data-path           | './data'  | Data path                      |
|                        |           |                                |
|                        |           |                                |
| \--num-workers         | 0         | Number of workers              |
|                        |           |                                |
| \--measure-train-      | None      | Measure training performance   |
| performance            |           |                                |
|                        |           |                                |
| \--data-folder         | 'mnist_   | Folder containing mnist data   |
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

Log ID initialized to: [wilsonb][python][53607] at
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

**LeNet3D**

Change directory (if necessary)

```bash
cd ~/apps/starters/pytorch/
```

LeNet3D does compile but its "run" command is missing data at this
time.

```bash
srun python lenet3d.py compile --pef-name=lenet3d
srun python lenet3d.py test -p out/lenet3d/lenet3d.pef
srun python lenet3d.py measure-performance -p out/lenet3d/lenet3d.pef
```


**MNIST Using Feed Forward Network**

Change directory (if necessary)

```bash
```

\$ cd \~/apps/starters/pytorch/

**Arguments**

This is not an exhaustive list of arguments.

Arguments

  --------------------------------------------------------------------------
  **Argument**            **Default**   **Help**
  ----------------------- ------------- ------------------------------------
  \--lr                   0.001         Learning rate for training

  \--momentum             0.0           Momentum value for training

  \--weight-decay         1e-4          Weight decay for training

  -e or \--num-epochs     1             Number epochs for training
  --------------------------------------------------------------------------

Run these commands:

```bash
```

\srun python ffn_mnist.py compile \--pef-name=\"ffn_mnist\"
\--output-folder=\"pef\"

\srun python ffn_mnist.py test \--pef=\"pef/ffn_mnist/ffn_mnist.pef\"

\srun python ffn_mnist.py run \--pef=\"pef/ffn_mnist/ffn_mnist.pef\"

\srun python ffn_mnist.py measure-performance
\--pef=\"pef/ffn_mnist/ffn_mnist.pef\"

To use Slurm, create submit-ffn_mnist-job.sh with the following
contents:

```bash
#!/bin/sh

python ffn_mnist.py compile \--pef-name=\"ffn_mnist\"
\--output-folder=\"pef\"

python ffn_mnist.py test \--pef=\"pef/ffn_mnist/ffn_mnist.pef\"

python ffn_mnist.py run \--pef=\"pef/ffn_mnist/ffn_mnist.pef\"

python ffn_mnist.py measure-performance
\--pef=\"pef/ffn_mnist/ffn_mnist.pef\"
```

Then

```bash
\sbatch \--output=pef/ffn_mnist/output.log submit-ffn_mnist-job.sh
```

Squeue will give you the queue status.

```bash
\squeue
```

The output file, pef/ffn_mnist/output.log, will look something like:

pef/ffn_mnist/output.log

\[Info\]\[SAMBA\]\[Default\] \# Placing log files in
pef/ffn_mnist/ffn_mnist.samba.log\
\[Info\]\[MAC\]\[Default\] \# Placing log files in
pef/ffn_mnist/ffn_mnist.mac.log\
\[Warning\]\[SAMBA\]\[Default\] \#\
\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--\
Using patched version of torch.cat and torch.stack\
\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

\[Warning\]\[SAMBA\]\[Default\] \# The dtype of \"targets\" to
CrossEntropyLoss is torch.int64, however only int16 is currently
supported, implicit conversion will happen\
\[Warning\]\[MAC\]\[MemoryOpTransformPass\] \# Backward graph is trimmed
according to requires_grad to save computation.\
\[Warning\]\[MAC\]\[WeightShareNodeMergePass\] \# Backward graph is
trimmed according to requires_grad to save computation.\
\[Warning\]\[MAC\]\[ReduceCatFaninPass\] \# Backward graph is trimmed
according to requires_grad to save computation.\
\[info \] \[PLASMA\] Launching plasma compilation! See log file:
/lambda_stor/homes/wilsonb/apps/starters/pytorch/pef/ffn_mnist//ffn_mnist.plasma_compile.log\
Prism report not available\
Pef file
/lambda_stor/homes/wilsonb/apps/starters/pytorch/pef/ffn_mnist/ffn_mnist.pef
created\
\[info\] Run A Round of PerOp Pass: iter 0\
\[info\] We run 1 iterations of PerOp transformation totally.\
\[info\] Compilation succeeded.\
\[Warning\]\[SAMBA\]\[Default\] \#\
\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--\
Using patched version of torch.cat and torch.stack\
\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

\[Warning\]\[SAMBA\]\[Default\] \# The dtype of \"targets\" to
CrossEntropyLoss is torch.int64, however only int16 is currently
supported, implicit conversion will happen\
samba: tensor(1.2188)\
samba.SambaTensor(name:
ffnlogreg\_\_logreg\_\_criterion\_\_crossentropyloss\_\_outputs\_\_0,
shape: torch.Size(\[\]), dtype: torch.float32,\
batch_dim: None, named_dims: (), keep_data: True, materializer_provided:
False)\
gold: tensor(1.2095, grad_fn=\<NllLossBackward>)\
samba.SambaTensor(name: sambatensor_140554762586704, shape:
torch.Size(\[\]), dtype: torch.float32,\
batch_dim: None, named_dims: (), keep_data: True, materializer_provided:
False)\
samba: tensor(\[\[ 1.8516, 0.1934, -1.4141, -0.3281, 0.8945, 0.6797,
0.7031, -1.8984,\
-0.2090, 1.8984\]\])\
samba.SambaTensor(name:
ffnlogreg\_\_logreg\_\_lin_layer\_\_linear\_\_outputs\_\_0, shape:
torch.Size(\[1, 10\]), dtype: torch.float32,\
batch_dim: None, named_dims: (None, None), keep_data: True,
materializer_provided: False)\
gold: tensor(\[\[ 1.8645, 0.1935, -1.4266, -0.3330, 0.9037, 0.6794,
0.7048, -1.9099,\
-0.2141, 1.9202\]\], grad_fn=\<MmBackward>)\
samba.SambaTensor(name: sambatensor_140554762587664, shape:
torch.Size(\[1, 10\]), dtype: torch.float32,\
batch_dim: None, named_dims: (None, None), keep_data: True,
materializer_provided: False)\
2021-6-10 14:54:47 : \[INFO\]\[SC\]\[74527\]: SambaConnector: PEF File:
pef/ffn_mnist/ffn_mnist.pef\
Log ID initialized to: \[wilsonb\]\[python\]\[74527\] at
/var/log/sambaflow/runtime/sn.log\
\[Warning\]\[SAMBA\]\[Default\] \#\
\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--\
Using patched version of torch.cat and torch.stack\
\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

\[Warning\]\[SAMBA\]\[Default\] \# The dtype of \"targets\" to
CrossEntropyLoss is torch.int64, however only int16 is currently
supported, implicit conversion will happen\
Epoch \[1/1\], Step \[10000/60000\], Loss: 0.5563\
Epoch \[1/1\], Step \[20000/60000\], Loss: 0.4374\
Epoch \[1/1\], Step \[30000/60000\], Loss: 0.3832\
Epoch \[1/1\], Step \[40000/60000\], Loss: 0.3479\
Epoch \[1/1\], Step \[50000/60000\], Loss: 0.3222\
Epoch \[1/1\], Step \[60000/60000\], Loss: 0.3028\
Test Accuracy: 94.50 Loss: 0.1905\
2021-6-10 14:54:49 : \[INFO\]\[SC\]\[74554\]: SambaConnector: PEF File:
pef/ffn_mnist/ffn_mnist.pef\
Log ID initialized to: \[wilsonb\]\[python\]\[74554\] at
/var/log/sambaflow/runtime/sn.log

### MNIST Using **Feed Forward Network, Etc.**

Feed Forward Network with two different activation functions and a
residual connection.

Change directory (if necessary)

```bash
cd ~/apps/starters/pytorch/
```

Run these commands:

```bash
srun python res_ffn_mnist.py compile --pef-name="res_ffn_mnist"
--output-folder="pef"
srun python res_ffn_mnist.py test
--pef="pef/res_ffn_mnist/res_ffn_mnist.pef"
srun python res_ffn_mnist.py run
--pef="pef/res_ffn_mnist/res_ffn_mnist.pef"
srun python res_ffn_mnist.py measure-performance
--pef="pef/res_ffn_mnist/res_ffn_mnist.pef"
```

To use Slurm, create submit-res_ffn_mnist-job.sh with the following
contents:

```bash
#!/bin/sh

python res_ffn_mnist.py compile --pef-name="res_ffn_mnist"
--output-folder="pef"

python res_ffn_mnist.py test
--pef="pef/res_ffn_mnist/res_ffn_mnist.pef"

python res_ffn_mnist.py run
--pef="pef/res_ffn_mnist/res_ffn_mnist.pef"

python res_ffn_mnist.py measure-performance
--pef="pef/res_ffn_mnist/res_ffn_mnist.pef"
```

Then

```bash
sbatch --output=pef/res_ffn_mnist/output.log
submit-res_ffn_mnist-job.sh
```

Squeue will give you the queue status.

```bash
squeue
```

The output file, pef/res_ffn_mnist/output.log, will look something like:

pef/res_ffn_mnist/output.log

\[Info\]\[SAMBA\]\[Default\] \# Placing log files in
pef/res_ffn_mnist/res_ffn_mnist.samba.log\
\[Info\]\[MAC\]\[Default\] \# Placing log files in
pef/res_ffn_mnist/res_ffn_mnist.mac.log\
\[Warning\]\[SAMBA\]\[Default\] \#\
\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--\
Using patched version of torch.cat and torch.stack\
\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

\[Warning\]\[SAMBA\]\[Default\] \# The dtype of \"targets\" to
CrossEntropyLoss is torch.int64, however only int16 is currently
supported, implicit conversion will happen\
\[Warning\]\[MAC\]\[MemoryOpTransformPass\] \# Backward graph is trimmed
according to requires_grad to save computation.\
\[Warning\]\[MAC\]\[WeightShareNodeMergePass\] \# Backward graph is
trimmed according to requires_grad to save computation.\
\[Warning\]\[MAC\]\[ReduceCatFaninPass\] \# Backward graph is trimmed
according to requires_grad to save computation.\
\[info \] \[PLASMA\] Launching plasma compilation! See log file:
/lambda_stor/homes/wilsonb/apps/starters/pytorch/pef/res_ffn_mnist//res_ffn_mnist.plasma_compile.log\
Prism report not available\
Pef file
/lambda_stor/homes/wilsonb/apps/starters/pytorch/pef/res_ffn_mnist/res_ffn_mnist.pef
created\
\[info\] Run A Round of PerOp Pass: iter 0\
\[info\] We run 1 iterations of PerOp transformation totally.\
\[info\] Compilation succeeded.

\...

\[Warning\]\[SAMBA\]\[Default\] \# The dtype of \"targets\" to
CrossEntropyLoss is torch.int64, however only int16 is currently
supported, implicit conversion will happen

Epoch \[1/1\], Step \[10000/60000\], Loss: 0.5834\
Epoch \[1/1\], Step \[20000/60000\], Loss: 0.5559\
Epoch \[1/1\], Step \[30000/60000\], Loss: 0.5428\
Epoch \[1/1\], Step \[40000/60000\], Loss: 0.5282\
Epoch \[1/1\], Step \[50000/60000\], Loss: 0.5181\
Epoch \[1/1\], Step \[60000/60000\], Loss: 0.5086\
Test Accuracy: 90.66 Loss: 0.4340

\...

e2e_throughput: 1898.6569130275361 samples/s, measured over 100
iterations. Average latency: 0.0005266880989074707 s.\
e2e_latency: 0.05266880989074707 s\
2021-6-11 7:58:4 : \[INFO\]\[SC\]\[98357\]: SambaConnector: PEF File:
pef/res_ffn_mnist/res_ffn_mnist.pef\
Log ID initialized to: \[wilsonb\]\[python\]\[98357\] at
/var/log/sambaflow/runtime/sn.log

### Logistic Regression

Change directory (if necessary)

```bash
```

\$ cd \~/apps/starters/pytorch/

**Arguments**

This is not an exhaustive list of arguments.

Arguments

  -----------------------------------------------------------------------------
  **Argument**          **Default**   **Help**                       **Step**
  --------------------- ------------- ------------------------------ ----------
  \--lr                 0.001         Learning rate for training     Compile

  \--momentum           0.0           Momentum value for training    Compile

  \--weight-decay       1e-4          Weight decay for training      Compile

  \'-e\',               1             Number epochs for training     Compile
  \'\--num-epochs\'

  \'\--num-features\'   784           Number features for training   Compile

  \--num-classes        10            Number classes for training    Compile

  \--weight-norm        na            Enable weight normalization    Compile
  -----------------------------------------------------------------------------

Run these commands:

```bash
srun python logreg.py compile --pef-name="logreg"
--output-folder="pef"
srun python logreg.py test --pef="pef/logreg/logreg.pef"
srun python logreg.py run --pef="pef/logreg/logreg.pef"
srun python logreg.py measure-performance
--pef="pef/logreg/logreg.pef"
```

To use Slurm, create submit-logreg-job.sh with the following contents:

```bash
#!/bin/sh
python logreg.py compile --pef-name="logreg" --output-folder="pef"
python logreg.py test --pef="pef/logreg/logreg.pef"
python logreg.py run --pef="pef/logreg/logreg.pef"
python logreg.py measure-performance --pef="pef/logreg/logreg.pef"
```


Then

```bash
sbatch --output=pef/logreg/output.log submit-logreg-job.sh
```

Squeue will give you the queue status.

```bash
\squeue
```

The output file, pef/logreg/output.log, will look something like:

pef/logreg/output.log

\[Info\]\[SAMBA\]\[Default\] \# Placing log files in
pef/logreg/logreg.samba.log\
\[Info\]\[MAC\]\[Default\] \# Placing log files in
pef/logreg/logreg.mac.log\
\[Warning\]\[SAMBA\]\[Default\] \#\
\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--\
Using patched version of torch.cat and torch.stack\
\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

\[Warning\]\[SAMBA\]\[Default\] \# The dtype of \"targets\" to
CrossEntropyLoss is torch.int64, however only int16 is currently
supported, implicit conversion will happen\
\[Warning\]\[MAC\]\[MemoryOpTransformPass\] \# Backward graph is trimmed
according to requires_grad to save computation.\
\[Warning\]\[MAC\]\[WeightShareNodeMergePass\] \# Backward graph is
trimmed according to requires_grad to save computation.\
\[Warning\]\[MAC\]\[ReduceCatFaninPass\] \# Backward graph is trimmed
according to requires_grad to save computation.\
\[info \] \[PLASMA\] Launching plasma compilation! See log file:
/lambda_stor/homes/wilsonb/apps/starters/pytorch/pef/logreg//logreg.plasma_compile.log\
\...

\[Warning\]\[SAMBA\]\[Default\] \# The dtype of \"targets\" to
CrossEntropyLoss is torch.int64, however only int16 is currently
supported, implicit conversion will happen\
Epoch \[1/1\], Step \[10000/60000\], Loss: 0.4763\
Epoch \[1/1\], Step \[20000/60000\], Loss: 0.4185\
Epoch \[1/1\], Step \[30000/60000\], Loss: 0.3888\
Epoch \[1/1\], Step \[40000/60000\], Loss: 0.3721\
Epoch \[1/1\], Step \[50000/60000\], Loss: 0.3590\
Epoch \[1/1\], Step \[60000/60000\], Loss: 0.3524\
Test Accuracy: 90.07 Loss: 0.3361\
2021-6-11 8:38:49 : \[INFO\]\[SC\]\[99185\]: SambaConnector: PEF File:
pef/logreg/logreg.pef\
Log ID initialized to: \[wilsonb\]\[python\]\[99185\] at
/var/log/sambaflow/runtime/sn.log

### **UNet**

Change directory

```bash
cd \~/apps/image/pytorch/unet
export OUTDIR=\~/apps/image/pytorch/unet
export DATADIR=/var/tmp/kaggle_3m/
```

Export the path to the dataset which is required for the training.

Run these commands for training (compile + train):

```bash
srun python unet.py compile --in-channels=3 --in-width=32 --in-height=32 --init-features 32 --batch-size 1 --pef-name="unet_train" --output-folder=${OUTDIR}
srun python unet.py run --do-train --in-channels=3 --in-width=32 --in-height=32 --init-features 32 --batch-size=1 --data-dir $DATADIR --log-dir ${OUTDIR} log_dir_unet32_train --epochs 5 --pef=${OUTDIR}/unet_train/unet_train.pef
```

Run these commands for inference (compile + test +
measure-performance): 

```bash
srun python unet.py compile --in-channels=3 --in-width=32 --in-height=32 --init-features 32 --batch-size=1 --inference --pef-name=unet_inf --default-par-factors --output-folder=${OUTDIR}
srun python unet.py measure-performance --in-channels=3 --in-width=32 --in-height=32 --init-features 32 --batch-size=1 --inference --pef=${OUTDIR}/unet_inf/unet_inf.pef
```

Using SLURM :To use Slurm, create submit-unet-job.sh with the following
contents:

```bash
#!/bin/sh
export OUTDIR=~/apps/image/pytorch/unet
export DATADIR=/var/tmp/kaggle_3m/
python unet.py compile --in-channels=3 --in-width=32 --in-height=32 --init-features 32 --batch-size 1 --pef-name="unet_train" --output-folder=${OUTDIR}
python unet.py run --do-train  --in-channels=3  --in-width=32  --in-height=32 --init-features 32 --batch-size=1? --data-dir $DATADIR --log-dir ${OUTDIR}/log_dir_unet32_train --epochs 5 --pef=${OUTDIR}/unet_train/unet_train.pef
python unet.py compile --in-channels=3  --in-width=32 --in-height=32 --init-features 32  --batch-size=1  --inference --pef-name=unet_inf  --default-par-factors --output-folder=${OUTDIR}
python unet.py measure-performance  --in-channels=3 --in-width=32 --in-height=32  --init-features 32  --batch-size=1 --inference  --pef=${OUTDIR}/unet_inf/unet_inf.pef
```


Then

```bash
sbatch submit-unet-job.sh
```

Squeue will give you the queue status.

```bash
squeue
```

The output file will look something like:

pef/logreg/output.log

 

# PyTorch Mirrors

See <https://github.com/pytorch/examples> .

There are two mirrors (in the python docs) used for downloading the
mnist dataset.

mirrors = \[

        \'http://yann.lecun.com/exdb/mnist/\',

        \'https://ossci-datasets.s3.amazonaws.com/mnist/\'\]

[yann.lecun.com](http://yann.lecun.com) appears to be intermittently 
broken (503 errors).

Resources

-   <https://docs.ai.alcf.anl.gov/sambanova/>

-   [Argonne
    SambaNova-Training-June2021](https://anl.app.box.com/s/5rtxss0avxyflg8e19xumxinm485y135/folder/13988691568)

-   [Argonne SambaNova Training
    11/20](https://anl.app.box.com/s/bqc101mvt3r7rpxbd2yxjsf623ea3gpe)

-   [https://docs.sambanova.ai](https://docs.sambanova.ai/) Create a
    SambaNova account if you do not have one.

-   [Getting Started with
    SambaFlow](https://docs.sambanova.ai/sambanova-docs/1.6/developer/getting-started.html)
    Skip this one.

-   [Tutorial: Creating Models with
    SambaFlow](https://docs.sambanova.ai/sambanova-docs/1.6/developer/intro-tutorial.html)

-   Administrators

    -   \@ryade

# Further Information

[Human Decisions Files notes](/display/AI/Human+Decisions+Files+notes)

# Creating a SambaNova Portal Account to access the documentation portal 

1.  Go to  [login.sambanova.ai](http://login.sambanova.ai/);

2.  Select the \"Sign up\" link at the bottom;

3.  Enter your information

    1.  Your ANL email address;

    2.  A password that you choose to access the site;

    3.  First name;

    4.  Last name;

    5.  Alternate email address;

    6.  Use 64693137 for the CLOUD ID;

    7.  Select \"Register\" button;

    8.  Note: The new web page may be displaying a QR code.  Do not
        navigate away from it.  Please edit this page to describe what
        happenes for you.

4.  Verify your email address

    1.  Open your ANL email;

    2.  Open the email from Okta;

    3.  Select the \"Activate Account\" button;

    4.  Select the \"Configure factor\" button on the displayed web
        page;

    5.  Select either iPhone or Android for the device time on the new
        web page;

    6.  Install Okta Verify from the App Store/Google Play Store onto
        your mobile device.;

    7.  Select \"Next\" button on the web page;

5.  On your phone

    1.  Open Okta Verify app;

    2.  Select \"Get Started\" button;

    3.  Select \"Next\" button;

    4.  Select \"Add Account\" button;

    5.  Select \"Organization\" for Account Type;

    6.  Scan the QR Code shown in the browser;

6.  Sign in to the SambaNova web site

    1.  Select the \"SambaNova Documentation\" button.

Authorization for sections of the SambaNova site uses the tuple (email
address, cloud id). For ANL users, th*ese **should** be an anl email
address and the cloud id specified above (64693137). * (Note: the cloud
id can be changed in the SambaNova user settings.)\
**If you are not at Argonne, please send us an email (ai\@alcf.anl.gov)
for access. **

If you plan to publish, say to a conference, workshop or journal, we
have a review process wherein you share the draft with us
(pre-submission) at <ai@alcf.anl.gov> and we
will work with Sambanova for the requisite approvals.
