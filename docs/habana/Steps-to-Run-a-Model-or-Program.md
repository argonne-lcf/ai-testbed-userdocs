# Steps to Run a Model/Program

**NOTE:  Please be mindful of how you are using the system.
For example, consider running larger jobs in the evening or on weekends.**

## Introduction

[Example Programs](Example-Programs.md) lists the different example applications with
corresponding commands.

## Copy Examples

Habana provides examples of some well known AI applications under the path: `/lambda_stor/habana/apps/1.4.1/Model-References`, on the Habana compute node **habana1** or **habana2**. Make a copy of this to your home directory:

```bash
cd ~/
cp -r /lambda_stor/habana/apps/1.4.1/Model-References .
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

## Venv

You will need to follow the directions in the Virtual-Environment.pdf for the
next section to work.

## Run

This will run the application on a Habana node.

```bash
cd ~/Model-References/PyTorch/examples/computer_vision/hello_world
python demo_mnist.py --hpu
```
