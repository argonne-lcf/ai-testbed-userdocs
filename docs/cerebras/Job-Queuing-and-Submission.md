## Job Queuing and Submission
The CS-2 systems use slurm for job submission and queueing.<br>
**csrun_cpu** is used to run a cpu-only job on one or more worker nodes.<br>
**csrun_wse** is used to run a job on both the wafer scale engine and one or more worker nodes.

Your job will be blocked until there are available resources.<br>
Scheduling is in simple job request order.
```bash
# csrun_cpu [--help] [--alloc_node] [--mount_dirs] command_to_execute
csrun_cpu ...
# csrun_wse [--nodes] [--tasks_per_node] [--cpus_per_task] [--mount_dirs] command_for_cs_execution
csrun_wse ...
#
# squeue is used to inspect the job queue
# squeue [OPTIONS]
squeue -a
# scancel is used to cleanly kill a job
# scancel [OPTIONS] [job_id[_array_id][.step_id]]
scancel JOBID
```

Add *"--help"* to see basic help for a slurm command.<br>
See some examples of how these commands are used to submit and queue jobs [here](Steps-to-run-a-model-or-program.md).

