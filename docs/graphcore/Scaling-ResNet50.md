# Scaling ResNet50

Follow all the instructions in [Getting Started](/docs/graphcore/Getting-Started) to log into a Graphcore node.

## Examples Repo

Graphcore provides examples of some well-known AI applications in their repository at https://github.com/graphcore/examples.git.

Clone the **examples** repository to your personal directory structure:

```bash
mkdir ~/graphcore
cd ~/graphcore
git clone https://github.com/graphcore/examples.git
```

## Environment Setup

Enable Poplar SDK and establish a virtual environment.

```bash
source /software/graphcore/poplar_sdk/3.0.0/enable
mkdir -p ~/venvs/graphcore
rm -rf ~/venvs/graphcore/poptorch30_rn50_env
virtualenv ~/venvs/graphcore/poptorch30_rn50_env
source ~/venvs/graphcore/poptorch30_rn50_env/bin/activate
```

## Install PopTorch

Install PopTorch.

```bash
POPLAR_SDK_ROOT=/software/graphcore/poplar_sdk/3.0.0
export POPLAR_SDK_ROOT=$POPLAR_SDK_ROOT
pip install $POPLAR_SDK_ROOT/poptorch-3.0.0+86945_163b7ce462_ubuntu_20_04-cp38-cp38-linux_x86_64.whl
```

## Environment Variables

Establish the following environment variables.

```bash
mkdir ${HOME}/tmp
export TF_POPLAR_FLAGS=--executable_cache_path=${HOME}/tmp
export POPTORCH_CACHE_DIR=${HOME}/tmp
export POPART_LOG_LEVEL=INFO
export POPLAR_LOG_LEVEL=INFO
export POPLIBS_LOG_LEVEL=INFO
export PYTHONPATH=/software/graphcore/poplar_sdk/3.0.0/poplar-ubuntu_20_04-3.0.0+5691-1e179b3b85/python:$PYTHONPATH
```

## Install Requirements

```bash
cd ${HOME}/graphcore/examples/vision/cnns/pytorch/
make install-turbojpeg
make install
make get-data
pip install -r requirements.txt
pip uninstall pillow -y
CC="cc -mavx2" pip install --no-cache-dir -U --force-reinstall pillow-simd
```

## Export Variables

Export the datasets directory and establish the environment variables for using multiple PODs.

```bash
export DATASETS_DIR=/mnt/localdata/datasets/
HOST1=`ifconfig eno1 | grep "inet " | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | head -1`
OCT123=`echo "$HOST1" | cut -d "." -f 1,2,3`
OCT4=`echo "$HOST1" | cut -d "." -f 4`
HOST2=$OCT123.`expr $OCT4 + 1`
HOST3=$OCT123.`expr $OCT4 + 2`
HOST4=$OCT123.`expr $OCT4 + 3`
export HOSTS=$HOST1,$HOST2,$HOST3,$HOST4
export CLUSTER=c16
VIPU_SERVER=${VIPU_SERVER:=$HOST1}
FIRST_PARTITION=`vipu-admin list partitions --api-host $VIPU_SERVER| grep ACTIVE | cut -d '|' -f 3 | cut -d ' ' -f 2 | head -1`
PARTITON=${PARTITION:=$FIRST_PARTITION}
```

## Scale ResNet50

Scale and benchmark **ResNet50**.

**Note:** The number at the end of each line indicates the number of IPUs.

**NOTE:** Use **screen** because every run is long.

```bash
cd train
# This starts.
python3 train.py --data imagenet --imagenet-data-path /software/datasets/imagenet

python3 -m examples_utils benchmark --spec benchmarks.yml --benchmark pytorch_resnet50_train_real_1
python3 -m examples_utils benchmark --spec benchmarks.yml --benchmark pytorch_resnet50_train_real_2
python3 -m examples_utils benchmark --spec benchmarks.yml --benchmark pytorch_resnet50_train_real_4
python3 -m examples_utils benchmark --spec benchmarks.yml --benchmark pytorch_resnet50_train_real_8
python3 -m examples_utils benchmark --spec benchmarks.yml --benchmark pytorch_resnet50_train_real_pod16
python3 -m examples_utils benchmark --spec benchmarks.yml --benchmark pytorch_resnet50_train_real_pod64
```

## Benchmark Results

### One IPU

```text
[INFO] 2022-12-03 23:41:11: Total runtime: 9633.622455 seconds
[INFO] 2022-12-03 23:41:11:    throughput = '3078.715789473684'
[INFO] 2022-12-03 23:41:11:    accuracy = '57.79'
[INFO] 2022-12-03 23:41:11:    loss = '2.7951'
[INFO] 2022-12-03 23:41:11:    Total compile time: 605.56 seconds
```

### Two IPUs

```text
[INFO] 2022-12-03 20:07:55: Total runtime: 17839.825218 seconds
[INFO] 2022-12-03 20:07:55:    throughput = '2119.7526315789473'
[INFO] 2022-12-03 20:07:55:    accuracy = '69.12'
[INFO] 2022-12-03 20:07:55:    loss = '2.2767'
[INFO] 2022-12-03 20:07:57:    Total compile time: 529.23 seconds
=```

### Four IPUs

```text
[INFO] 2022-12-03 06:44:14: Total runtime: 20047.298082 seconds
[INFO] 2022-12-03 06:44:14:    throughput = '3420.6052631578946'
[INFO] 2022-12-03 06:44:14:    accuracy = '68.49'
[INFO] 2022-12-03 06:44:14:    loss = '2.304'
[INFO] 2022-12-03 06:44:15:    Total compile time: ERROR
```

### Eight IPUs

```text
[INFO] 2022-12-03 00:59:25: Total runtime: 7649.385806 seconds
[INFO] 2022-12-03 00:59:25:    throughput = '3541.1105263157892'
[INFO] 2022-12-03 00:59:25:    accuracy = '65.78'
[INFO] 2022-12-03 00:59:25:    loss = '2.4248'
[INFO] 2022-12-03 00:59:26:    Total compile time: ERROR
```

### Sixteen IPUs

Epochs: 20

```text
[INFO] 2022-12-02 22:42:16: Total runtime: 9182.114773 seconds
[INFO] 2022-12-02 22:42:16:    throughput = '3261.3894736842108'
[INFO] 2022-12-02 22:42:16:    accuracy = '58.07'
[INFO] 2022-12-02 22:42:16:    loss = '2.7838'
[INFO] 2022-12-02 22:42:17:    Total compile time: ERROR
```

### Sixty-Four IPUs
