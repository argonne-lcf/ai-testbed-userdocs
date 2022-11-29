#! /bin/bash -x
#set -e
#
# Usage: ./bw_unet_test1.sh 256 256
#
SECONDS=0

# IMage size.
IM=${1}
# Batch Size
BS=${2}
NUM_WORKERS=1
export OMP_NUM_THREADS=16

source /opt/sambaflow/venv/bin/activate
UNET=$(pwd)/unet

echo "Model: UNET"
echo "Date: " $(date +%m/%d/%y)
echo "Time: " $(date +%H:%M)

echo "COMPILE"
# Compile for parallel RDUs
rm out/unet_train_${BS}_${IM}_NN/unet_train_${BS}_${IM}_NN.pef
if [ ! -e out/unet_train_${BS}_${IM}_NN/unet_train_${BS}_${IM}_NN.pef ] ; then
  python ${UNET}/unet.py compile -b ${BS} --in-channels=3 --in-width=${IM} --in-height=${IM} --enable-conv-tiling --mac-v2 --compiler-configs-file ${UNET}/jsons/compiler_configs/unet_compiler_configs_no_inst.json --pef-name="unet_train_${BS}_${IM}_NN"  --data-parallel -ws 2 > compile_${BS}_${IM}_NN.log 2>&1
fi



#python /home/wilsonb/apps/image/unet/unet.py compile -b 256 --in-channels=3 --in-width=256 --in-height=256 --enable-conv-tiling --mac-v2 --compiler-configs-file /home/wilsonb/apps/image/unet/jsons/compiler_configs/unet_compiler_configs_no_inst.json --pef-name=unet_train_256_256_NN --data-parallel -ws 2
#srun --mpi=pmi2 python /home/wilsonb/apps/image/unet/unet_hook.py run --do-train --in-channels=3 --in-width=256 --in-height=256 --init-features 32 --batch-size=256 --epochs 2 --data-dir /software/sambanova/dataset/kaggle_3m --log-dir log_dir_unet_2_train_kaggle --pef=/home/wilsonb/apps/image/out/unet_train_256_256_NN/unet_train_256_256_NN.pef --data-parallel --reduce-on-rdu --num-workers=1

#
#bruce+ python /home/wilsonb/apps/image/unet/unet.py compile -b 256 --in-channels=3 --in-width=256 --in-height=256 --enable-conv-tiling --mac-v2 --compiler-configs-file /home/wilsonb/apps/image/unet/jsons/compiler_configs/unet_compiler_configs_no_inst.json --pef-name=unet_train_256_256_NN --data-parallel -ws 2
#rickw+ python /home/wilsonb/apps/image/unet/unet.py compile -b 256 --in-channels=3 --in-width=256 --in-height=256 --enable-conv-tiling --mac-v2 --compiler-configs-file /home/wilsonb/apps/image/unet/jsons/compiler_configs/unet_compiler_configs_no_inst.json --pef-name=unet_train_256_256_NP --data-parallel -ws 2

#bruce+ srun --mpi=pmi2 python /home/wilsonb/apps/image/unet/unet_hook.py run --do-train --in-channels=3 --in-width=256 --in-height=256 --init-features 32 --batch-size=256 --epochs 2 --data-dir /software/sambanova/dataset/kaggle_3m --log-dir log_dir_unet_2_train_kaggle --pef=/home/wilsonb/apps/image/out/unet_train_256_256_NN/unet_train_256_256_NN.pef --data-parallel --reduce-on-rdu --num-workers=1
#rickw+ srun --mpi=pmi2 python /opt/sambaflow/apps/image/unet/unet_hook.py run --do-train --in-channels=3 --in-width=256 --in-height=256 --init-features 32 --batch-size=256 --epochs 2 --data-dir /var/tmp/kaggle_3m --log-dir log_dir_unet_2_train_kaggle --pef=/home/wilsonb/apps/image/out/unet_train_256_256_NP/unet_train_256_256_NP.pef --data-parallel --reduce-on-rdu --num-workers=1

# Single
#+ python /home/wilsonb/apps/image/unet/unet.py compile --log-level error -b 256 --in-channels=3 --in-width=256 --in-height=256 --enable-conv-tiling --mac-v2 --compiler-configs-file /home/wilsonb/apps/image/unet/jsons/compiler_configs/unet_compiler_configs_no_inst.json --pef-name=unet_train_256_256_single


#run

#single
#run single
#srun --cpus-per-task=16 --gres=rdu:1 python ${UNET}/unet_hook.py  run --num-workers=${NUM_WORKERS} --do-train --in-channels=3 --in-width=${IM} --in-height=${IM} --init-features 32 --batch-size=${BS} --epochs 10  --data-dir /usr/local/share/data/unet32 --log-dir log_dir_unet_train_kaggle --pef=$(pwd)/out/unet_train_${BS}_${IM}_single/unet_train_${BS}_${IM}_single.pef --use-sambaloader > run_unet_${BS}_${IM}_single.log 2>&1

#Parallel
NN=2
echo "RUN"
echo "NN=${NN}"
sbatch --gres=rdu:1 --tasks-per-node 8  --nodes 2 --nodelist sm-02,sm-01 --cpus-per-task=16 ./unet_batch.sh ${NN} ${NUM_WORKERS}
echo "Duration: " $SECONDS

