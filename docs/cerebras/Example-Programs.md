Cerebras
========

### Example Programs
Follow the instructions in the TensorFlow quickstart to train, evaluate and validate the fc\_mnist TensorFlow estimator example. This model is a couple of fully connected layers plus dropout and RELU. <br>
[TODO need a pointer to a mirror of the current Cerebras public documentation]<br>
[TODO perhaps also a pointer to the Cerebras's public reference model github repo -  https://github.com/Cerebras/cerebras_reference_implementations/ - includes fc_mnist(tf, pytorch) and BERT(tf, pytorch).]<br>
[TODO perhaps also describe the parameterized simple model used for benchmarking]<br>
[TODO Describe the available samples in the Cerebras modelzoo]<br>

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



