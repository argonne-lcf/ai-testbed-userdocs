# Steps to Run a Model/Program

**NOTE:  Please be mindful of how you are using the system.
For example, consider running larger jobs in the evening or on weekends.**

## Introduction

[Example Programs](Example-Programs.md) lists the different example applications with
corresponding commands for each of the above steps.

## Set PYTHONPATH

Find the Python path using the command:

```bash
which python
```

The output will look something like:

```bash
/usr/bin/python

# Or inside a virtual environment
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

## Run

This will run the application on a Habana node.

```bash
$PYTHON demo_mnist.py --hpu
```
