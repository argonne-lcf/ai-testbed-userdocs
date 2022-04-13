Cerebras
========

### Steps to run a model/program

##### Gettin Started
Need to cover material in this page, customized to ANL:<br>
[https://docs.cerebras.net/en/latest/getting-started/checklist-before-you-start.html](https://docs.cerebras.net/en/latest/getting-started/checklist-before-you-start.html)

Login steps:<br>
Give copy-pastable steps to login, using ssh, to the chief node of each of the CS system clusters. 

Cerebras SIF container:<br>
"The Cerebras Singularity container (SIF) is installed on all the nodes, including the chief and the worker nodes, and on the network attached CS system. This container consists of the Cerebras Graph Compiler (CGC) and other necessary software."</br>
Its path is /lambda_stor/slurm/cbcore_images/cbcore_latest.sif<br>
[TODO update that path when ALCF conversion is done.]

Slurm:<br>
Slurm is installed and running on all the CPU nodes: on the chief node and on all the worker nodes. The coordination between the CS system and the nodes in the CS cluster is performed by Slurm. See section "Job Queueing and Submission" for more details.
[TODO is a mention of slurm even needed on this page?]

Hostnames:<br>
[TODO get these names]<br>
"You have the hostnames of the chief and the worker nodes. You will login to the chief node and perform all your work on the chief node. You will need hostnames of the worker nodes for debugging."

IP address of CS systems:<br>
The first CS-2 uses CS_IP 192.168.220.30<br>
The second CS-2 uses CS_IP 192.168.220.50<br>
[TODO is this correct?]
[TODO do we need to bother people about the port? The default value works.]

The basic steps to actually running a job are covered in section Example Programs.
