# Steps to run a model/program

## Getting Started
[This subsection is an adaption of <br>
[https://docs.cerebras.net/en/latest/getting-started/checklist-before-you-start.html](https://docs.cerebras.net/en/latest/getting-started/checklist-before-you-start.html)]

<!---#### Login steps:<br>
Follow the instructions in section [Connect to a CS-2 node](./Connect-to-a-CS-2-node.md)--->

<!---
#### Cerebras SIF container:<br>
The Cerebras Singularity container (SIF) is used for all work with the Cerebras software, and includes the Cerebras Graph Compiler (CGC) and other necessary software.</br>
Its path is /lambda_stor/slurm/cbcore_images/cbcore_latest.sif<br>
It is used by the csrun_cpu and csrun_wse scripts, and can also be used directly with singularity.<br>
[TODO update that lamba_store path when ALCF conversion is complete.]
--->

#### Slurm:<br>
Slurm is installed and running on all the CPU nodes. The coordination between the CS system and the nodes in the CS cluster is performed by Slurm. See section
[Job Queueing and Submission](Job-Queuing-and-Submission.md) for more details.</br>
<!---
[TODO Verify that a csrun_wse job locks the CS-2 wafer for exclusive use; if not, then it will need to be fixed. (Even with a hack like exclusively reserving >50% of the worker nodes by default)]
--->

#### Worker hostnames:<br>
<!---The worker nodes for the 1st CS-2 are testbed-cs2-01-med[2-8].ai.alcf.anl.gov<br>--->
The worker nodes (see the first diagram in [System Overview](System-Overview.md#system-overview)) for the CS-2 are cs2-02-med[2-7].<br>
You may occasionally need to log into a specific worker node for debugging purposes.

#### CS_IP address of the CS system:<br>
<!---The first CS-2 uses CS_IP 192.168.220.30<br>--->
The CS-2 uses CS_IP 192.168.220.50<br>
The CS_IP environment variable is set to this value by the /software/cerebras/cs2-02/envs/cs_env.sh script, and may be used in scripts.

#### Running slurm jobs:<br>
Cerebras includes two scripts for running slurm jobs.<br>
csrun_cpu is for running cpu-only jobs. By default it reserves a single entire worker node.<br>
csrun_wse is for running training jobs. By default it reserves 5 entire worker nodes, which are used to feed the dataset to the CS2 wafer.<br>
```csrun_cpu --help``` and ```csrun_wse --help``` will list the available options.

## Running a training job
Follow these instructions to train, evaluate and validate the fc\_mnist TensorFlow estimator example. This model is a couple of fully connected layers plus dropout and RELU. <br>

```bash
cd ~/
mkdir ~/R1.1.0/
cp -r /software/cerebras/model_zoo/modelzoo-R1.1.0 ~/R1.1.0/modelzoo
cd ~/R1.1.0/modelzoo/fc_mnist/tf
csrun_wse python run.py --mode train --cs_ip 192.168.220.50 --max_steps 100000
```

You should see a very fast training rate, e.g. 1400 steps per second, and output that finishes with something similar to this:

<table>
<tbody>
<tr class="odd">
<td>
INFO:tensorflow:Training finished with 25600000 samples in 71.425 seconds, 358417.08 samples/second.<br />
INFO:tensorflow:Loss for final step: 0.0.</strong></td>
</td>
</tr>
</tbody>
</table>

To separately compile and run,
```bash
# delete any existing compile artifacts and checkpoints
rm -r model_dir
csrun_cpu python run.py --mode train --compile_only --cs_ip 192.168.220.50
csrun_wse python run.py --mode train --cs_ip 192.168.220.50 --max_steps 100000
```
The training will reuse an existing compilation if no changes were made that force a recompile, and will start from the newest checkpoint file if any. Compiles may be done while another job is using the wafer.

See also the current Cerebras quickstart documentation, that uses a clone of Cerebras's abbreviated public "reference implementations" github repo rather than the full modelzoo.<br>
[https://docs.cerebras.net/en/latest/getting-started/cs-tf-quickstart.html](https://docs.cerebras.net/en/latest/getting-started/cs-tf-quickstart.html)<br>
[https://github.com/Cerebras/cerebras_reference_implementations/](https://github.com/Cerebras/cerebras_reference_implementations/)

