# Example Multi-Node Programs

SambaNova provides examples of some well-known AI applications under the path: `/opt/sambaflow/apps/starters`, on both SambaNova compute nodes. Make a copy of this to your home directory:

Copy starters to your personal directory structure if you have not already done so.

```bash
cd ~/
mkdir apps
cp -r /opt/sambaflow/apps/starters apps/starters
```

## UNet

Change directory and copy files if you have not already done so.

```bash
cp -r /opt/sambaflow/apps/image ~/apps/image
cd ~/apps/image/unet
cp /software/sambanova/apps/image/pytorch/unet/*.sh .
```

Export the path to the dataset which is required for the training.

```bash
export OUTDIR=~/apps/image/unet
export DATADIR=/software/sambanova/dataset/kaggle_3m
```

Then

```bash
cd ~/apps/image/
cp /home/rweisner/tmp/unet/unet_compile_run_all.sh .
cp /home/rweisner/tmp/unet/*.sh .
```

Open the copy of 'unet_compile_run_all.sh' with your favorite editor.

Change '--tasks-per-node 1' to '--tasks-per-node 8' on the fourth to the last line.

Run

```bash
./bw_unet_compile_run_all.sh dummy 256 256
./unet_compile_run_all.sh dummy 256 256
```

Squeue will give you the queue status.

```bash
squeue
```
