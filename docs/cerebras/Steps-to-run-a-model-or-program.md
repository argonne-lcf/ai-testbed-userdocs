Cerebras
========

### Steps to run a model/program

#### Getting Started
[This subsection is an adaption of <br>
[https://docs.cerebras.net/en/latest/getting-started/checklist-before-you-start.html](https://docs.cerebras.net/en/latest/getting-started/checklist-before-you-start.html)]

##### Login steps:<br>
Follow the instructions in section [Connect to a CS-2 node](./Connect-to-a-CS-2-node.md)

##### Cerebras SIF container:<br>
The Cerebras Singularity container (SIF) is used for all work with the Cerebras software, and includes the Cerebras Graph Compiler (CGC) and other necessary software.</br>
Its path is /lambda_stor/slurm/cbcore_images/cbcore_latest.sif<br>
It is used by the csrun_cpu and csrun_wse scripts, and can also be used directly with singularity.<br>
[TODO update that lamba_store path when ALCF conversion is complete.]

##### Slurm:<br>
Slurm is installed and running on all the CPU nodes. The coordination between the CS system and the nodes in the CS cluster is performed by Slurm. See section
[Job Queueing and Submission](Job-Queuing-and-Submission.md) for more details.</br>
[TODO Verify that a csrun_wse job locks the CS-2 wafer for exclusive use; if not, then it will need to be fixed. (Even with a hack like exclusively reserving >50% of the worker nodes by default)]

##### Worker hostnames:<br>
<!---The worker nodes for the 1st CS-2 are testbed-cs2-01-med[1-9].ai.alcf.anl.gov<br>--->
The worker nodes for the CS-2 are testbed-cs2-02-med[1-9].ai.alcf.anl.gov<br>
You may occasionally need to log into a specific worker node for debugging purposes.

##### CS_IP addresses of the CS system:<br>
<!---The first CS-2 uses CS_IP 192.168.220.30<br>--->
The CS-2 uses CS_IP 192.168.220.50<br>
The CS_IP environment variable is set to the appropriate value by default, and may be used in scripts.  [TODO remove this TODO after this is true.]

##### Running a job
The steps to actually run a job are covered in section [Example Programs](Example-Programs.md).

#### Porting applications to the CS-2
Cerebras has guides for porting tensorflow and pytorch models:<br>
[Port TensorFlow to Cerebras](https://docs.cerebras.net/en/latest/tensorflow-docs/porting-tf-to-cs/index.html)</br>
[Porting PyTorch Model to CS](https://docs.cerebras.net/en/latest/pytorch-docs/adapting-pytorch-to-cs.html)

When porting, it is often helpful to study a related example in the Cerebras modelzoo.<br>
Make a copy of it with e.g.
<table>
<tbody>
<tr class="odd">
<td>
<strong>
cp -r /soft/cerebras/modelzoo/ ~/
</strong>
</td>
</tr>
</tbody>
</table>
Both the README.md files and source code in the modelzoo can be quite helpful. 

