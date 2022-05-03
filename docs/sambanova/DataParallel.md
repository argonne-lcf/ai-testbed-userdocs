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

## DataParallel Implementation

DataParallel is implemented on this system by copying a model to
N RDUs then splitting the data across the N RDUs.

## Compile_dataparallel.sh

A model must be compiled with the **--data-parallel** argument to run as DataParallel.

**NOTE: The value of the argument** ***-ws 2*** **must match the value of the argument**
***-np 2*** **in the** ***mpirun*** **command in the run script.  In this example '2'.**

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

### Run_dataparallel.sh

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
