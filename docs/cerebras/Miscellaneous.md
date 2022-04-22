# Miscellaneous



## Downloading a dataset from www.kaggle.com to a CS-2 node using the command line

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


It will download as a zip file. ('unzip' is available testbed-cs2-02-med8)

exit the singularity container to unzip the dataset zip file

Note: the kaggle download shown above included two identical copies of the dataset; one copy was in a subdirectory.

<!---
## Running Tensorboard from testbed-cs2-02-med8
--------------------------------

[TODO remove this when Tunneling and fowarding ports is one]

if you are trying to run the tensorboard from cs2, launch the command from the testbed-cs2-02-med8 terminal and you will see the output as given below.<br/>
TODO this doesn't actually work; test/fix when CS-2 is working again. 
|                                                                                                                                                                                                                                                             |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **\[&lt;ALCFid&gt;@testbed-cs2-02-med8 simple\_model\]$ ./srun\_singularity tensorboard --bind\_all --logdir iris/model\_dir --port 9999**<br/>
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
--->

<embed src="media/image1.tmp" width="468" height="239" />
=========================================================

## PyTorch Support
The PyTorch samples in Cerebras release 1.1 are a preview of of the release 1.2 support. See below for the commands to run a basic sample.
<table>
<tbody>
<tr class="odd">
<td>
<strong> 
...$ cd ~/modelzoo-R1.1.0/fc_mnist/pytorch$<br>
...$ rm -r model_dir/<br>
...$ csrun_cpu python-pt run.py --mode train --compile_only --params configs/params.yaml <br>
...$ csrun_cpu python-pt run.py --mode train --params configs/params.yaml  --cs_ip 192.168.220.50:9000<br>
</strong>
</td>
</tr>
</tbody>
</table>

## Determining the CS-2 version


<!---
[TODO should this API/auth string be made public? Alternative supplied that inspects the singularity container.]
Note: replace the IP address with the CS_IP for the CS-2 cluster being used.<br>
--->
[TODO could use CS_IP environment variable if set.]
<table>
<tbody>
<tr class="odd">
<td>
<strong>
...$ # Query the firmware level<br>
...$ curl -k -X GET 'https://192.168.120.50/redfish/v1/Managers/manager' --header 'Authorization: Basic YWRtaW46YWRtaW4=' 2> /dev/null  | python -m json.tool | grep FirmwareVersion<br>
"FirmwareVersion": "1.1.1-202203171919-5-879ff4ef",<br>
...$ <br>
...$ # Query the software level in the singularity image<br>
...$ singularity sif dump 1 /lambda_stor/slurm/cbcore_images/cbcore_latest.sif | grep "from"<br>
from: cbcore:1.1.1-202203171919-5-6e2dbf07<br>
...$ <br>
</strong>
</td>
</tr>
</tbody>
</table>


## Viewing the Cerebras V 1.1 documenation
The Cerebras V 1.1 documentation is stored on the cerebras systems and can be served to be viewed with a local browser by running to following in a command prompt on your workstation/laptop.<br>
*Change the ALCFUserID to your id.*<br>
If there is a port conflict, use a different port number in either the second and third port number instance, or all three of them.
<table>
<tbody>
<tr class="odd">
<td>
<strong>
ssh -t -L localhost:8089:localhost:8089 ALCFUserID@cerebras.alcf.anl.gov  "cd /software/cerebras/docs/V1.1/;python3 -m http.server 8089"
</strong>
</td>
</tr>
</tbody>
</table>
To view, view url localhost:8089 with your browser.

This v 1.1 documentation tree can also be copied to your laptop/workstation and the files can be viewed locally with a browser. The cerebras system has a tar file at /software/cerebras/docs/Cerebras_ML_SW_Docs_V1.1.tar

