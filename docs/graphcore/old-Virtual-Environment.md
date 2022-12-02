# Virtual Environments

## SDK Setup

The Graphcore system has bash shell scripts to set up the required software environment.

Use

```bash
source /lambda_stor/software/graphcore/poplar_sdk/3.0.0/popart-ubuntu_20_04-3.0.0+5691-1e179b3b85/enable.sh
source /lambda_stor/software/graphcore/poplar_sdk/3.0.0/poplar-ubuntu_20_04-3.0.0+5691-1e179b3b85/enable.sh
```

Ignore the error from the second command.

Check if poplar is setup correctly

```bash
popc --version
```

You should see this:

```bash
POPLAR version 3.0.0 (fa83d31c56)
clang version 15.0.0 (e7341b5ca5d49496b6635766521ad7a74154747a)
```

## Create a Virtual Environment

Run these commands:

```bash
mkdir -p ~/venvs/graphcore
virtualenv ~/venvs/graphcore/poptorch30_env
source ~/venvs/graphcore/poptorch30_env/bin/activate
```

## Install PopTorch

Use the following commands to install PopTorch.

```bash
POPLAR_SDK_ROOT=/lambda_stor/software/graphcore/poplar_sdk/3.0.0
export POPLAR_SDK_ROOT=$POPLAR_SDK_ROOT
pip install $POPLAR_SDK_ROOT/poptorch-3.0.0+86945_163b7ce462_ubuntu_20_04-cp38-cp38-linux_x86_64.whl
```

## Miscellaneous Environment Variables

```bash
mkdir ~/tmp
export TF_POPLAR_FLAGS=--executable_cache_path=~/tmp
export POPTORCH_CACHE_DIR=~/tmp

export POPART_LOG_LEVEL=WARN
export POPLAR_LOG_LEVEL=WARN
export POPLIBS_LOG_LEVEL=WARN

export PYTHONPATH=/lambda_stor/software/graphcore/poplar_sdk/3.0.0/poplar-ubuntu_20_04-3.0.0+5691-1e179b3b85/python:$PYTHONPATH
```

## TensorFlow 2 Environment Setup

```bash
virtualenv ~/venvs/graphcore/tensorflow2_env
source ~/venvs/graphcore/tensorflow2_env/bin/activate
POPLAR_SDK_ROOT=/lambda_stor/software/graphcore/poplar_sdk/3.0.0
export POPLAR_SDK_ROOT=$POPLAR_SDK_ROOT
pip install $POPLAR_SDK_ROOT/tensorflow-2.6.3+gc3.0.0+236852+d084e493702+intel_skylake512-cp38-cp38-linux_x86_64.whl
```

### Verify Installation

```bash
xxpython -c "from tensorflow.python import ipu"
```

You should see:

```bash
2021-12-16 18:07:47.882842: I tensorflow/compiler/plugin/poplar/driver/poplar_platform.cc:44] Poplar version: 2.3.0 (d9e4130346) Poplar package: 88f485e763
```

## Installing Packages

Install packages in the normal manner such as:

```bash
python3 -m pip install "some_package"
```

For more details see [Use pip for installing](https://packaging.python.org/en/latest/tutorials/installing-packages/#use-pip-for-installing).

To install a different version of a package that is already installed in one's environment, one can use:

```bash
pip install --ignore-installed  ... # or -I
```

**NOTE: Conda is not supported on the Graphcore system.**
