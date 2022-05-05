# DataParallel

## Login

Login by following the steps at [Getting Started](Logging-into-a-SambaNova-Node.md).

## Tutorial Files

ALCF provides a DataParallel tutorial at `/software/sambanova/apps/tutorials/sambanova_dataparallel`.  It is available from any Sambanova node.

This tutorial is for a feed forward network with logistic regression for the MNIST dataset.

Make a copy to your home directory:

```bash
cd ~/
cp -r /software/sambanova/apps/tutorials/sambanova_dataparallel .
```

## Change Directory

Change directory:

```bash
ALCFUserID@sm-01:~$ cd sambanova_dataparallel/
ALCFUserID@sm-01:~/sambanova_dataparallel$ 
```

## GPUs vs. RDUs

GPUs do not require a compile step.  RDUs do have a compile step.

**NOTE: RDUs require a** ***compile*** **step.**

## DataParallel Implementation

DataParallel is accomplished by running multiple copies of the model graph on
two or more RDUS and intelligently splitting the data pipeline across the copies.

## Compile_dataparallel.sh

The **compile_dataparallel.sh** script is an example of how to compile
a model for DataParallel execution.

A model must be compiled with the **--data-parallel** argument to run as DataParallel.

The **ws** argument is an abbreviation of **world size**. This flag defines the minimum
number of application replicas to be launched when training the model in data parallel mode.
For the purposes of compilation, its value can always be set to 2, as the actual number of
replicas to be launched will be defined at runtime.

The OMP_NUM_THREADS environment variable sets the number of threads to use for parallel
regions. The value of this environment variable must be a list of positive integer values.
The values of the list set the number of threads to use for parallel regions at the
corresponding nested levels.  Using '8' can make the compile faster and doesn't hurt anything
as compared to using '1'.

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
# -b is the local batch size.
python sn_boilerplate_main.py compile --data-parallel -ws 2 -b=1 --pef-name=sn_boilerplate --output-folder="pef"

echo "Duration: " $SECONDS
```

### Run_dataparallel.sh

The number of RDUs to be run in parallel is set by **mpirun**'s **--np** argument.
The run_dataparallel.sh script below uses **--np 2**.  This uses two RDUs with
a copy of the model on each RDU.

**NOTE: This example uses** ***MPI*** **so the value of** ***--np***
**must be equal to the value of** ***--gres=rdu:***.  **This example uses
'2' for both values.**

Run your model that was compiled with the **--data-parallel** argument.
The **run** command also requires the **--data-parallel** argument.

The **--reduce-on-rdu** argument causes the gradients to be reduced on the RDUs.
This is different from a GPU which must sync gradients on the host which takes longer.

**NOTE: The value of** ***-np*** **must be greater than or equal to** ***-ws.***

The **global batch size** is the value of **-b** from above times
the value of **--gres=rdu:**.  In this example it is 1 * 2.

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

## Sbatch

```bash
sbatch compile_dataparallel.sh
sbatch --gres=rdu:2 run_dataparallel.sh
```

The CLI argument **--gres=rdu:2** specifies that two copies
of the model are to be used for DataParallel.

You may view the ouput by running the following command:

```text
cat slurm-ddddd.out
```

where **ddddd** is your job id.
