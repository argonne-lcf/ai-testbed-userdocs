# Steps to Run a Model/Program

**NOTE:  Please be mindful of how you are using the system.
For example, run larger jobs in the evening or on weekends.**

**NOTE: Please use only Slurm commands, i.e., srun and sbatch, to run your code.
If you run your code directly using the python command, it may cause conflicts
on the system.**

## Introduction

The SambaNova workflow includes the following main steps to run a model.

For additional information, see [Example Programs](Example-Programs.md).

## Compile

Compiles the model and generates a .pef file. This file contains
information on how to reconfigure the hardware, as to how many compute and
memory resources are required and how it will be used in all subsequent steps.
The pef files are by default saved in the 'out' directory; the
SambaNova documentation advises to save pef files in separate
directories with the '--output-folder' option.

It is necessary to re-compile only when parameters specific to the
model graph changes, including the batch size.  

Compile times can be significant.  
Unet for example, when using images of size 32x32 pixels takes 358 (s), while a 256x256 image takes 1844 (s).

**Using the SLURM scheduling system and workload manager for running
jobs**

The system uses the [SLURM job
scheduler](https://slurm.schedmd.com/quickstart.html) to run jobs.

Example:

```bash
srun python lenet.py compile -b=1 --pef-name="lenet" --output-folder="pef"
```

Where

| Argument               | Default   | Help                           |
|------------------------|-----------|--------------------------------|
| -b                     | 1         | Batch size for training        |
|                        |           |                                |

## Run

This will run the application on SN nodes.

```bash
srun python lenet.py run --pef="pef/lenet/lenet.pef"
```

The location of the **pef** file is specified by:

```bash
--pef="<output-folder>/<script name>/<script name>.pef"
```

where the **output-folder** was specified in the **compile** command above.

## Test (Optional)

This command is used to run the model on both the host CPU and the SambaNova node.  It compares the answers from the CPU and SambaNova RDU and will raise errors if any discrepancies are found. Pass the pef file generated as part of the compile step as the input to this command.

```bash
srun python lenet.py test --pef="pef/lenet/lenet.pef"
```

For more information, see [Job Queueing and Submission](Job-Queuing-and-Submission.md)
