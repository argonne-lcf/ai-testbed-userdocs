# Example Programs

## Use a local copy of the model zoo
Make a local copy of the Cerebras modelzoo and anl_shared repository if not done before using,  

```bash
mkdir ~/R1.1.0/
cp -r /software/cerebras/model_zoo/modelzoo-R1.1.0 ~/R1.1.0/modelzoo
cp -r /software/cerebras/model_zoo/anl_shared-R1.1.0/ ~/R1.1.0/anl_shared
```


## Unet
To run Unet with the <a href="https://www.kaggle.com/c/severstal-steel-defect-detection">Severstal: Steel Defect Detection</a> kaggle dataset, using a pre-downloaded copy of the dataset,

```console
cd ~/R1.1.0/modelzoo/unet/tf
#rm -r model_dir_unet_base_severstal
csrun_cpu python run.py --mode=train --compile_only --params configs/params_severstal_sharedds.yaml --model_dir model_dir_unet_base_severstal --cs_ip 192.168.220.50
csrun_wse python run.py --mode=train --params configs/params_severstal_sharedds.yaml --model_dir model_dir_unet_base_severstal --cs_ip 192.168.220.50
```
## Bert
This BERT-large msl128 example uses a single sample dataset for both training and evaluation. See the README.md in source directory for details on how to build a dataset from text input.
```console
cd ~/R1.1.0/modelzoo/transformers/tf/bert
#rm -r model_dir_bert_large_msl128
csrun_cpu python run.py --mode=train --compile_only --params configs/params_bert_large_msl128_sampleds.yaml --model_dir model_dir_bert_large_msl128 --cs_ip 192.168.220.50
csrun_wse python run.py --mode=train --params configs/params_bert_large_msl128_sampleds.yaml --model_dir model_dir_bert_large_msl128 --cs_ip 192.168.220.50
```

## BraggNN
The BraggNN model has two versions:<br>
1) Convolution only - this version does not include the non-local attention block<br>
2) Nonlocal - This version includes the nonlocal attention block as described in  <br>
[https://arxiv.org/pdf/1711.07971.pdf](https://arxiv.org/pdf/1711.07971.pdf)

```console
cd ~/R1.1.0/anl_shared/braggnn/tf
#rm -r model_dir_braggnn
csrun_cpu python run.py -p configs/params_bragg_nonlocal.yaml --model_dir model_dir_braggnn --mode train --compile_only --cs_ip 192.168.220.50
csrun_wse python run.py -p configs/params_bragg_nonlocal.yaml --model_dir model_dir_braggnn --mode train --cs_ip 192.168.220.50
```

## Training in CPU-mode (move this someplace else?)

The examples in the modelzoo<!--- [TODO And PyTorch?]--> will run in CPU mode as either csrun_cpu jobs, or in a singularity shell as shown below.<br>
<i>If no cs_ip is specified, a training run will be in cpu mode. </i>

Change the max steps for the training run command line to something smaller than the default so that the training completes in a reasonable amount of time. (CPU mode is &gt;2 orders of magnitude slower for many examples.)

This illustrates how to create a singularity container.
The `-B /opt:/opt` is an illustrative example of how to bind a directory to a singularity container. (The singularity containers by default bind both one's home directory and /tmp, read/write.)
The current directory in the container will be the same as the current directory immediately prior to creating the container.
```console
cd ~/R1.1.0/modelzoo/fc_mnist/tf
singularity shell -B /opt:/opt /lambda_stor/slurm/cbcore_images/cbcore_latest.sif
```

At the shell prompt for the container, 
```console
#rm -r model_dir
# compile and train on the CPUs
python run.py --mode train --max_steps 1000
python run.py --mode eval --eval_steps 1000
# validate_only is the first portion of a compile
python run.py --mode train --validate_only
# remove the existing compile and training artifacts
rm -r model_dir
# compile_only does a compile but no training
python run.py --mode train --compile_only
```

