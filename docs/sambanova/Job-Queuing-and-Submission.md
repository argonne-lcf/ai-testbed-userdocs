# Job Queueing and Submission

## Introduction

**Habana** uses **Slurm** for job submission and queueing. Below are some of the important commands for using Slurm. For more information refer to [Slurm Documentation](https://slurm.schedmd.com/).

Note: Run the python scripts using srun or sbatch, to ensure that concurrent jobs do not interfere with each other.

## Srun

The Slurm command `srun` can be used to run individual python scripts in parallel with other scripts on a cluster managed by Slurm. Examples of `srun` usage are shown below.

```bash
srun python lenet.py compile -b=1 --pef-name="lenet" --output-folder="pef"
srun python lenet.py test --pef="pef/lenet/lenet.pef"
srun python lenet.py run --pef="pef/lenet/lenet.pef"
```

## Sbatch

Alternatively, these jobs can be submitted to the Slurm workload manager through a batch script by using `sbatch` command. To do this, create a bash script (submit-lenet-job.sh here as an example) with the commands that you want to execute.

```bash
#!/bin/sh

python lenet.py compile -b=1 --pef-name="lenet" --output-folder="pef"
python lenet.py test --pef="pef/lenet/lenet.pef"
python lenet.py run --pef="pef/lenet/lenet.pef"
```

Then pass the bash script as an input to the `sbatch` command as shown below.

```bash
sbatch --output=pef/lenet/output.log submit-lenet-job.sh
```

In case of the need to use multiple RDU's (2 in the example shown below), the `sbatch` command would be altered as:

```bash
sbatch --gres=rdu:2 <your_script.sh>
```
<!--- See [DataParallel](DataParallel.md) for additional information. --->

## Squeue

`Squeue` command provides information about jobs located in the Slurm scheduling queue.

```bash
squeue
```

## Scancel

Scancel is used to signal or cancel jobs, job arrays or job steps.

```bash
scancel job_id
```
