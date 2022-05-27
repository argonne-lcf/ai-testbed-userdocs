# Example Programs

Example programs are provided below for your use.

## Set PYTHONPATH

Find the Python path using the command:

```bash
which python
```

The output will look something like:

```bash
/usr/bin/python

# Or inside a birtual environment
/lambda_stor/homes/ALCFUserID/my_env/bin/python
```

Set PYTHONPATH

```bash
export PYTHONPATH=/path/to/python
```

Then

```bash
export PYTHONPATH=/path/to/Model-References:$PYTHONPATH
```

If **Model-References** is in your root directory, the command would be

```bash
export PYTHONPATH=~/Model-References:$PYTHONPATH
```

## Copy Examples

Habana provides examples of some well known AI applications under the path: `/software/habana/apps/1.4.1/Model-References`, on the Habana compute node hb-01. Make a copy of this to your home directory:

```bash
cd ~/
cp -r /software/habana/apps/1.4.1/Model-References .
```

## Common Arguments

Below are some of the common arguments used across most of the models in the example code.

| Argument               | Default   | Help                           |
|------------------------|-----------|--------------------------------|
| -b                     | 1         | Batch size for training        |
| -batch-size            |           |                                |
|                        |           |                                |
| --epochs               | 1         | Number epochs for training     |
|                        |           |                                |
| --world_size           | 1         | --world_size                   |
|                        |           |                                |
| --distributed          |           | Distribute training            |
|                        |           |                                |
| --hpu                  |           | Gaudi training                 |
|                        |           |                                |
| --data_type            |           | Specify data type to be either bf16 or fp32. |
|                        |           |                                |
| --distributed          |           | whether to enable distributed mode |
|                        |           | and run on multiple devices        |
|                        |           |                                |

## MNIST

Change directory

```bash
cd ~/Model-References/PyTorch/examples/computer_vision/hello_world
```

### Demo_mnist Arguments

| Argument               | Default   | Help                           |
|------------------------|-----------|--------------------------------|
| --lr                   | 1.0       | Learning rate for training     |
|                        |           |                                |
| --gamma                | 0.7       | Learning rate step gamma       |
|                        |           |                                |
| --data-path            | '../data' | input data path for train and test |
|                        |           |                                |

#### Single Gaudi Run Commands

Single Gaudi FP32 eager mode run command:

```bash
python demo_mnist.py --hpu
```

Single Gaudi BF16 eager mode run command:

```bash
python demo_mnist.py --hpu --hmp
```

Single Gaudi FP32 lazy mode run command:

```bash
python demo_mnist.py --hpu --use_lazy_mode
```

Single Gaudi BF16 lazy mode run command:

```bash
python demo_mnist.py --hpu --hmp --use_lazy_mode
```

#### Multi-HPU run commands

**NOTE: These run examples use PyTorch DDP, Distributed Data Parallel.
This is accomplished by using model replica,
splitting of data, and averaging the gradient through allreduce.
The HCCL, Habana Collective Communication Library, is used to perform these operations.***

There are eight Gaudi cards on the system.

Eight Gaudi FP32 eager mode run command:

```bash
python demo_mnist.py --hpu --data_type fp32 --world_size 8
```

Eight Gaudi BF16 eager mode run command:

```bash
python demo_mnist.py --hpu --data_type bf16 --world_size 8
```

Eight Gaudi FP32 lazy mode run command:

```bash
python demo_mnist.py --hpu --data_type fp32 --use_lazy_mode --world_size 8
```

Eight Gaudi BF16 lazy mode run command:

```bash
python demo_mnist.py --hpu --data_type bf16 --use_lazy_mode --world_size 8
```

## UNet --> Broken <--

Change directory

```bash
cp -r /software/sambanova/apps/1.10.3-11/image apps/image
cd ~/apps/image/pytorch/unet
export OUTDIR=~/apps/image/pytorch/unet
export DATADIR=/software/sambanova/dataset/kaggle_3m
```

Export the path to the dataset which is required for the training.

Run these commands for training (compile + train):

```bash
srun python unet.py compile --in-channels=3 --in-width=32 --in-height=32 --init-features 32 --batch-size 1 --pef-name="unet_train" --output-folder=${OUTDIR}
srun python unet.py run --do-train --in-channels=3 --in-width=32 --in-height=32 --init-features 32 --batch-size 1 --data-dir $DATADIR --log-dir ${OUTDIR} --epochs 5 --pef=${OUTDIR}/unet_train/unet_train.pef
```

Using Slurm:  To use Slurm, create submit-unet-job.sh with the following
contents:

```bash
#!/bin/sh
export OUTDIR=~/apps/image/pytorch/unet
export DATADIR=/software/sambanova/dataset/kaggle_3m
python unet.py compile --in-channels=3 --in-width=32 --in-height=32 --init-features 32 --batch-size 1 --pef-name="unet_train" --output-folder=${OUTDIR}
python unet.py run --do-train  --in-channels=3  --in-width=32  --in-height=32 --init-features 32 --batch-size=1 --data-dir $DATADIR --log-dir ${OUTDIR}/log_dir_unet32_train --epochs 5 --pef=${OUTDIR}/unet_train/unet_train.pef
```

Then

```bash
sbatch submit-unet-job.sh
```

junk
more junk

### Model Overview

The base model used is from [GitHub: nnUNet](https://github.com/NVIDIA/DeepLearningExamples/tree/2b20ca80cf7f08585e90a11c5b025fa42e4866c8/PyTorch/Segmentation/nnUNet). As in the base scripts, Pytorch Lightning is used.

### Setup

Follow the instructions at [Virtual Environment](Virtual-Environment.md) and create a
virtual environment named **unet-venv**.  Activate the virtual environment.

The base training and modelling scripts for training are based on a clone of
[nnUNet](https://github.com/NVIDIA/DeepLearningExamples/tree/2b20ca80cf7f08585e90a11c5b025fa42e4866c8/PyTorch/Segmentation/nnUNet)
with certain changes in training scripts.
Please refer to later sections on training script and model modifications for a summary of
modifications to the original files.

Change directory

```bash
cd ~/Model-References/PyTorch/computer_vision/segmentation/Unet
```

Note: If **Model-References** is not in the PYTHONPATH, make sure you update it.

```bash
export PYTHONPATH=/path/to/Model-References:$PYTHONPATH
```

#### Install the Requirements

It is necessary to install the required packages in `requirements.txt` to run
the model and download dataset.

```bash
pip install -r ./requirements.txt
```

#### Set up BraTS Dataset

TODOBRW: Put this in a central location such as
/software/habana/datasets/brats or
/datasets/brats

TODOBRW: There will be two sub-directories `01_2d` for Unet2D and `01_3d`
for Unet3D model.

Create a /data directory if not present:

```bash
mkdir /data
```

To download the dataset run:

```python
python download.py --task 01
```

NOTE: The script downloads the dataset in /data directory by default.

To preprocess it for Unet2D run:

parser.add_argument("--data", type=str, default="/data", help="Path to data directory")
parser.add_argument("--results", type=str, default="/data", help="Path for saving results directory")

<!-- TODOBRW fix these paths -->

```bash
python preprocess.py --task 01 --dim 2 --data /path/to/data --results /path/to/results
```

To process it for Unet3D run:

```bash
python preprocess.py --task 01 --dim 3 --data /path/to/data --results /path/to/results
```

NOTE: The script preprocess the dataset downloaded in above step from
the specified data directory and creates directory `01_2d` for Unet2D and directory `01_3d`
for Unet3D model inside the specified data directory.
