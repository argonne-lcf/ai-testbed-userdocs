#! /bin/bash -x
#set -e
SECONDS=0
BS=32
IM=32
BS=256
IM=256
NUM_WORKERS=${2}
export OMP_NUM_THREADS=16

source /opt/sambaflow/venv/bin/activate
UNET=/opt/sambaflow/apps/image/pytorch/unet/unet.py
UNET=/opt/sambaflow/apps/image/unet

echo "Model: UNET_TRAIN"
echo "Date: " $(date +%m/%d/%y)
echo "Time: " $(date +%H:%M)

    export SAMBA_CCL_USE_PCIE_TRANSPORT=0
    #export SAMBA_CCL_PCIE_TRANSPORT=0
    #export SF_RNT_NUMA_BIND=2
    #export SF_RNT_FSM_POLL_BUSY_WAIT=1
    #export SF_RNT_DMA_POLL_BUSY_WAIT=1
    #export SF_RNT_LOG_LEVEL=DEBUG
    #/opt/mpich-3.4.3/bin/mpirun --verbose -hosts 192.168.200.130 -np ${1}  "python ${UNET}/unet_hook.py  run --num-workers=${NUM_WORKERS}  --do-train --in-channels=3 --in-width=${IM} --in-height=${IM} --init-features 32 --batch-size=${BS} --epochs 50  --data-dir /var/tmp/kaggle_3m  --log-dir log_dir_unet_${1}_train_kaggle --pef=$(pwd)/out/unet_train_${BS}_${IM}_NP/unet_train_${BS}_${IM}_NP.pef --data-parallel --reduce-on-rdu --use-sambaloader > run_unet_${BS}_${IM}_${1}.log 2>&1"
#export CCL_TIMEOUT=30
#export SF_RNT_TILE_AFFINITY=0xf0000000
#/opt/mpich-3.4.3/bin/mpirun --verbose -hosts=sm-01,sm-02 -np ${1}  /opt/sambaflow/venv/bin/python ${UNET}/unet_hook.py  run --num-workers=${NUM_WORKERS}  --do-train --in-channels=3 --in-width=${IM} --in-height=${IM} --init-features 32 --batch-size=${BS} --epochs 2   --data-dir /var/tmp/kaggle_3m  --log-dir log_dir_unet_${1}_train_kaggle --pef=$(pwd)/out/unet_train_${BS}_${IM}_NP/unet_train_${BS}_${IM}_NP.pef --data-parallel --reduce-on-rdu --use-sambaloader
#srun --mpi=pmi2 python ${UNET}/unet_hook.py  run --num-workers=${NUM_WORKERS}  --do-train --in-channels=3 --in-width=${IM} --in-height=${IM} --init-features 32 --batch-size=${BS} --epochs 2   --data-dir /var/tmp/kaggle_3m --log-dir log_dir_unet_${1}_train_kaggle --pef=$(pwd)/out/unet_train_${BS}_${IM}_NP/unet_train_${BS}_${IM}_NP.pef --data-parallel --reduce-on-rdu --use-sambaloader
srun --mpi=pmi2 python ${UNET}/unet_hook.py  run --do-train --in-channels=3 --in-width=${IM} --in-height=${IM} --init-features 32 --batch-size=${BS} --epochs 2   --data-dir /var/tmp/kaggle_3m --log-dir log_dir_unet_${1}_train_kaggle --pef=$(pwd)/out/unet_train_${BS}_${IM}_NP/unet_train_${BS}_${IM}_NP.pef --data-parallel --reduce-on-rdu --num-workers=${NUM_WORKERS}
echo "Duration: " $SECONDS
