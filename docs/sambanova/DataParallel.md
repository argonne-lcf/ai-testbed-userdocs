# DataParallel

## Login

Login by following the steps at [Getting Started](Logging-into-a-SambaNova-Node.md).

## Tutorial Files

ALCF provides a DataParallel tutorial at `/software/sambanova/apps/tutorials/sambanova_dataparallel`.  It is available from any Sambanova node.

Make a copy to your home directory:

```bash
cd ~/
cp -r /software/sambanova/apps/tutorials/sambanova_dataparallel .
```

## Change Directory

Change directory:

```bash
ALCFUserID@sm-01:~$ cd sambanova_dataparallel/
ALCFUserID@sm-01:~/sambanova_dataparallel$ 
```

## Sbatch

```bash
sbatch compile_dataparallel.sh
sbatch --gres=rdu:2 run_dataparallel.sh
```

The CLI argument **--gres=rdu:2** specifies that two copies
of the model are to be used for DataParallel.

You may view the ouput by running the following command:

```text
cat slurm-ddddd.out
```

where **ddddd** is your job id.
