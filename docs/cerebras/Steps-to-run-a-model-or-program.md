Cerebras
========

### Steps to run a model/program

##### Getting Started
[This following is an adaption of <br>
[https://docs.cerebras.net/en/latest/getting-started/checklist-before-you-start.html](https://docs.cerebras.net/en/latest/getting-started/checklist-before-you-start.html)]

Login steps:<br>
Give copy-pastable steps to login, using ssh, to the chief node of each of the CS system clusters. 

Cerebras SIF container:<br>
"The Cerebras Singularity container (SIF) is installed on all the nodes, including the chief and the worker nodes, and on the network attached CS system. This container consists of the Cerebras Graph Compiler (CGC) and other necessary software."</br>
Its path is /lambda_stor/slurm/cbcore_images/cbcore_latest.sif<br>
[TODO update that path when ALCF conversion is done.]

Slurm:<br>
Slurm is installed and running on all the CPU nodes: on the chief node and on all the worker nodes. The coordination between the CS system and the nodes in the CS cluster is performed by Slurm. See section "Job Queueing and Submission" for more details.</br>
[TODO is a mention of slurm even needed on this page?]<br>
[Verify that a csrun_wse job locks the CS-2 wafer for exclusive use; if not, then it will need to be fixed.)

Hostnames:<br>
[TODO get these names]<br>
"You have the hostnames of the chief and the worker nodes. You will login to the chief node and perform all your work on the chief node. You will need hostnames of the worker nodes for debugging."<br>
Note: the 9 worker nodes for a CS-2 cluster  are currently testbed-cs2-01-med[1-9] (or testbed-cs2-02-med[1-9] ?) </br>
The hostname for the chief node is testbed-cs2-01-med1 (or testbed-cs2-02-med1 ?)</br>

IP address of CS systems:<br>
The first CS-2 uses CS_IP 192.168.220.30<br>
The second CS-2 uses CS_IP 192.168.220.50<br>
[TODO are these IP addresses correct?]<br>
[TODO do we need to bother people about the port? The default value works.]

The basic steps to actually running a job are covered in section Example Programs.

##### Porting applications to the CS-2
Need guides for PyTorch (when available) and TensorFlow Estimator. Cerebras has some sparse documentation of this sort. 

Make a copy of the Cerebras model zoo with e.g.
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
The README.md files and source code in the modelzoo can be helpful. 

