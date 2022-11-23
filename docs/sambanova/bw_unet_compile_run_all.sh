#! /bin/bash -x
#set -e
SECONDS=0
ARG2=256
ARG3=256
BS=${ARG3}
NUM_WORKERS=1
export OMP_NUM_THREADS=16

source /opt/sambaflow/venv/bin/activate
UNET=/opt/sambaflow/apps/image/pytorch/unet/unet.py
UNET=/opt/sambaflow/apps/image/unet
UNET=$(pwd)/unet


echo "Model: UNET_TRAIN"
echo "Date: " $(date +%m/%d/%y)
echo "Time: " $(date +%H:%M)

echo "COMPILE"
# Compile single RDU

i=single
if [ ! -e out/unet_train_${BS}_${2}_${i}/unet_train_${BS}_${2}_${i}.pef ] ; then
  python ${UNET}/unet.py compile --log-level error -b ${BS} --in-channels=3 --in-width=${2} --in-height=${2} --enable-conv-tiling --mac-v2 --compiler-configs-file ${UNET}/jsons/compiler_configs/unet_compiler_configs_no_inst.json --pef-name="unet_train_${BS}_${2}_${i}" > compile_${BS}_${2}_${i}.log 2>&1
fi

# Compile parallel
if [ ! -e out/unet_train_${BS}_${ARG2}_NP/unet_train_${BS}_${ARG2}_NP.pef ] ; then
  python ${UNET}/unet.py compile -b ${BS} --in-channels=3 --in-width=${ARG2} --in-height=${ARG2} --enable-conv-tiling --mac-v2 --compiler-configs-file ${UNET}/jsons/compiler_configs/unet_compiler_configs_no_inst.json --pef-name="unet_train_${BS}_${ARG2}_NP"  --data-parallel -ws 2 > compile_${BS}_${ARG2}_NP.log 2>&1
fi


#run loop
#single
for BS in ${ARG3}
do
  export OMP_NUM_THREADS=16
  #run single
  #srun --cpus-per-task=16 --gres=rdu:1 python ${UNET}/unet_hook.py  run --num-workers=${NUM_WORKERS} --do-train --in-channels=3 --in-width=${ARG2} --in-height=${ARG2} --init-features 32 --batch-size=${BS} --epochs 10  --data-dir /usr/local/share/data/unet32 --log-dir log_dir_unet_train_kaggle --pef=$(pwd)/out/unet_train_${BS}_${ARG2}_single/unet_train_${BS}_${ARG2}_single.pef --use-sambaloader > run_unet_${BS}_${ARG2}_single.log 2>&1
  #Parallel
  for NP in 2
  do
    echo "RUN"
    echo "NP=${NP}"
    #rm -rf log_dir*
    #export SAMBA_CCL_USE_PCIE_TRANSPORT=1
    #export SF_RNT_NUMA_BIND=2
    #export SF_RNT_FSM_POLL_BUSY_WAIT=1
    #export SF_RNT_DMA_POLL_BUSY_WAIT=1
    #sbatch --cpus-per-task=4 --gres=rdu:${NP} /opt/mpich-3.4.3/bin/mpirun -hosts=192.168.200.131,192.168.200.130  -np ${NP}  python ${UNET}/unet_hook.py  run --num-workers=${NUM_WORKERS} --do-train --in-channels=3 --in-width=${ARG2} --in-height=${ARG2} --init-features 32 --batch-size=${BS} --epochs 10  --data-dir /var/tmp/kaggle_3m  --log-dir log_dir_unet_${NP}_train_kaggle --pef=$(pwd)/out/unet_train_${BS}_${ARG2}_NP/unet_train_${BS}_${ARG2}_NP.pef --data-parallel --reduce-on-rdu --use-sambaloader > run_unet_${BS}_${ARG2}_${NP}.log 2>&1
    #sbatch --cpus-per-task=16 --gres=rdu:1 --ntasks-per-node 1  --nodes 2 --mpi=pmi2 --CPU-per-job 16 ./unet_batch.sh ${NP} ${NUM_WORKERS}
    #sbatch -n 2 --gres=rdu:1 --tasks-per-node 1  --nodes 2 --cpus-per-task=16 ./unet_batch.sh ${NP} ${NUM_WORKERS}
    sbatch --gres=rdu:1 --tasks-per-node 8  --nodes 2 --nodelist sm-02,sm-01 --cpus-per-task=16 ./unet_batch.sh ${NP} ${NUM_WORKERS}
  done
done
echo "Duration: " $SECONDS

