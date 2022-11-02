# Virtual Environments to Customize Environment

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

Note: Conda is not supported on the SambaNova system.
