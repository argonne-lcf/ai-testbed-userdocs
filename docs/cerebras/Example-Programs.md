# Example Programs

## Use a local copy of the model zoo
Make a local copy of the Cerebras modelzoo and anl_shared repository if not done before using,  

```bash
mkdir ~/R1.1.0/
cp -r /software/cerebras/model_zoo/modelzoo-R1.1.0 ~/R1.1.0/modelzoo
cp -r /software/cerebras/model_zoo/anl_shared-R1.1.0/ ~/R1.1.0/anl_shared
```


## Unet
An implementation of this: [U-Net: Convolutional Networks for Biomedical Image Segmentation](https://arxiv.org/pdf/1505.04597.pdf), Ronneberger et.  al 2015<br>
To run Unet with the <a href="https://www.kaggle.com/c/severstal-steel-defect-detection">Severstal: Steel Defect Detection</a> kaggle dataset, using a pre-downloaded copy of the dataset,

```console
cd ~/R1.1.0/modelzoo/unet/tf
#rm -r model_dir_unet_base_severstal
csrun_cpu python run.py --mode=train --compile_only --params configs/params_severstal_sharedds.yaml --model_dir model_dir_unet_base_severstal --cs_ip 192.168.220.50
csrun_wse python run.py --mode=train --params configs/params_severstal_sharedds.yaml --model_dir model_dir_unet_base_severstal --cs_ip 192.168.220.50
```
## Bert
An implementation of this: [BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding](https://arxiv.org/abs/1810.04805)<br>
This BERT-large msl128 example uses a single sample dataset for both training and evaluation. See the README.md in source directory for details on how to build a dataset from text input.
```console
cd ~/R1.1.0/modelzoo/transformers/tf/bert
#rm -r model_dir_bert_large_msl128
csrun_cpu python run.py --mode=train --compile_only --params configs/params_bert_large_msl128_sampleds.yaml --model_dir model_dir_bert_large_msl128 --cs_ip 192.168.220.50
csrun_wse python run.py --mode=train --params configs/params_bert_large_msl128_sampleds.yaml --model_dir model_dir_bert_large_msl128 --cs_ip 192.168.220.50
```

## BraggNN
An implementation of this: [BraggNN: fast X-ray Bragg peak analysis using deep
learning](https://journals.iucr.org/m/issues/2022/01/00/fs5198/fs5198.pdf)<br>
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


