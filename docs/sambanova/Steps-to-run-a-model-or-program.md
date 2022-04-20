# Steps to Run a Model/Program

**NOTE:  Please be mindful of how you are using the system.
For example, run larger jobs in the evening or on weekends.**

## On-Boarding

See [Get Started](https://www.alcf.anl.gov/support-center/get-started )
to request an acccount and additional information.

## Introduction

The SambaNova workflow includes the following main steps to run a model.

TODO Use existing sample.

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
srun python myapp.py compile --pef-name="myapp.pef" --output-folder="pef"
```

## Run

This will run the application on SN nodes.

```bash
srun python myapp.py run --pef="pef/myapp/myapp.pef"
```
