# Example Programs

Example programs are provided below for your use.

## Copy Examples

Habana provides examples of some well known AI applications under the path: `/lambda_stor/habana/apps/1.4.1/Model-References`, on the Habana compute node **habana1** or  **habana2**. Make a copy of this to your home directory:

```bash
cd ~/
cp -r /lambda_stor/habana/apps/1.4.1/Model-References .
```

One can access the latest version by

```bash
git clone https://github.com/HabanaAI/Model-References.git
```

## Set PYTHONPATH

Find the Python path using the command:

```bash
which python3
```

The output will look something like:

```bash
/usr/bin/python3

# Or inside a virtual environment
/lambda_stor/homes/CELSUserID/my_env/bin/python3
```

Set PYTHONPATH

```bash
export PYTHONPATH=/path/to/python3
```

Then

```bash
export PYTHONPATH=/path/to/Model-References:$PYTHONPATH
```

If **Model-References** is in your root directory, the command would be

```bash
export PYTHONPATH=~/Model-References:$PYTHONPATH
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
The HCCL, Habana Collective Communication Library, is used to perform these operations.**

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
