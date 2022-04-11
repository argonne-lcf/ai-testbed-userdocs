Cerebras
========

### System Overview
The Cerebras CS-2 is a wafer-scale deep learning accelerator comprising 850,000 processing cores, each providing 48KB of dedicated SRAM memory for an on-chip total of 40GB and interconnected to optimize bandwidth and latency. Its software platform integrates popular machine learning frameworks such as TensorFlow and PyTorch.

*Cerebras's current Python support is built around Cerebras Estimator, which inherits from TensorFlow Estimator.*
Cerebras Release 1.2 will introduce PyTorch support. Release 1.1 includes a preview of the PyTorch support. 

Keras models can be converted to TF Estimator and to Cerebras Estimator.  See <https://www.tensorflow.org/tutorials/estimator/keras_model_to_estimator>

The materials from the Cerebras training workshop 21 March 2021 are available on Box. They include videos.
[Cerebras\_Training\_March\_2021](https://anl.app.box.com/s/be1w6pqre8sda2jqwb65czk0o3hv2tho)

TODO need a pointer to a mirror/pdf(or whatever format chosen) for a copy of the current Cerebras quickstart guide.

### How to setup your base environment
[Is there anything to do here?] 
### Steps to run a model/program
The basic steps are covered in section Example Programs.
### Using virtual environments to customize environment
It is considered good practice to create a python virtual environment for python projects with dependencies not satisfied by the base environment.
This prevents dependency conflicts between projects.

<table>
<tbody>
<tr class="odd">
<td><strong>
python3 -m venv ~/testp3env<br>
source ~/testp3env/bin/activate<br>
pip install --upgrade pip<br>
pip install wget<br>
# to exit the virtual env:<br>
deactivate<br>
</strong></td>
</tr>
</tbody>
</table>

To use this virtual env, e.g. in a script started with csrun_wse or csrun_cpu, or in a singularity shell:
<table>
<tbody>
<tr class="odd">
<td><strong>
source testp3env/bin/activate
</strong></td>
</tr>
</tbody>
</table>




### Job Queuing and Submission
[ed: Overlaps with running basic tests.]<br>
The CS-2 systems use slurm for job submission and queueing.
<table>
<tbody>
<tr class="odd">
<td><strong>
# Cerebras has two frontends to srun:<br>
csrun_cpu ...<br>
csrun_wse ...<br>
# Other useful slurm commands <br>
sinfo
squeue -a<br>
scancel <jobid><br>

</strong></td>
</tr>
</tbody>
</table>

Add "--help" to see basic help for a slurm command.

### Example Programs
Follow the instructions in the tensorflow quickstart to train, evaluate and validate the fc\_mnist tensorflow estimator example. This sample is a fully

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
The training will reuse an existing compilation if no changes were made that force a recompile.

### Performance Tools (Covers how to profile and get performance data)
TODO
### Best Practices and FAQs ( We can link here to the vendor docs as well)
TODO
### Tunneling and  forwarding ports
TODO
### System and Storage Policies
TODO
### Miscellaneous

##### Running the CPU-mode examples

The CPU-mode examples in the TensorFlow quickstart will run as csrun_cpu jobs or in a singularity shell.<br>
<i>If no cs_ip is specified, the run will be in cpu mode. </i>

Change the max steps for the training run command line to something smaller so that the training completes in a reasonable amount of time. (CPU mode is &gt;2 orders of magnitude slower for this example.)

This illustrates how to create a singularity container.
The "-B /opt:/opt" is an illustrative example of how to bind a directory to a singularity container. 
The current directory in the container will be the same as the current directory immediately prior to creating the container.
<table>
<tbody>
<tr class="odd">
<td><strong>cd ~/modelzoo/fc_mnist/tf<br />
.../tf/$ singularity shell -B ~/opt:/opt /lambda_stor/slurm/cbcore_images/cbcore_latest.sif<br />
Singularity&gt; pwd<br />
/home/&lt;yourALCFloginid&gt;/modelzoo/fc_mnist/tf
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
Singularity&gt; python run.py --mode train --max_steps 1000<br />
...<br />
Singularity&gt; python run.py --mode eval --eval_steps 1000 # may be broken<br />
...<br />
Singularity&gt; python run.py --mode train --validate_only<br />
...<br />
Singularity&gt; rm -r model_dir<br />
Singularity&gt; python run.py --mode train --compile_only<br />
...<br />
exit</strong></td>
</tr>
</tbody>
</table>

##### Downloading a dataset from www.kaggle.com to the CS-2

Here are some notes that may be helpful for downloading kaggle datasets

Downloading a dataset from www.kaggle.com to testbed-cs2-01-med1 using the command line

Inside a singularity shell (e.g. singularity shell -B ~/data:/data /lambda_stor/slurm/cbcore_images/cbcore_latest.sif )

virtualenv env

source env/bin/activate

pip3 install kaggle

Go to www.kaggle.com in a browser, log in (create account if first time). In user(icon upper right) -&gt; Account, there is a button (scroll down) to "Create New API Token". Click it. It will produce a one-line json.

put the json in ~/.kaggle/kaggle.json

e.g. single quote the json text and echo it

echo '{"username":"REDACTED","key":"REDACTED"}'' &gt; ~/.kaggle/kaggle.json

chmod 600 ~/.kaggle/kaggle.json

On www.kaggle.com, one can get the kaggle api command for download of a dataset by navigating to the dataset page, then the vertical "..." to the right of the Download button, then "Copy API command". This will copy the API command to the local clipboard.

In the singularity shell with the virtual env activated, switch dir to some place with plenty of space, e.g. /data/shared/&lt;youriddir&gt;

Paste the API command to the command line inside the singularity shell with the venv activated. E.g.

kaggle datasets download -d mhskjelvareid/dagm-2007-competition-dataset-optical-inspection

It will download as a zip file. ('unzip' is available testbed-cs2-01-med1)

exit the singularity container to unzip the dataset zip file

Note: the kaggle download shown above included two identical copies of the dataset; one copy was in a subdirectory.



### Connect to a CS-2 node
To connect to a CS-2 [chief?] node:

|                                                                                  |
|----------------------------------------------------------------------------------|
| **ssh -o "ProxyJump ALCFid@cerebras.alcf.anl.gov" ALCFid@cs2.ai.alcf.anl.gov** |

Your home directory has a default 1TB quota.  (TODO is this true?)

To copy a file to your CS-2 [ed: chief?] node home dir:

|                                                                                  |
|----------------------------------------------------------------------------------------------------------------------|
| **scp -o "ProxyJump ALCFid@cerebras.alcf.anl.gov" filename ALCFid@cs2.ai.alcf.anl.gov:~/** |

To copy a file from your CS-2 [ed: chief?] node home dir to the currect directory:

|                                                                                  |
|----------------------------------------------------------------------------------|
| **scp -o "ProxyJump ALCFid@cerebras.alcf.anl.gov" ALCFid@cs2.ai.alcf.anl.gov:~/filename .** |





TODO are there instructions for ALCF id onboarding?



Running Tensorboard from testbed-cs2-01-med1
--------------------------------

if you are trying to run the tensorboard from cs2, launch the command from the testbed-cs2-01-med1 terminal and you will see the output as given below.<br/>
TODO this doesn't actually work; test/fix when CS-2 is working again. 
|                                                                                                                                                                                                                                                             |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **\[&lt;ALCFid&gt;@testbed-cs2-01-med1 simple\_model\]$ ./srun\_singularity tensorboard --bind\_all --logdir iris/model\_dir --port 9999**<br/>
**# this fails too: singularity exec -B ~/data:/data --net --network-args "portmap=9999:9999/tcp" /lambda_stor/slurm/cbcore_images/cbcore_latest.sif  tensorboard --bind\_all --logdir model\_dir --port 9999**<br/>
 **W0813 12:38:24.674294 140736110290688 plugin\_event\_accumulator.py:323\] Found more than one graph event per run, or there was a metagraph containing a graph\_def, as well as one or more graph events.  Overwriting the graph with the newest event.**  
                                                                                                                                                                                                                                                              
 **W0813 12:38:24.674624 140736110290688 plugin\_event\_accumulator.py:335\] Found more than one metagraph event per run. Overwriting the metagraph with the newest event.**                                                                                  
                                                                                                                                                                                                                                                              
 **TensorBoard 2.2.2 at <http://cerebras.alcf.anl.gov:9999/> (Press CTRL+C to quit)**                                                                                                                                                                         |

To load the tensorboard, you can use the standard port forwarding mechanism using the below commands on two different terminals

|                                                                                                                                                                                               |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **...% ssh [&lt;ALCFid&gt;@cerebras.alcf.anl.gov](cerebras.alcf.anl.gov)** |

|                                                                                                                                                                                                                                                            |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **...% ssh -L 9999:localhost:9999 [&lt;ALCFid&gt;](ALCFid)[@cerebras.alcf.anl.gov](cerebras.alcf.anl.gov)** |

if you used port 9999. 


<embed src="media/image1.tmp" width="468" height="239" />
=========================================================

**PyTorch Support:**
--------------------

TODO 
Awaiting version with a pytorch sample that doesnt' require editing sorce code to enable training.<br/>
same general approach -<br />
remove the model_dir<br />
csrun_cpu run.py --mode train --compile_only ...<br />
csrun_wse run.py --mode train ... <br />

