# Example Programs

## Unet
<table>
<tbody>
<tr class="odd">
<td>
<strong>
...$ cd ~/modelzoo-R1.1.0/unet/tf<br>
...$ rm -r model_dir_unet_base_severstal<br>
...$ csrun_cpu python run.py --mode=train --compile_only --params configs/params_severstal_sharedds.yaml --model_dir model_dir_unet_base_severstal --cs_ip 192.168.220.50<br>
...$ csrun_wse python run.py --mode=train --params configs/params_severstal_sharedds.yaml --model_dir model_dir_unet_base_severstal --cs_ip 192.168.220.50<br>
</strong>
</td>
</tr>
</tbody>
</table>
## Bert
[TODO]
## BraggNN
[TODO]

## Training in CPU-mode (move this someplace else?)

The examples in the modelzoo<!--- [TODO And PyTorch?]--> will run in CPU mode as either csrun_cpu jobs, or in a singularity shell as shown below.<br>
<i>If no cs_ip is specified, a training run will be in cpu mode. </i>

Change the max steps for the training run command line to something smaller than the default so that the training completes in a reasonable amount of time. (CPU mode is &gt;2 orders of magnitude slower for many examples.)

This illustrates how to create a singularity container.
The "-B /opt:/opt" is an illustrative example of how to bind a directory to a singularity container. (The singularity containers by default bind both one's home directory and /tmp, read/write.)
The current directory in the container will be the same as the current directory immediately prior to creating the container.
<table>
<tbody>
<tr class="odd">
<td><strong>cd ~/modelzoo-R1.1.0/fc_mnist/tf<br />
.../tf/$ singularity shell -B /opt:/opt /lambda_stor/slurm/cbcore_images/cbcore_latest.sif<br />
Singularity&gt; pwd<br />
/home/&lt;ALCFUserID&gt;/modelzoo-R1.1.0//fc_mnist/tf
</strong></td>
</tr>
</tbody>
</table>

At the shell prompt for the container, 
<table>
<tbody>
<tr class="odd">
<td><strong>
Singularity&gt; rm -r model_dir<br />
Singularity&gt; # compile and train on the CPUs<br />
Singularity&gt; python run.py --mode train --max_steps 1000<br />
...<br />
Singularity&gt; python run.py --mode eval --eval_steps 1000 # may be broken<br />
...<br />
Singularity&gt; # validate_only is the first portion of a compile<br />
Singularity&gt; python run.py --mode train --validate_only<br />
...<br />
Singularity&gt; # remove the existing compile and training artifacts<br />
Singularity&gt; rm -r model_dir<br />
Singularity&gt; # compile_only does a compile but no training<br />
Singularity&gt; python run.py --mode train --compile_only<br />
...<br />
exit</strong></td>
</tr>
</tbody>
</table>

