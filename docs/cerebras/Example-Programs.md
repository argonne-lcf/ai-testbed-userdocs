### Example Programs
Follow these instructions to train, evaluate and validate the fc\_mnist TensorFlow estimator example. This model is a couple of fully connected layers plus dropout and RELU. <br>

See also the current Cerebras quickstart documentation, that uses a clone of Cerebras's abbreviated public "reference implementations" github repo rather than the full modelzoo.<br>
[https://docs.cerebras.net/en/latest/getting-started/cs-tf-quickstart.html](https://docs.cerebras.net/en/latest/getting-started/cs-tf-quickstart.html)<br>
[https://github.com/Cerebras/cerebras_reference_implementations/](https://github.com/Cerebras/cerebras_reference_implementations/)

[TODO Describe the available samples in the Cerebras modelzoo? That tree is grows over time.]<br>

<table>
<tbody>
<tr class="odd">
<td><strong>...$ cd ~/<br />
...$ cp -r /soft/cerebras/modelzoo/ .<br />
...$ cd modelzoo<br />
...$ ls<br />
audio common_zoo ctr fc_mnist graphs LICENSE README.md RELEASE-NOTES.md rnn_encoder rnn_lm transformers unet<br />
...$ cd fc_mnist/tf<br />
...$ ls<br />
configs data.py model.py README.md run.py utils.py<br />
...$ csrun_wse --nodes 1 python run.py --mode train --cs_ip 192.168.220.30 --max_steps 100000</strong></td>
</tr>
</tbody>
</table>

You should see a very fast training rate, e.g. 1400 steps per second, and output that finishes with something similar to this:

<table>
<tbody>
<tr class="odd">
<td><strong>INFO:tensorflow:global step 99800: loss = 0.0 (1400.41 steps/sec)<br />
INFO:tensorflow:global step 99900: loss = 0.00904083251953125 (1400.25 steps/sec)<br />
INFO:tensorflow:Calling checkpoint listeners before saving checkpoint 100000...<br />
INFO:tensorflow:Saving checkpoints for 100000 into /data/shared/arnoldw/modelzoo/fc_mnist/tf/model_dir/model.ckpt.<br />
INFO:tensorflow:Calling checkpoint listeners after saving checkpoint 100000...<br />
INFO:tensorflow:Training finished with 25600000 samples in 71.425 seconds, 358417.08 samples/second.<br />
INFO:tensorflow:Loss for final step: 0.0.</strong></td>
</tr>
</tbody>
</table>

To separately compile and run, 
<table>
<tbody>
<tr class="odd">
<td><strong>...$ # delete any existing compile artifacts and checkpoints<br />
...$ rm -r model_dir<br />
...$ srun_train --nodes 1 python run.py --mode train --compile_only --cs_ip 192.168.220.30 --max_steps 100000<br />
...$ srun_train --nodes 2 python run.py --mode train --cs_ip 192.168.220.30 --max_steps 100000</strong></td>
</td>
</tr>
</tbody>
</table>
The training will reuse an existing compilation if no changes were made that force a recompile. Compiles may be done while another job is using the wafer.


### Training in CPU-mode

The CPU-mode examples in the TensorFlow [TODO And PyTorch?] quickstart will run as either csrun_cpu jobs or in a singularity shell.<br>
<i>If no cs_ip is specified, a training run will be in cpu mode. </i>

Change the max steps for the training run command line to something smaller so that the training completes in a reasonable amount of time. (CPU mode is &gt;2 orders of magnitude slower for this example.)

This illustrates how to create a singularity container.
The "-B /opt:/opt" is an illustrative example of how to bind a directory to a singularity container. (The singularity containers by default binds both one's home directory and /tmp, read/write.)
The current directory in the container will be the same as the current directory immediately prior to creating the container.
<table>
<tbody>
<tr class="odd">
<td><strong>cd ~/modelzoo/fc_mnist/tf<br />
.../tf/$ singularity shell -B /opt:/opt /lambda_stor/slurm/cbcore_images/cbcore_latest.sif<br />
Singularity&gt; pwd<br />
/home/&lt;ALCFUserID&gt;/modelzoo/fc_mnist/tf
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

