# Steps to run a model/program

## On-Boarding

See https://www.alcf.anl.gov/support-center/get-started 
to request an acccount and additional information.

## Introduction

The SambaNova workflow includes the following four steps to run a model.

## Compile

## TODO Use SN description of pef files here

Compiles the model and generates a .pef file. This file contains
information on how to reconfigure the hardware like how many compute and
memory resources are required, and will be used in all subsequent steps.
The pef files are by default saved in the 'out' directory; the
SambaNova documentation advises to save pef files in separate
directories with the '--output-folder' option.

## TODO explain when it is necessary to re-compile

## TODO explain How long to compile the model

## TODO why are we using srun

Example:

```bash
srun python myapp.py compile --pef-name="myapp.pef" --output-folder="pef"
```

## Move Test

## Run

This will run the application on SN nodes.

```bash
srun python myapp.py run --pef="pef/myapp/myapp.pef"
```

## TODO move measure performance 

**Using the SLURM scheduling system and workload manager for running
jobs**

The system uses the [SLURM job
scheduler](https://slurm.schedmd.com/quickstart.html) to run jobs.
