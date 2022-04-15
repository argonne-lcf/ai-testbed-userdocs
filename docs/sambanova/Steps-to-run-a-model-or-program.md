# Steps to run a model/program

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

Example:

```bash
srun python myapp.py compile --pef-name="myapp.pef" --output-folder="pef"
```

## Test (optional)

Runs the model on both the host CPU and the SambaNova node.  It compares
the answers from the CPU and SambaNova RDU and will raise errors if any
discrepancies are found. Pass the pef file generated above as the input.

```bash
srun python myapp.py test --pef="pef/myapp/myapp.pef"
```

## Run

This will run the application on SN nodes.

```bash
srun python myapp.py run --pef="pef/myapp/myapp.pef"
```

## Measure Performance (Optional)

## TODO It only uses simulated data.  Not real data.

This step will report the measured performance. The parameters depend on
the model and can include latency, samples/sec.

```bash
srun python myapp.py measure-performance --pef="pef/myapp/myapp.pef
```

**Using the SLURM scheduling system and workload manager for running
jobs**

The system uses the [SLURM job
scheduler](https://slurm.schedmd.com/quickstart.html) to run jobs.
