Cerebras
========

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


##### Running Tensorboard from testbed-cs2-01-med1
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
Awaiting version with a PyTorch sample that doesnt' require editing sorce code to enable training.<br/>
same general approach -<br />
remove the model_dir<br />
csrun_cpu run.py --mode train --compile_only ...<br />
csrun_wse run.py --mode train ... <br />

