# Graphcore

## Connecting to CELS

You will first need to log in to one of the CELS machines.  Enter:

```bash
ssh ___Argonne_CELS_username___@homes.cels.anl.gov
```

## Connecting to Graphcore

```bash
ssh graphcore.cels.anl.gov
```

Enter your ANL password.

## Environment Setup

```bash
cd ~
tar -xvf /lambda_stor/homes/vvishwanath/poplar_sdk-ubuntu_18_04-2.3.0-b47c577c2a.tar
source poplar_sdk-ubuntu_18_04-2.3.0+774-b47c577c2a/poplar-ubuntu_18_04-2.3.0+1367-88f485e763/enable.sh
source poplar_sdk-ubuntu_18_04-2.3.0+774-b47c577c2a/popart-ubuntu_18_04-2.3.0+1367-88f485e763/enable.sh
```

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

```bash
virtualenv -p python3 ~/workspace/poptorch_env
source ~/workspace/poptorch_env/bin/activate
pip3 install -U pip
```

## TensorFlow 1 Environment Setup

```bash
virtualenv -p python3.6 ~/workspace/tensorflow1_env
source workspace/tensorflow1_env/bin/activate
pip3 install -U pip

pip install poplar_sdk-ubuntu_18_04-2.3.0+774-b47c577c2a/tensorflow-1.15.5+gc2.3.0+106904+affd28f7e2c+intel_skylake512-cp36-cp36m-linux_x86_64.whl
```

### Verify Installation

```bash
pip list | grep tensor
```

You should see:

```bash
tensorboard          1.15.0
tensorflow           1.15.5
tensorflow-estimator 1.15.1
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

## Clone and Run

```bash
git clone git@git.cels.anl.gov:ai-testbed-apps/graphore/mnistcnn.git
cd mnistcnn
python cnn.py
python Graphcore.py
```
