# Steps to Run a Model/Program

**NOTE:  Please be mindful of how you are using the system.
For example, consider running larger jobs in the evening or on weekends.**

**NOTE: Please use only Slurm commands, i.e., srun and sbatch, to run your code.
If you run your code directly using the python command, it may cause conflicts
on the system.**

## Introduction

The system uses the [SLURM job
scheduler](https://slurm.schedmd.com/quickstart.html) to schedule the jobs and manage
the workload on the system. For more information on Slurm, see [Job Queueing and
Submission](Job-Queuing-and-Submission.md).

[Example Programs](Example-Programs.md) lists the different example applications with
corresponding commands for each of the above steps.

## Run

This will run the application on Habana node.

```bash
srun $PYTHON demo_mnist.py --hpu
```
