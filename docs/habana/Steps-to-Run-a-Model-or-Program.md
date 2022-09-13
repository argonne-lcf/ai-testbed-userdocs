# Steps to Run a Model/Program

**NOTE:  Please be mindful of how you are using the system.
For example, consider running larger jobs in the evening or on weekends.**

## Introduction

[Example Programs](Example-Programs.md) lists the different example applications with
corresponding commands.

## Copy Examples

Habana provides examples of some well known AI applications under the path. Clone the repository to your home directory.

```bash
cd ~/
git clone https://github.com/HabanaAI/Model-References.git
cd Model-References
git checkout 1.6.0
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
/home/CELSGCEUserID/my_env/bin/python3
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

## Run

This will run the application on a Habana node.

```bash
cd ~/Model-References/PyTorch/examples/computer_vision/hello_world
python mnist.py --hpu
```
