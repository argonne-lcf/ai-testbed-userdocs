# Job Queueing and Submission - TODO - wip

<!---
**NOTE:  Please be mindful of how you use the systems.
For example, run larger jobs in the evening or on weekends.**

**NOTE:  Jobs on AI Accelerators *SHOULD NOT* be run interactively.
Jobs should be run using either *srun* or *sbatch*.**
--->




## Introduction

Here are example commands for using Slurm.

## Running with Slurm

As an example of using the SLURM scheduling system and workload manager for running jobs, run these commands:

```bash
srun python lenet.py compile -b=1 --pef-name="lenet" --output-folder="pef"
srun python lenet.py test --pef="pef/lenet/lenet.pef"
srun python lenet.py run --pef="pef/lenet/lenet.pef"
```

More details on the above commands is provided [here](Steps-to-run-a-model-or-program.md).

To use Slurm sbatch, create submit-lenet-job.sh with the following
contents:

```bash
#!/bin/sh

python lenet.py compile -b=1 --pef-name="lenet" --output-folder="pef"
python lenet.py test --pef="pef/lenet/lenet.pef"
python lenet.py run --pef="pef/lenet/lenet.pef"
```

Then

```bash
sbatch --output=pef/lenet/output.log submit-lenet-job.sh
```

One may use more that one RDU.  The command would be similar to:

```bash
sbatch --gres=rdu:2 your_script.sh
```

See [DataParallel](DataParallel.md) and search for **--gres=rdu:2**.

Squeue will give you the queue status.

```bash
squeue
```

Scancel is used to signal or cancel jobs, job arrays or job steps.

```bash
scancel job_id
```
