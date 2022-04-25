# DataParallel on the SambaNova DataScale SN10-8 System

## Boilerplate Files

This tutorial uses four boilerplate files:

1. sn\_boilerplate\_main.py;
    1. Contains main()

2. sn\_boilerplate\_args.py;
    1. Contains CLI args definitions

3. sn\_boilerplate\_model.py; and
    1. Contains AI model

4. sn\_boilerplate\_other.py.
    1. Contains train(), test(), and more

These boilerplate files are located at /software/sambanova/apps/tutorials/sambanova_starter.

These completed files are located at /software/sambanova/apps/tutorials/sambanova_dataparallel.

To copy the boilerplate files, log in to sm-01.  See [How to Setup Your Base Environment](How-to-setup-your-base-environment.md).

Then

```bash
cd ~
cp -r /software/sambanova/apps/tutorials/sambanova_dataparallel .
```

You are now ready to follow this tutorial.

**NOTE: The steps for this tutorial have already been completed.**

## Model Overview

The model predicts numerals in the MNIST dataset.

The network has a forward feed network followed by a logistics
regression network.

## Update sn\_boilerplate\_other.py

### Import

Import DistributedSampler .

```pytorch
from torch.utils.data.distributed import DistributedSampler
```

### Check for data\_parallel Argument

This code works either with DataParallel or without.  More specifically,
distributed data or without.  To accomplish this, utilize the
**--data-parallel** argument.

Create a DistributedSampler only if the **--data-parallel** argument is
specified.

DistributedSampler deals with the shuffling of the data so set shuffle
equal to False.

If not using DistributedSampler set **train\_sampler = None** and **shuffle =
True**.

```python
print(f'DataParallel run: {args.data_parallel}')

if args.data_parallel:
    # Sampler defines the strategy to draw samples from the dataset.
    # If specified, shuffle must not be specified.  https://pytorch.org/docs/stable/data.html
    train_sampler = DistributedSampler(train_dataset)
    shuffle = False
else:
    train_sampler = None
    shuffle = True
```

### DataLoader

When setting up the DataLoader, there are a couple of things to add
versus not using a DataLoader.  We now have number of workers equals to
one. And also added sampler=train\_sampler.

Use the shuffle variable from above.  And set drop\_last=True.  This is
just in case that the size of the data set is not a multiple of the
batch size.

Also add drop\_last=True for the test\_loader.

```python
    # Data loader (input pipeline)
    train_loader = torch.utils.data.DataLoader( dataset=train_dataset,
                                                num_workers=1,
                                                sampler=train_sampler,
                                                batch_size=args.batch_size,
                                                shuffle=shuffle,
                                                drop_last=True
                                                )

    test_loader = torch.utils.data.DataLoader(  dataset=test_dataset,
                                                batch_size=args.batch_size,
                                                shuffle=False,
                                                drop_last=True
                                                )
```

### Train Method

Add these two lines:

```python
                                                data_parallel=args.data_parallel,
                                                reduce_on_rdu=args.reduce_on_rdu)
```

to get:

```python
            loss, outputs = samba.session.run(  input_tensors=[sn_images, sn_labels],
                                                output_tensors=model.output_tensors,
                                                hyperparam_dict=hyperparam_dict,
                                                data_parallel=args.data_parallel,
                                                reduce_on_rdu=args.reduce_on_rdu)
```

These arguments are added automatically.  You do not need to modify your args file.

### DataParallel

So where do we actually use **nn.DataParallel**?  The answer is we don't.
SambaNova has taken care of all of this in the background.  All we have
to do is use **DistributedSampler** and everything else is automatic.

The other three files do not need to be modified.

### Shell Scripts

Let's take a look at the shell scripts that we will be using.

#### Compile Script

Here we have the compile script, **compile_dataparallel.sh**.

```bash
#!/bin/bash
export OMP_NUM_THREADS=8
source /opt/sambaflow/venv/bin/activate
#######################
# Run script
# sbatch compile_dataparallel.sh
#######################
# Start script timer
SECONDS=0

echo "COMPILE"
# -b is the batch size.
python sn_boilerplate_main.py compile --data-parallel -ws 2 -b=1 --pef-name=sn_boilerplate --output-folder="pef"

echo "Duration: " $SECONDS
```

Let's take a look at the second line here.  We're setting
OMP\_NUM\_THREADS equals to eight.  So this is done so that we have more
threads so that the compilation of the script occurs more quickly.

On line number thirteen, we're going to use the compile argument to compile
the model.

On line number fifteen, we're going to go ahead and echo how long the compile
took.

#### Run Script

Here is the run script, **run.sh**.  It does compile and run.
This script just does a standard run.  It does
not use data parallel or the distributed sampler.

```bash
#!/bin/sh
#######################
# Run script
# sbatch run.sh
#######################

# -b is the batch size.
python sn_boilerplate_main.py compile -b=1 --pef-name="sn_boilerplate" --output-folder="pef"
python sn_boilerplate_main.py run --pef="pef/sn_boilerplate/sn_boilerplate.pef"
```

#### Slurm

When you start Slurm and you want to use more than one RDU, you should tell
Slurm how many RDUs you desire.  Do this by using the **gres** CLI
argument.  Then the number of RDUs that you want to use.

Here we are requesting two RDUs.  This number should match the mpirun
argument np.  In run\_dataparallel.sh below, np is also two.

```bash
sbatch --gres=rdu:2 run_dataparallel.sh
```

#### Run DataParallel Script

There is more information in here than in the previous scripts.

We're going to go ahead and name the model on line thirteen.

|                                |
| ------------------------------ |
| **Note:  Compile Separately.** |

We're going to be using mpirun.  Use the np argument to specify the
number of processors as two, and then we go ahead and execute our
script.  Use **run**, it is used for training, with the **data-parallel**
argument, and also the **reduce-on-rdu** argument.  Then specify the
location of the pef file

Let's take a look at the next command.  So the next command is pretty
much the same, except for we're going to use measure-performance
command.

```bash
#!/bin/bash
# Stop on error
set -e
# Print commands
set -x

#######################
# Run script
# sbatch --gres=rdu:2 run_dataparallel.sh
#######################
# Edit these variables.
#######################
MODEL_NAME="FFNLogReg"
#######################
# Start script timer
SECONDS=0

echo "Model: ${MODEL_NAME}"
echo "Date: " $(date +%m/%d/%y)
echo "Time: " $(date +%H:%M)

echo "COMPILE separately using compile_dataparallel.sh!!"

echo "RUN"
/opt/mpich-3.3.2/bin/mpirun -np 2 python sn_boilerplate_main.py run --data-parallel --reduce-on-rdu --pef=pef/sn_boilerplate/sn_boilerplate.pef

echo "Duration: " $SECONDS
```

### Tile Affinity

The correct place to use the tile affinity would be on the command
line.  If you were to use the tile affinity within Slurm, if somebody
else was already using those RDUs, your job would fail.

Here we are specifying tiles six and seven.  They are zero index.

```bash
export SF_RNT_TILE_AFFINITY=0xff000000
```

## Slurm

### Data-Parallel

```bash
sbatch compile_dataparallel.sh
sbatch --gres=rdu:2 run_dataparallel.sh
```

### Regular Run

|               |
| ------------- |
| sbatch run.sh |
