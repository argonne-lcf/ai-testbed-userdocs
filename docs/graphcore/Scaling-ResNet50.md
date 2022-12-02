# Scaling ResNet50

Follow all the instructions in [Getting Started](/docs/graphcore/Getting-Started) to log into a Graphcore node.

Follow the instructructions in [Virtual Environments](/docs/graphcore/Virtual-Environments) up to and including **PopART Environment Setup**.

## Examples Repo

Graphcore provides examples of some well-known AI applications in their repository at https://github.com/graphcore/examples.git.

Clone the **examples** repository to your personal directory structure:

```bash
mkdir ~/graphcore
cd ~/graphcore
git clone https://github.com/graphcore/examples.git
```

## Install Requirements

Change directory

```bash
cd ~/graphcore/examples/vision/cnns/pytorch
python -m pip install -r requirements.txt
```

## Export Variables

Export the datasets directory.

```bash
export DATASETS_DIR=/software/datasets
```

## Scale ResNet50

Scale and benchmark **ResNet50**.

**Note:** The number at the end of each line indicates the number of IPUs.

**NOTE:** Use **screen** because every run is long.

```bash
# This starts.
python3 train.py --data imagenet --imagenet-data-path /software/datasets/imagenet

python3 -m examples_utils benchmark --spec benchmarks.yml --benchmark pytorch_resnet50_train_real_1
python3 -m examples_utils benchmark --spec benchmarks.yml --benchmark pytorch_resnet50_train_real_2
python3 -m examples_utils benchmark --spec benchmarks.yml --benchmark pytorch_resnet50_train_real_4
python3 -m examples_utils benchmark --spec benchmarks.yml --benchmark pytorch_resnet50_train_real_8
python3 -m examples_utils benchmark --spec benchmarks.yml --benchmark pytorch_resnet50_train_real_pod16
```

## Benchmark Results

### One IPU

### Two IPUs

### Four IPUs

### Eight IPUs

### Sixteen IPUs

```text
[INFO] 2022-12-02 18:05:37: Total runtime: 1234.468414 seconds
[INFO] 2022-12-02 18:05:37:    throughput = '3995.6'
[INFO] 2022-12-02 18:05:37:    accuracy = '2.5'
[INFO] 2022-12-02 18:05:37:    loss = '6.2602'
[INFO] 2022-12-02 18:05:37:    Total compile time: ERROR
```

### Thirty-Two IPUs
