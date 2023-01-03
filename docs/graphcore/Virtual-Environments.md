# Virtual Environments

## SDK Setup

The Graphcore system has a bash shell scripts to set up the required software environment.

Use

```bash
source /software/graphcore/poplar_sdk/3.0.0/enable
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

## PopART Environment Setup

Run these commands:

```bash
mkdir -p ~/venvs/graphcore
virtualenv ~/venvs/graphcore/poptorch30_env
source ~/venvs/graphcore/poptorch30_env/bin/activate
```

Use the following commands to install PopTorch.

```bash
POPLAR_SDK_ROOT=/software/graphcore/poplar_sdk/3.0.0
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

export PYTHONPATH=/software/graphcore/poplar_sdk/3.0.0/poplar-ubuntu_20_04-3.0.0+5691-1e179b3b85/python:$PYTHONPATH
```

## TensorFlow 2 Environment Setup

```bash
virtualenv ~/venvs/graphcore/tensorflow2_env
source ~/venvs/graphcore/tensorflow2_env/bin/activate
POPLAR_SDK_ROOT=/software/graphcore/poplar_sdk/3.0.0
export POPLAR_SDK_ROOT=$POPLAR_SDK_ROOT
pip install $POPLAR_SDK_ROOT/tensorflow-2.6.3+gc3.0.0+236842+d084e493702+amd_znver1-cp38-cp38-linux_x86_64.whl
```

### Verify Installation

```bash
python -c "from tensorflow.python import ipu"
```

You should see:

```bash
2023-01-03 20:32:20.907256: I tensorflow/compiler/plugin/poplar/driver/poplar_platform.cc:43] Poplar version: 3.0.0 (fa83d31c56) Poplar package: 1e179b3b85
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
