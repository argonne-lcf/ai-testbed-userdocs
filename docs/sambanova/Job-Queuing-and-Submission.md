# Job Queueing and Submission

**NOTE:  Please be mindful of how you use the systems.
For example, run larger jobs in the evening or on weekends.**

**NOTE:  Jobs on AI Accelerators *SHOULD NOT* be run interactively.
Jobs should be run using either *srun* or *sbatch*.**

## Tile Status

Check to see if there is resources, use one of the following commands:

```bash
sntilestat
watch sntilestat
```

The output below shows that the system is completely idle.

```text
TILE                 %idle %exec %pload %aload %chkpt %quiesce    PID     USER COMMAND
/XRDU_0/RDU_0/TILE_0 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_0/RDU_0/TILE_1 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_0/RDU_0/TILE_2 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_0/RDU_0/TILE_3 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_0/RDU_1/TILE_0 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_0/RDU_1/TILE_1 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_0/RDU_1/TILE_2 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_0/RDU_1/TILE_3 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_1/RDU_0/TILE_0 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_1/RDU_0/TILE_1 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_1/RDU_0/TILE_2 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_1/RDU_0/TILE_3 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_1/RDU_1/TILE_0 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_1/RDU_1/TILE_1 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_1/RDU_1/TILE_2 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_1/RDU_1/TILE_3 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_2/RDU_0/TILE_0 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_2/RDU_0/TILE_1 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_2/RDU_0/TILE_2 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_2/RDU_0/TILE_3 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_2/RDU_1/TILE_0 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_2/RDU_1/TILE_1 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_2/RDU_1/TILE_2 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_2/RDU_1/TILE_3 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_3/RDU_0/TILE_0 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_3/RDU_0/TILE_1 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_3/RDU_0/TILE_2 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_3/RDU_0/TILE_3 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_3/RDU_1/TILE_0 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_3/RDU_1/TILE_1 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_3/RDU_1/TILE_2 100.0   0.0    0.0    0.0    0.0      0.0
/XRDU_3/RDU_1/TILE_3 100.0   0.0    0.0    0.0    0.0      0.0
```

## Introduction

Here are example commands for using Slurm.

**NOTE:  If you receive an "HTTP error" message on any of the
following commands, run the command again. Such errors (e.g. 503) are
commonly an intermittent failure to download a dataset.**

Sambanova provides examples of some well known AI applications under the path: /software/sambanova/apps/1.10.3-11/starters. These are located on the Sambanova Compute node sm-01. Make a copy of this to your home directory:

```bash
cd ~/
mkdir apps
cp -r /software/sambanova/apps/1.10.3-11/starters apps/starters
```

## Running with Slurm

Run these commands:

```bash
srun python lenet.py compile -b=1 --pef-name="lenet" --output-folder="pef"
srun python lenet.py test --pef="pef/lenet/lenet.pef"
srun python lenet.py run --pef="pef/lenet/lenet.pef"
srun python lenet.py measure-performance --pef="pef/lenet/lenet.pef"
```

To use Slurm sbatch, create submit-lenet-job.sh with the following
contents:

```bash
#!/bin/sh

python lenet.py compile -b=1 --pef-name="lenet" --output-folder="pef"
python lenet.py test --pef="pef/lenet/lenet.pef"
python lenet.py run --pef="pef/lenet/lenet.pef"
python lenet.py measure-performance --pef="pef/lenet/lenet.pef"
```

Then

```bash
sbatch --output=pef/lenet/output.log submit-lenet-job.sh
```

Squeue will give you the queue status.

```bash
squeue
```

Scancel is used to signal or cancel jobs, job arrays or job steps.

```bash
scancel job_id
```

Please note that there is no measure-performance command handled
currently in lenet.py and some of the other files in the pytorch starter
code. Hence if you run measure-performance on lenet.py, it will not
display anything. One way to run performance measure for lenet is, add
the following in the main function:

```text
elif args.command == "measure-performance":
        common_app_driver(args, model, inputs, optimizer, name='ffn_mnist_torch', app_dir=utils.get_file_dir(__file__))
```
