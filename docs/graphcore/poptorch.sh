#!/bin/bash
# exit when any command fails
#set -e
source /lambda_stor/software/graphcore/poplar_sdk/3.0.0/popart-ubuntu_20_04-3.0.0+5691-1e179b3b85/enable.sh
source /lambda_stor/software/graphcore/poplar_sdk/3.0.0/poplar-ubuntu_20_04-3.0.0+5691-1e179b3b85/enable.sh
mkdir -p ~/venvs/graphcore
rm -rf ~/venvs/graphcore/poptorch30_env
virtualenv ~/venvs/graphcore/poptorch30_env
source ~/venvs/graphcore/poptorch30_env/bin/activate
POPLAR_SDK_ROOT=/lambda_stor/software/graphcore/poplar_sdk/3.0.0
export POPLAR_SDK_ROOT=$POPLAR_SDK_ROOT
pip install $POPLAR_SDK_ROOT/poptorch-3.0.0+86945_163b7ce462_ubuntu_20_04-cp38-cp38-linux_x86_64.whl
#mkdir ~/tmp
export TF_POPLAR_FLAGS=--executable_cache_path=~/tmp
export POPTORCH_CACHE_DIR=~/tmp
export POPART_LOG_LEVEL=WARN
export POPLAR_LOG_LEVEL=WARN
export POPLIBS_LOG_LEVEL=WARN
export PYTHONPATH=/lambda_stor/software/graphcore/poplar_sdk/3.0.0/poplar-ubuntu_20_04-3.0.0+5691-1e179b3b85/python:$PYTHONPATH
cd ~/DL/github.com/BruceRayWilsonAtANL/Graphcore_examples/vision/cnns/pytorch
python -m pip install -r requirements.txt
