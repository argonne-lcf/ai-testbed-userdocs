# Steps to Run a Model/Program

**NOTE:  Please be mindful of how you are using the system.
For example, run larger jobs in the evening or on weekends.**

## On-Boarding

See [Get Started](https://www.alcf.anl.gov/support-center/get-started )
to request an acccount and additional information.

## Introduction

The SambaNova workflow includes the following four steps to run a model.

## Compile

Compiles the model and generates a .pef file. This file contains
information on how to reconfigure the hardware like how many compute and
memory resources are required, and will be used in all subsequent steps.
The pef files are by default saved in the 'out' directory; the
SambaNova documentation advises saving pef files in separate
directories with the '--output-folder' option.

It is necessary to re-compile only when information specific to these
model's graph changes.  This includes batch size.  
Re-compiles are not necessary for other code changes.

Compile times can be significant.  
Unet for 32x32 pixels takes 358 (s).
And Unet for 256x256 pixels takes 1844 (s).

**Using the SLURM scheduling system and workload manager for running
jobs**

The system uses the [SLURM job
scheduler](https://slurm.schedmd.com/quickstart.html) to run jobs.

Example:

```bash
srun python myapp.py compile --pef-name="myapp.pef" --output-folder="pef"
```

## Run

This will run the application on SN nodes.

```bash
srun python myapp.py run --pef="pef/myapp/myapp.pef"
```
