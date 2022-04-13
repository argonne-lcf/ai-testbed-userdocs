Cerebras
========

### Job Queuing and Submission
[ed: Overlaps with running basic tests.]<br>
The CS-2 systems use slurm for job submission and queueing.<br>
The srun frontend **csrun_cpu** runs cpu job on one or more worker nodes.<br>
The srun frontend **csrun_wse** runs a job on both the wafer scale engine and one or more worker nodes.
<table>
<tbody>
<tr class="odd">
<td><strong>
# Cerebras has two frontends to srun:<br>
csrun_cpu ...<br>
csrun_wse ...<br>
# Other useful slurm commands <br>
sinfo<br>
squeue -a<br>
scancel <jobid><br>

</strong></td>
</tr>
</tbody>
</table>

Add *"--help"* to see basic help for a slurm command.

