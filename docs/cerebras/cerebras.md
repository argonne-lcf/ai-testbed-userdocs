Cerebras
========

**Note: This documentation is correct as of 10 September 2021. **

*Cerebras's current Python support is built around Cerebras Estimator, which inherits from TensorFlow Estimator.*
Currently, people with PyTorch models would either need to convert them to use TF Estimator then to use Cerebras Estimator, or wait for Cerebras PyTorch support.

Keras models can be converted to TF Estimator and to Cerebras Estimator.  See <https://www.tensorflow.org/tutorials/estimator/keras_model_to_estimator>

**Note: Cerebras asks that early users agree to abide by the following:**
- Not disclose Cerebras software feature plans or system performance
- Not disclose the documentation site password to other parties
- Grant the right to review any planned press or publication that mentions the underlying hardware.

**Cerebras developer documentation is at**
<https://docs.cerebras.net/en/latest/>
The shared documentation password is Racerbee!s

The materials from the Cerebras training workshop 21 March 2021 are available on Box. They include videos.
[Cerebras\_Training\_March\_2021](https://anl.app.box.com/s/be1w6pqre8sda2jqwb65czk0o3hv2tho)

### **Get access to the Cerebras model zoo.**

<https://github.com/Cerebras/modelzoo>
Send an email (with [anl.gov](http://anl.gov) email address) to <support@cerebras.net> cc: <saumya.satish@cerebras.net>[@cerebras.net](mailto:jessica@cerebras.net), asking for access and giving your git username.
Quote from the Cerebras documentation:

|                                                                                                                                          |
|------------------------------------------------------------------------------------------------------------------------------------------|
| **Access to Cerebras Model Zoo Git repository. This is a private repo. Request access by sending an email as follows:**                  
                                                                                                                                           
 **To ​support@[cerebras.net](http://cerebras.net) with cc:<saumya.satish@cerebras.net>[@cerebras.net](mailto:jessica@cerebras.net) and**  
                                                                                                                                           
 **The following in the subject line: “&lt;Your Github username&gt; &lt;Your Company Name&gt; Model Zoo Access”.**                         |

Once you have model zoo access, start loosely following the Cerebras quickstart guide:
<https://docs.cerebras.net/en/latest/getting-started/checklist-before-you-start.html>
Use the instructions below as a guide for login details.

### Connect to cs1.cels.anl.gov

|                                                                                  |
|----------------------------------------------------------------------------------|
| **ssh &lt;yourANLloginid&gt;@[cs2.ai.alcf.anl.gov](http://cs2.ai.alcf.anl.gov)** |

Ssh either through homes manually, or with a ssh config that uses a login node proxy.

Currently, CS2 homes is housed on /lambda\_stor but it does not have sufficient disk space available for very large dataset. 

See [CELS GCE Systems On-Boarding](/display/AI/CELS+GCE+Systems+On-Boarding)
The help desk instructions are also useful: <https://virtualhelpdesk.cels.anl.gov/docs/linux/login-compute-and-home-nodes/>

<table>
<tbody>
<tr class="odd">
<td><strong>cd /home/&lt;ANLLoginId&gt;<br />
# mkdir that directory if it does not exist.<br />
git clone <a href="https://github.com/Cerebras/modelzoo" class="uri">https://github.com/Cerebras/modelzoo</a></strong></td>
</tr>
</tbody>
</table>

The "git clone" will ask for your (personal) [github.com](http://github.com) username, and a password. The password is actually an access token. Ensure that you have accepted the github invite received to your email and that repository is added to your github account.  

The access token (for those new to github) can be made this way:

Click here to expand...

- log into the [github.com](http://github.com) web UI,
- Settings --&gt; Developer settings
- Personal access tokens ( direct url <https://github.com/settings/tokens> )
- Generate new token
- Copy the token, and keep it secure but available for git activity (e.g. copy/paste for git clone/pull)

Follow the instructions in the tensorflow quickstart to train, evaluate and validate the fc\_mnist tensorflow estimator example.

<table>
<tbody>
<tr class="odd">
<td><strong>...$ cd /data/shared/&lt;yourCELSid&gt;<br />
...$ # create that user directory if it does not exist<br />
...$ cd modelzoo<br />
...$ ls<br />
audio common_zoo ctr fc_mnist graphs LICENSE <a href="http://README.md">README.md</a> <a href="http://RELEASE-NOTES.md">RELEASE-NOTES.md</a> rnn_encoder rnn_lm transformers unet<br />
...$ cd fc_mnist/tf<br />
...$ ls<br />
configs data.py model.py <a href="http://README.md">README.md</a> run.py utils.py<br />
...$ NUM_WORKER_NODES=1 srun_train python run.py --mode train --cs_ip 10.80.0.100 --max_steps 100000</strong></td>
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

If you are trying to run simple\_model from the CS tutorial, follow the below steps. 

|                                                                                             |
|---------------------------------------------------------------------------------------------|
| **cp -r /data/shared/cerebras\_workshop/simple\_model /data/shared/&lt;yourANLloginId&gt;** 
                                                                                              
 **cd /data/shared/&lt;yourANLloginId&gt;simple\_model/**                                     
                                                                                              
 **./srun\_singularity bash**                                                                 
                                                                                              
 **Singularity&gt;  python run.py --mode=validate\_only --model\_dir=model\_dir\_validate **  
                                                                                              
 **Singularity&gt;  python run.py --mode=compile\_only --model\_dir=model\_dir\_compile  **   |

If you are using an old version of run.py for this example and you encounter an error, error -0 TypeError: \_\_init\_\_() got an unexpected keyword argument 'use\_cs'

delete the following line in the run.py

|                       |
|-----------------------|
| **use\_cs=use\_cs1,** |

To run just training, use the following command. 

|                                                                                                                                 |
|---------------------------------------------------------------------------------------------------------------------------------|
| **\[&lt;YourLoginId&gt;@medulla1 simple\_model\]$ **                                                                            
                                                                                                                                  
 **NUM\_WORKER\_NODES=1 srun\_train python run.py--mode train --cs\_ip 10.80.0.100 --num\_steps 10000 --save\_checkpoints10000**  |

Running Tensorboard from Medulla
--------------------------------

if you are trying to run the tensorboard from cs1, launch the command from the medulla terminal and you will see the output as given below.

|                                                                                                                                                                                                                                                             |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **\[&lt;yourANLId&gt;@medulla1 simple\_model\]$ ./srun\_singularity tensorboard --bind\_all --logdir iris/model\_dir --port 9999**                                                                                                                          
                                                                                                                                                                                                                                                              
 **W0813 12:38:24.674294 140736110290688 plugin\_event\_accumulator.py:323\] Found more than one graph event per run, or there was a metagraph containing a graph\_def, as well as one or more graph events.  Overwriting the graph with the newest event.**  
                                                                                                                                                                                                                                                              
 **W0813 12:38:24.674624 140736110290688 plugin\_event\_accumulator.py:335\] Found more than one metagraph event per run. Overwriting the metagraph with the newest event.**                                                                                  
                                                                                                                                                                                                                                                              
 **TensorBoard 2.2.2 at <http://medulla1.cels.anl.gov:9999/> (Press CTRL+C to quit)**                                                                                                                                                                         |

To load the tensorboard, you can use the standard port forwarding mechanism using the below commands on two different terminals

|                                                                                                                                                                                               |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **\*\*\*-MacBook-Pro ~ % ssh -J [&lt;yourANLLoginId&gt;@logins.cels.anl.gov](mailto:vsastry@logins.cels.anl.gov) [&lt;yourANLLoginId&gt;@cs1.cels.anl.gov](mailto:vsastry@cs1.cels.anl.gov)** |

|                                                                                                                                                                                                                                                            |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **\*\*\*-MacBook-Pro ~ % ssh -J [&lt;yourANLLoginId&gt;@logins.cels.anl.gov](mailto:vsastry@logins.cels.anl.gov) -L 9999:localhost:9999 [&lt;yourANLLoginId&gt;](mailto:vsastry@logins.cels.anl.gov)[@cs1.cels.anl.gov](mailto:vsastry@cs1.cels.anl.gov)** |

if you used port 9999. 

Running the CPU-mode examples
-----------------------------

The "salloc\_node" command will allocate a singularity container on one of the nodes in the  Cerebras slurm cluster.  (is this blocking for other users?)

<table>
<tbody>
<tr class="odd">
<td><strong>.../tf/$ salloc_node<br />
WARNING: Cache disabled - cache location /home is not writable.<br />
Singularity&gt; exit</strong></td>
</tr>
</tbody>
</table>

The "singularity shell" command will allocate a singularity container on the machine you ssh-ed to.

<table>
<tbody>
<tr class="odd">
<td><strong>.../tf/$ singularity shell -B /data/shared/<a href="http://tmp/tmp">tmp:/tmp</a> -B /data /data/shared/software/singularity/cbcore_latest.sif<br />
Singularity&gt; exit</strong></td>
</tr>
</tbody>
</table>

The four CPU-mode examples in the quickstart will run in either a salloc\_node container or a singularity shell.

Change the max steps for the training run command line to something smaller so that the training completes in a reasonable amount of time. (CPU mode is &gt;2 orders of magnitude slower for this example.)

The "compile\_only" and "validate\_only" command lines in the quickstart are incorrect; use the ones below.

<table>
<tbody>
<tr class="odd">
<td><strong>Singularity&gt; rm -r model_dir<br />
Singularity&gt; python run.py --mode train --max_steps 1000<br />
...<br />
Singularity&gt; python run.py --mode eval<br />
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

<embed src="media/image1.tmp" width="468" height="239" />
=========================================================

Downloading dataset from kaggle.com to Medulla
==============================================

Here are some notes that is helpful for downloading kaggle datasets

Downloading a dataset from www.kaggle.com to cs1/medulla1 using the command line

Inside a singularity shell (e.g. singularity shell -B /data/shared/tmp:/tmp -B /data /data/shared/software/singularity/cbcore\_latest.sif )

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

It will download as a zip file. ('unzip' is available on cs1/medulla1)

Note: the kaggle download shown above included two identical copies of the dataset; one copy was in a subdirectory.

**PyTorch Support:**
--------------------

This is in the works and not supported currently. The proposed plan is  Q3-Q4 2021 See the Cerebras Software Timeline at the end of this article for additional details.
