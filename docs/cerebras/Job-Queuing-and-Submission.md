Cerebras
========

### Job Queuing and Submission
[ed: Overlaps with running basic tests.]<br>
The CS-2 systems use slurm for job submission and queueing.<br>
The srun frontend **csrun_cpu** is used to run a cpu-only job on one or more worker nodes.<br>
The srun frontend **csrun_wse** is used to run a job on both the wafer scale engine and one or more worker nodes.
"squeue -a" may be used to see what jobs are currently using the CS-2. Your job will be blocked until there are available resources. Scheduling is in simple job request order. 
<table>
<tbody>
<tr class="odd">
<td><strong>
# csrun_cpu [--help] [--alloc_node] [--mount_dirs] command_to_execute<br>
csrun_cpu ...<br>
# csrun_wse [--nodes] [--tasks_per_node] [--cpus_per_task] [--mount_dirs] command_for_cs_execution</br>
csrun_wse ...<br>
# Other useful slurm commands <br>
# sinfo [OPTIONS]<br>
sinfo -a<br>
# squeue [OPTIONS]</br>
squeue -a<br>
# scancel [OPTIONS] [job_id[_array_id][.step_id]]</br>
scancel <jobid><br>
# sbatch [OPTIONS(0)...] [ : [OPTIONS(N)...]] script(0) [args(0)...]<br>
sbatch ...<br>
# sstat [<\OPTION>] -j < job(.stepid)><br>
sstat -a -j ...<br>
# sshare [OPTION]<br>
sshare -a<br>
# sjstat [-h] [-c] p[-man] [-r] [-v]<br>
sjstat -v<br>
</strong></td>
</tr>
</tbody>
</table>

Add *"--help"* to see basic help for a slurm command.

