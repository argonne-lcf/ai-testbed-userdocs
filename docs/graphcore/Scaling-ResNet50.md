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
HOST1=`ifconfig ens2f0 | grep "inet " | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | head -1`
OCT123=`echo "$HOST1" | cut -d "." -f 1,2,3`
OCT4=`echo "$HOST1" | cut -d "." -f 4`
HOST2=$OCT123.`expr $OCT4 + 1`
HOST3=$OCT123.`expr $OCT4 + 2`
HOST4=$OCT123.`expr $OCT4 + 3`
export HOSTS=$HOST1,$HOST2,$HOST3,$HOST4
export CLUSTER=c16
export TCP_IF_INCLUDE=ens2f0
export VIPU_CLI_API_HOST=$HOST1
VIPU_SERVER=${VIPU_SERVER:=$HOST1}
FIRST_PARTITION=`vipu-admin list partitions --api-host $VIPU_SERVER| grep ACTIVE | cut -d '|' -f 3 | cut -d ' ' -f 2 | head -1`
PARTITON=${PARTITION:=$FIRST_PARTITION}
```

## One-time per user ssh key set up

Set up the ssh key on gc-poplar-01.

### Gc-poplar-01

On **gc-poplar-01**:

```bash
mkdir ~/.ssh
cd ~/.ssh
ssh-keygen -t rsa -b 4096
#Accecpt default filename of id_rsa
#Enter passphrase (empty for no passphrase):
#Enter same passphrase again:
cat id_rsa.pub >> authorized_keys
```

```bash
ssh-keyscan -H gc-poplar-01 >> ~/.ssh/known_hosts
```

You should see:

```console
# gc-poplar-01:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
# gc-poplar-01:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
# gc-poplar-01:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
# gc-poplar-01:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
# gc-poplar-01:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
```

```bash
ssh-keyscan -H gc-poplar-02 >> ~/.ssh/known_hosts
```

You should see:

```console
# gc-poplar-02:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
# gc-poplar-02:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
# gc-poplar-02:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
# gc-poplar-02:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
# gc-poplar-02:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
```

```bash
ssh-keyscan -H gc-poplar-03 >> ~/.ssh/known_hosts
```

You should see:

```console
# gc-poplar-03:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
# gc-poplar-03:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
# gc-poplar-03:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
# gc-poplar-03:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
# gc-poplar-03:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
```

```bash
ssh-keyscan -H gc-poplar-04 >> ~/.ssh/known_hosts
```

You should see:

```console
# gc-poplar-04:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
# gc-poplar-04:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
# gc-poplar-04:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
# gc-poplar-04:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
# gc-poplar-04:22 SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.5
```

## Benchmarks.yml

Update **${HOME}/graphcore/examples/vision/cnns/pytorch/train/benchmarks.yml**
with your favorite editor to match [benchmarks.yml](/docs/graphcore/benchmarks.yml).

## Configs.yml

Update **${HOME}/graphcore/examples/vision/cnns/pytorch/train/configs.yml**
with your favorite editor.  At about line 30, change **use_bbox_info: true** to
**use_bbox_info: false**.

## Scale ResNet50

Scale and benchmark **ResNet50**.

**Note:** The number at the end of each line indicates the number of IPUs.

**NOTE:** Use **screen** because every run is long.

"PopRun exposes this control with the --process-placement flag and provides multiple pre-defined strategies. By default (and with --process-placement spreadnuma), PopRun is designed to be NUMA-aware. On each host, all the available NUMA nodes are divided among the instances. This means that each instance is bound to execute on and allocate memory from its assigned NUMA nodes, ensuring memory access locality. This strategy maximises memory bandwidth and is likely to yield optimal performance for most of the data loading workloads in machine learning." [Multi-Instance Multi-Host(https://docs.graphcore.ai/projects/poprun-user-guide/en/latest/launching.html#multi-instance-multi-host)

```console
[INFO] 2022-12-16 18:54:52: Copying /nfs/AI_testbed/homes/wilsonb/graphcore/examples to 140.221.77.12:/nfs/AI_testbed/homes/wilsonb/graphcore/
[INFO] 2022-12-16 18:54:55: Copying /nfs/AI_testbed/software/graphcore/poplar_sdk to 140.221.77.12:/nfs/AI_testbed/software/graphcore/
[INFO] 2022-12-16 18:55:03: Copying /nfs/AI_testbed/homes/wilsonb/venvs to 140.221.77.12:/nfs/AI_testbed/homes/wilsonb/
```

```bash
cd train
# This starts.
python3 train.py --data imagenet --imagenet-data-path /software/datasets/imagenet

python3 -m examples_utils benchmark --spec benchmarks.yml --benchmark pytorch_resnet50_train_real_1
python3 -m examples_utils benchmark --spec benchmarks.yml --benchmark pytorch_resnet50_train_real_2
python3 -m examples_utils benchmark --spec benchmarks.yml --benchmark pytorch_resnet50_train_real_4
python3 -m examples_utils benchmark --spec benchmarks.yml --benchmark pytorch_resnet50_train_real_8
python3 -m examples_utils benchmark --spec benchmarks.yml --benchmark pytorch_resnet50_train_real_pod16
#export CLUSTER=p64
xpython3 -m examples_utils benchmark --spec benchmarks.yml --benchmark pytorch_resnet50_train_real_pod64_conv

export POPLAR_ENGINE_OPTIONS='{"opt.enableMultiAccessCopies":"false"}'
export CLUSTER=c16
export PYTORCH_CACHE_DIR="./pt_cache/"
poprun \
    -vv \
    --num-instances=32 \
    --num-replicas=64 \
    --vipu-server-host=$VIPU_CLI_API_HOST \
    --host=$HOSTS \
    --vipu-server-port 8090 \
    --vipu-partition=$PARTITION \
    --vipu-cluster=$CLUSTER \
    --update-partition=yes \
    --remove-partition=yes \
    --reset-partition=no \
    --sync-type=ST_POD_NATIVE_DEFAULT \
    --executable-cache-path=$PYTORCH_CACHE_DIR \
    --mpi-global-args=" \
        --mca oob_tcp_if_include $TCP_IF_INCLUDE \
        --mca btl_tcp_if_include $TCP_IF_INCLUDE" \
    --mpi-local-args=" \
    -x LD_LIBRARY_PATH \
    -x OPAL_PREFIX \
    -x PATH \
    -x CPATH \
    -x PYTHONPATH \
    -x POPLAR_ENGINE_OPTIONS \
    -x IPUOF_VIPU_API_TIMEOUT=800" \
python3 train.py \
    --config resnet50-pod64 \
    --dataloader-worker 14 \
    --dataloader-rebatch-size 256 \
    --imagenet-data-path $DATASETS_DIR/imagenet-raw-dataset \
    --validation-mode none

```

## Benchmark Results

### One IPU

```text
[INFO] 2022-12-16 17:07:32: Total runtime: 3956.836479 seconds
[INFO] 2022-12-16 17:07:32:    throughput = '7527.626315789474'
[INFO] 2022-12-16 17:07:32:    accuracy = '57.41'
[INFO] 2022-12-16 17:07:32:    loss = '2.8153'
[INFO] 2022-12-16 17:07:33:    Total compile time: 429.59 seconds
```

### Two IPUs

```text
[INFO] 2022-12-16 15:56:23: Total runtime: 5866.494071 seconds
[INFO] 2022-12-16 15:56:23:    throughput = '4798.778947368421'
[INFO] 2022-12-16 15:56:23:    accuracy = '68.23'
[INFO] 2022-12-16 15:56:23:    loss = '2.3148'
[INFO] 2022-12-16 15:56:24:    Total compile time: 418.75 seconds
```

### Four IPUs

```text
[INFO] 2022-12-16 04:05:28: Total runtime: 3070.994553 seconds
[INFO] 2022-12-16 04:05:28:    throughput = '9959.821052631578'
[INFO] 2022-12-16 04:05:28:    accuracy = '67.76'
[INFO] 2022-12-16 04:05:28:    loss = '2.338'
[INFO] 2022-12-16 04:05:29:    Total compile time: 377.4 seconds
```

### Eight IPUs

```text
[INFO] 2022-12-16 02:46:45: Total runtime: 1831.437598 seconds
[INFO] 2022-12-16 02:46:45:    throughput = '19865.263157894733'
[INFO] 2022-12-16 02:46:45:    accuracy = '64.94'
[INFO] 2022-12-16 02:46:45:    loss = '2.4649'
[INFO] 2022-12-16 02:46:46:    Total compile time: 386.27 seconds
```

### Sixteen IPUs

Epochs: 20

```text
[INFO] 2022-12-15 22:01:14: Total runtime: 1297.274336 seconds
[INFO] 2022-62:01:14:    throughput = '39057.447368421046'
[INFO] 2022-12-15 22:01:14:    accuracy = '57.43'
[INFO] 2022-12-15 22:01:14:    loss = '2.8162'
[INFO] 2022-12-15 22:01:16:    Total compile time: 397.08 seconds
```

### Sixty-Four IPUs

```text
[1,0]<stdout>:[INFO] loss: 4.8367,
[1,0]<stdout>:[INFO] accuracy: 18.83 %
[1,0]<stdout>:[INFO] throughput: 51368.5 samples/sec
```