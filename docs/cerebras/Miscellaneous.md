### Miscellaneous



#### Downloading a dataset from www.kaggle.com to a CS-2 node using the command line

These notes may be helpful for downloading kaggle datasets

Inside a singularity shell (e.g. singularity shell -B ~/opt:/opt /lambda_stor/slurm/cbcore_images/cbcore_latest.sif )

<table>
<tbody>
<tr class="odd">
<td>
<strong>
virtualenv env<br>
source env/bin/activate</br>
pip3 install kaggle</br>
</strong>
</td>
</tr>
</tbody>
</table>


Go to www.kaggle.com in a browser, log in (create account if first time). In user(icon upper right) -&gt; Account, there is a button (scroll down) to "Create New API Token". Click it. It will produce a one-line json.

put the json in ~/.kaggle/kaggle.json</br>
e.g. single quote the json text and echo it</br>
<table>
<tbody>
<tr class="odd">
<td>
<strong>
echo '{"username":"REDACTED","key":"REDACTED"}'' &gt; ~/.kaggle/kaggle.json</br>
chmod 600 ~/.kaggle/kaggle.json
</strong>
</td>
</tr>
</tbody>
</table>

On www.kaggle.com, one can get the kaggle api command for download of a dataset by navigating to the dataset page, then the vertical "..." to the right of the Download button, then "Copy API command". This will copy the API command to the local clipboard.

In the singularity shell with the virtual env activated, switch dir to some place with plenty of space, e.g. /data/shared/ALCFUserID [TODO fix when filesystem/mounts are stable]

Paste the API command to the command line inside the singularity shell with the venv activated. E.g.<br>
<table>
<tbody>
<tr class="odd">
<td>
<strong>
kaggle datasets download -d mhskjelvareid/dagm-2007-competition-dataset-optical-inspection
</strong>
</td>
</tr>
</tbody>
</table>


It will download as a zip file. ('unzip' is available testbed-cs2-01-med8)

exit the singularity container to unzip the dataset zip file

Note: the kaggle download shown above included two identical copies of the dataset; one copy was in a subdirectory.

#### Running Tensorboard from testbed-cs2-01-med8
--------------------------------

[TODO fix this when system is working enough to test tunneling]

if you are trying to run the tensorboard from cs2, launch the command from the testbed-cs2-01-med8 terminal and you will see the output as given below.<br/>
TODO this doesn't actually work; test/fix when CS-2 is working again. 
|                                                                                                                                                                                                                                                             |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **\[&lt;ALCFid&gt;@testbed-cs2-01-med8 simple\_model\]$ ./srun\_singularity tensorboard --bind\_all --logdir iris/model\_dir --port 9999**<br/>
**# this fails too: singularity exec -B ~/data:/data --net --network-args "portmap=9999:9999/tcp" /lambda_stor/slurm/cbcore_images/cbcore_latest.sif  tensorboard --bind\_all --logdir model\_dir --port 9999**<br/>
 **W0813 12:38:24.674294 140736110290688 plugin\_event\_accumulator.py:323\] Found more than one graph event per run, or there was a metagraph containing a graph\_def, as well as one or more graph events.  Overwriting the graph with the newest event.**  
                                                                                                                                                                                                                                                              
 **W0813 12:38:24.674624 140736110290688 plugin\_event\_accumulator.py:335\] Found more than one metagraph event per run. Overwriting the metagraph with the newest event.**                                                                                  
                                                                                                                                                                                                                                                              
 **TensorBoard 2.2.2 at <http://cerebras.alcf.anl.gov:9999/> (Press CTRL+C to quit)**                                                                                                                                                                         |

To load the tensorboard, you can use the standard port forwarding mechanism using the below commands on two different terminals

|                                                                                                                                                                                               |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **...% ssh [&lt;ALCFUserID&gt;@cerebras.alcf.anl.gov](cerebras.alcf.anl.gov)** |

|                                                                                                                                                                                                                                                            |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **...% ssh -L 9999:localhost:9999 [&lt;ALCFUserID&gt;](ALCFUserID)[@cerebras.alcf.anl.gov](cerebras.alcf.anl.gov)** |

if you used port 9999. 


<embed src="media/image1.tmp" width="468" height="239" />
=========================================================

#### PyTorch Support
--------------------

[TODO 
Awaiting version with a PyTorch sample that doesn't' require editing source code to enable training.<br/>
same general approach -<br />
remove the model_dir<br />
csrun_cpu run.py --mode train --compile_only ...<br />
csrun_wse run.py --mode train ... <br />]

#### Determining the CS-2 firmware version
-------------------------------------------


[TODO should this API/auth string be made public? Alternative supplied that inspects the singularity container.]

Note: replace the IP address with the CS_IP for the CS-2 cluster being used.<br>
[TODO could use CS_IP environment variable if set.]
<table>
<tbody>
<tr class="odd">
<td>
<strong>
...$ curl -k -X GET 'https://192.168.120.50/redfish/v1/Managers/manager' --header 'Authorization: Basic YWRtaW46YWRtaW4=' 2> /dev/null  | python -m json.tool | grep FirmwareVersion<br>
"FirmwareVersion": "1.1.1-202203171919-5-879ff4ef",<br>
...$ <br>
#Alternatively [TODO the auth token above makes me nervous]:<br>
...$ singularity sif dump 1 /lambda_stor/slurm/cbcore_images/cbcore_latest.sif | grep "from"<br>
from: cbcore:1.1.1-202203171919-5-6e2dbf07<br>
...$ <br>
</strong>
</td>
</tr>
</tbody>
</table>


