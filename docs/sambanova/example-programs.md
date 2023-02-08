# Example Programs

SambaNova provides examples of some well-known AI applications under the path: `/opt/sambaflow/apps/starters`, on all SambaNova nodes. Make a copy of this to your home directory:

Copy starters to your personal directory structure:

```bash
cd
mkdir apps
cp -r /opt/sambaflow/apps/starters apps/starters
```

## LeNet

Activate venv:

```bash
source /opt/sambaflow/apps/starters/lenet/venv/bin/activate
```

Change directory

```bash
cd ~/apps/starters/lenet
```

### Common Arguments

Below are some of the common arguments used across most of the models in the example code.

| Argument               | Default   | Help                           |
|------------------------|-----------|--------------------------------|
| -b                     | 1         | Batch size for training        |
|                        |           |                                |
| -n,                    | 100       | Number of iterations to run    |
| --num-iterations       |           | the pef for                    |
|                        |           |                                |
| -e,                    | 1         | Number epochs for training     |
| --num-epochs           |           |                                |
|                        |           |                                |
| --log-path             | 'check    | Log path                       |
|                        | points'   |                                |
|                        |           |                                |
| --num-workers          | 0         | Number of workers              |
|                        |           |                                |
| --measure-train-       | None      | Measure training performance   |
| performance            |           |                                |
|                        |           |                                |

### LeNet Arguments

| Argument               | Default   | Help                           |
|------------------------|-----------|--------------------------------|
| --lr                   | 0.01      | Learning rate for training     |
|                        |           |                                |
| --momentum             | 0.0       | Momentum value for training    |
|                        |           |                                |
| --weight-decay         | 0.01      | Weight decay for training      |
|                        |           |                                |
| --data-path            | './data'  | Data path                      |
|                        |           |                                |
| --data-folder          | 'mnist_   | Folder containing mnist data   |
|                        | data'     |                                |
|                        |           |                                |

**NOTE:  If you receive an \"HTTP error\" message on any of the
following commands, run the command again. Such errors (e.g 503) are
commonly an intermittent failure to download a dataset.**

Run these commands:

```bash
srun python lenet.py compile -b=1 --pef-name="lenet" --output-folder="pef"
srun python lenet.py run --pef="pef/lenet/lenet.pef"
```

To use Slurm sbatch, create submit-lenet-job.sh with the following
contents:

```bash
#!/bin/sh

python lenet.py compile -b=1 --pef-name="lenet" --output-folder="pef"
python lenet.py run --pef="pef/lenet/lenet.pef"
```

Then

```bash
sbatch --output=pef/lenet/output.log submit-lenet-job.sh
```

Squeue will give you the queue status.

```bash
squeue
# One may also...
watch squeue
```

The output file will look something like this:

```text
[Info][SAMBA][Default] # Placing log files in
pef/lenet/lenet.samba.log

[Info][MAC][Default] # Placing log files in
pef/lenet/lenet.mac.log

[Warning][SAMBA][Default] #

--------------------------------------------------

Using patched version of torch.cat and torch.stack

--------------------------------------------------

[Warning][SAMBA][Default] # The dtype of "targets" to
CrossEntropyLoss is torch.int64, however only int16 is currently
supported, implicit conversion will happen

[Warning][MAC][GraphLoweringPass] # lenet__reshape skip
set_loop_to_air

[Warning][MAC][GraphLoweringPass] # lenet__reshape_bwd skip
set_loop_to_air

...

Epoch [1/1], Step [59994/60000], Loss: 0.1712

Epoch [1/1], Step [59995/60000], Loss: 0.1712

Epoch [1/1], Step [59996/60000], Loss: 0.1712

Epoch [1/1], Step [59997/60000], Loss: 0.1712

Epoch [1/1], Step [59998/60000], Loss: 0.1712

Epoch [1/1], Step [59999/60000], Loss: 0.1712

Epoch [1/1], Step [60000/60000], Loss: 0.1712

Test Accuracy: 98.06 Loss: 0.0628

2021-6-10 10:52:28 : [INFO][SC][53607]: SambaConnector: PEF File:
pef/lenet/lenet.pef

Log ID initialized to: [ALCFUserID][python][53607] at
/var/log/sambaflow/runtime/sn.log
```

## MNIST - Feed Forward Network

Activate venv:

```bash
source /opt/sambaflow/apps/starters/ffn_mnist/venv/bin/activate
```

Change directory

```bash
cd ~/apps/starters/ffn_mnist/
```

Commands to run MNIST example:

```bash
srun python ffn_mnist.py compile --pef-name="ffn_mnist" --output-folder="pef"
srun python ffn_mnist.py run --pef="pef/ffn_mnist/ffn_mnist.pef"
```

To run the same using Slurm sbatch, create and run the submit-ffn_mnist-job.sh with the following contents.

```bash
#!/bin/sh
python ffn_mnist.py compile --pef-name="ffn_mnist" --output-folder="pef"
python ffn_mnist.py run --pef="pef/ffn_mnist/ffn_mnist.pef"
```

```bash
sbatch --output=pef/ffn_mnist/output.log submit-ffn_mnist-job.sh
```

## Logistic Regression

Activate venv:

```bash
source /opt/sambaflow/apps/starters/logreg/venv/bin/activate
```

Change directory

```bash
cd ~/apps/starters/logreg
```

### Logistic Regression Arguments

This is not an exhaustive list of arguments.

Arguments

| Argument            | Default     | Help                         | Step     |
|---------------------|-------------|------------------------------|----------|
| --lr                | 0.001       | Learning rate for training   | Compile  |
|                     |             |                              |          |
| --momentum          | 0.0         | Momentum value for training  | Compile  |
|                     |             |                              |          |
| --weight-decay      | 1e-4        | Weight decay for training    | Compile  |
|                     |             |                              |          |
| --num-features      | 784         | Number features for training | Compile  |
|                     |             |                              |          |
| --num-classes       | 10          | Number classes for training  | Compile  |
|                     |             |                              |          |
| --weight-norm       | na          | Enable weight normalization  | Compile  |
|                     |             |                              |          |

Run these commands:

```bash
srun python logreg.py compile --pef-name="logreg" --output-folder="pef"
srun python logreg.py test --pef="pef/logreg/logreg.pef"
srun python logreg.py run --pef="pef/logreg/logreg.pef"
```

To use Slurm, create submit-logreg-job.sh with the following contents:

```bash
#!/bin/sh
python logreg.py compile --pef-name="logreg" --output-folder="pef"
python logreg.py test --pef="pef/logreg/logreg.pef"
python logreg.py run --pef="pef/logreg/logreg.pef"
```

Then

```bash
sbatch --output=pef/logreg/output.log submit-logreg-job.sh
```

The output, pef/logreg/output.log, will look something like this:

```text
[Info][SAMBA][Default] # Placing log files in
pef/logreg/logreg.samba.log
[Info][MAC][Default] # Placing log files in
pef/logreg/logreg.mac.log
[Warning][SAMBA][Default] #
--------------------------------------------------
Using patched version of torch.cat and torch.stack
--------------------------------------------------

[Warning][SAMBA][Default] # The dtype of "targets" to
CrossEntropyLoss is torch.int64, however only int16 is currently
supported, implicit conversion will happen
[Warning][MAC][MemoryOpTransformPass] # Backward graph is trimmed
according to requires_grad to save computation.
[Warning][MAC][WeightShareNodeMergePass] # Backward graph is
trimmed according to requires_grad to save computation.
[Warning][MAC][ReduceCatFaninPass] # Backward graph is trimmed
according to requires_grad to save computation.
[info ] [PLASMA] Launching plasma compilation! See log file:
/home/ALCFUserID/apps/starters/pytorch/pef/logreg//logreg.plasma_compile.log
...

[Warning][SAMBA][Default] # The dtype of "targets" to
CrossEntropyLoss is torch.int64, however only int16 is currently
supported, implicit conversion will happen
Epoch [1/1], Step [10000/60000], Loss: 0.4763
Epoch [1/1], Step [20000/60000], Loss: 0.4185
Epoch [1/1], Step [30000/60000], Loss: 0.3888
Epoch [1/1], Step [40000/60000], Loss: 0.3721
Epoch [1/1], Step [50000/60000], Loss: 0.3590
Epoch [1/1], Step [60000/60000], Loss: 0.3524
Test Accuracy: 90.07 Loss: 0.3361
2021-6-11 8:38:49 : [INFO][SC][99185]: SambaConnector: PEF File:
pef/logreg/logreg.pef
Log ID initialized to: [ALCFUserID][python][99185] at
/var/log/sambaflow/runtime/sn.log
```

## Gpt 1.5B

The script to compile and run the Gpt model is as below and the same is present under the directory /data/ANL/scripts. The model is present under the directory /opt/sambaflow/apps/nlp/transformers_on_rdu/. This model uses 1.5B parameters and by default is run across all the nodes in the system(--nodelist sn30-r1-h1,sn30-r1-h2,sn30-r2-h1,sn30-r2-h2,sn30-r3-h1,sn30-r3-h2,sn30-r4-h1,sn30-r1-h2).
The modified version below will run on the node from which it is launched, and will use that entire node. It will stay queued, waiting for resources, until the full node is available.

```bash
#! /bin/bash
set -e
export SF_RNT_LOG_LEVEL=DEBUG
ACTIVATE=/opt/sambaflow/apps/nlp/transformers_on_rdu/venv/bin/activate
LOGDIR=`date +%m%d%y.%H`
if [ "$1" ] ; then
LOGDIR=$1
fi
MODEL_NAME="Gpt1.5B"
OUTPUT_PATH=/data/ANL/results/$(hostname)/${USER}/${LOGDIR}/${MODEL_NAME}.out
echo "Using ${OUTPUT_PATH} for output"
mkdir -p /data/ANL/results/$(hostname)/${USER}/${LOGDIR}

#######################
# Edit these variables.
#######################
export OMP_NUM_THREADS=18
#######################
# Start script timer
SECONDS=0
# Temp file location
DIRECTORY=$$
OUTDIR=/data/scratch/${USER}/GPT_RUN
mkdir -p ${OUTDIR}
source ${ACTIVATE}
echo "Model: " ${MODEL_NAME} > ${OUTPUT_PATH} 2>&1
echo "Date: " $(date +%m/%d/%y) >> ${OUTPUT_PATH} 2>&1
echo "Time: " $(date +%H:%M) >> ${OUTPUT_PATH} 2>&1
cd ${OUTDIR}
#######################
echo "Machine State Before: " >> ${OUTPUT_PATH} 2>&1
/opt/sambaflow/bin/snfadm -l inventory >> ${OUTPUT_PATH} 2>&1
if [ ! -e  ${OUTDIR}/gpt15/gpt15.pef ] ; then
  #######################
  echo "COMPILE START AT ${SECONDS}" >> ${OUTPUT_PATH} 2>&1

  COMMAND="python /opt/sambaflow/apps/nlp/transformers_on_rdu/transformers_hook.py compile --module_name gpt2_pretrain --task_name clm --max_seq_length 1024 -b 16 --output_dir=${OUTDIR}/hf_output --overwrite_output_dir --do_train  --per_device_train_batch_size 16 --cache ${OUTDIR}/cache/ --tokenizer_name gpt2 --model_name gpt2 --mac-v2 --non_split_head --mac-human-decision /opt/sambaflow/apps/nlp/transformers_on_rdu/human_decisions_gm/mac_v2_overrides/gpt2_48_enc_full_recompute_training_spatialmapping_tiling16_clmerge_gm_nonpardp_anl.json --compiler-configs-file /opt/sambaflow/apps/nlp/transformers_on_rdu/human_decisions_gm/compiler_configs/compiler_configs_gpt2_sc_recompute_spatialmapping_tiling16_clsmerge_withcls_nogroups.json --skip_broadcast_patch --config_name /opt/sambaflow/apps/nlp/transformers_on_rdu/customer_specific/mv/configs/gpt2_config_xl_50260.json --no_index_select_patch --data-parallel -ws 2 --weight_decay 0.1  --max_grad_norm_clip 1.0 --num-tiles 4 --pef-name=gpt15 --output-folder=${OUTDIR}"

  echo "COMPILE COMMAND: $COMMAND" >> ${OUTPUT_PATH} 2>&1
  eval $COMMAND >> ${OUTPUT_PATH} 2>&1
  echo "COMPILE END AT ${SECONDS}" >> ${OUTPUT_PATH} 2>&1
fi
#######################
echo "RUN" >> ${OUTPUT_PATH} 2>&1
/usr/local/bin/sbatch --output=${HOME}/slurm-%A.out --ntasks 16 --gres=rdu:8 --ntasks-per-node 16  --cpus-per-task=8 --nodes 1 --nodelist $(hostname) /data/ANL/scripts/Gpt1.5B_run.sh >> ${OUTPUT_PATH} 2>&1

echo "Machine state After: " >> ${OUTPUT_PATH} 2>&1
/opt/sambaflow/bin/snfadm -l inventory >> ${OUTPUT_PATH} 2>&1
echo "Duration: " $SECONDS >> ${OUTPUT_PATH} 2>&1

```

Note: The RUN command uses the sbatch cmd to avoid any resource contention.

The logs are present under the directory : /data/ANL/results/$(hostname)/${USER}/

Squeue will give you the queue status.

```bash
squeue
```
