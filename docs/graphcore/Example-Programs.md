# Example Programs

For a Graphcore PyTorch tutorial see https://github.com/graphcore/tutorials/blob/master/tutorials/pytorch/basics/README.md.

Graphcore provides examples of some well-known AI applications in their repository at https://github.com/graphcore/examples.git.

Clone the **examples** repository to your personal directory structure:

```bash
mkdir ~/graphcore
cd ~/graphcore
git clone https://github.com/graphcore/examples.git
```

## ResNet50

### Install Requirements

Change directory

```bash
cd ~/graphcore/examples/vision/cnns/pytorch
python -m pip install -r requirements.txt
python -m pip install PyTurboJPEG
```

### Update configs.yml

If necessary change directory:

```bash
cd ~/graphcore/examples/vision/cnns/pytorch/train
```

Open **configs.yml** with your favorite editor.

Find:

```yaml
use_bbox_info: true

epoch: 100
```

and change it to:

```yaml
use_bbox_info: false

epoch: 20
```

### POD16

#### Update rn50_pod16.sh

Change directory

```bash
cd ~/graphcore/examples/vision/cnns/pytorch/train
```

Open **rn50_pod16.sh** with your favorite editor.

On the last line (it starts with **poprun**), replace

```python
--config resnet50
```

with

```python
--config resnet50 --imagenet-data-path /software/datasets/imagenet
```

The ImageNet data path is now defined.

#### Run rn50_pod16.sh

```bash
./rn50_pod16.sh
```

The output will look something like:

```console





```

### POD64

Change directory

```bash
cd ~/graphcore/examples/vision/cnns/pytorch
python -m pip install -r requirements.txt
```

#### Update rn50_pod64.sh

Change directory

```bash
cd ~/graphcore/examples/vision/cnns/pytorch/train
```

Open **rn50_pod16.sh** with your favorite editor.

On the last line (it starts with **poprun**), replace

```python
--config resnet50
```

with

```python
--config resnet50 --imagenet-data-path /software/datasets/imagenet
```

The ImageNet data path is now defined.

#### Run rn50_pod64.sh

```bash
./rn50_pod64.sh
```

The output will look something like:

```console





```
