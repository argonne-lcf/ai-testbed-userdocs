# Job Queueing and Submission

Here are example commands for using Slurm.

**NOTE:  If you receive an "HTTP error" message on any of the
following commands, run the command again. Such errors (e.g. 503) are
commonly an intermittent failure to download a dataset.**

Run these commands:

```bash
srun python lenet.py compile -b=1 --pef-name="lenet" --output-folder="pef"
srun python lenet.py test --pef="pef/lenet/lenet.pef"
srun python lenet.py run --pef="pef/lenet/lenet.pef"
srun python lenet.py measure-performance --pef="pef/lenet/lenet.pef"
```

To use Slurm sbatch, create submit-lenet-job.sh with the following
contents:

```bash
#!/bin/sh

python lenet.py compile -b=1 --pef-name="lenet" --output-folder="pef"
python lenet.py test --pef="pef/lenet/lenet.pef"
python lenet.py run --pef="pef/lenet/lenet.pef"
python lenet.py measure-performance --pef="pef/lenet/lenet.pef"
```

Then

```bash
sbatch --output=pef/lenet/output.log submit-lenet-job.sh
```

Squeue will give you the queue status.

```bash
squeue
```

The output file, pef/lenet/output.log, will look something like:

```text
[Info][SAMBA][Default] # Placing log files in
pef/lenet/lenet.samba.log

[Info][MAC][Default] # Placing log files in
pef/lenet/lenet.mac.log

[Warning][SAMBA][Default] #

--------------------------------------------------

Using patched version of torch.cat and torch.stack

--------------------------------------------------

[Warning][SAMBA][Default] # The dtype of "targets" to
CrossEntropyLoss is torch.int64, however only int16 is currently
supported, implicit conversion will happen

[Warning][MAC][GraphLoweringPass] # lenet__reshape skip
set_loop_to_air

[Warning][MAC][GraphLoweringPass] # lenet__reshape_bwd skip
set_loop_to_air

...

Epoch [1/1], Step [59994/60000], Loss: 0.1712

Epoch [1/1], Step [59995/60000], Loss: 0.1712

Epoch [1/1], Step [59996/60000], Loss: 0.1712

Epoch [1/1], Step [59997/60000], Loss: 0.1712

Epoch [1/1], Step [59998/60000], Loss: 0.1712

Epoch [1/1], Step [59999/60000], Loss: 0.1712

Epoch [1/1], Step [60000/60000], Loss: 0.1712

Test Accuracy: 98.06 Loss: 0.0628

2021-6-10 10:52:28 : [INFO][SC][53607]: SambaConnector: PEF File:
pef/lenet/lenet.pef

Log ID initialized to: [wilsonb][python][53607] at
/var/log/sambaflow/runtime/sn.log
```

Please note that there is no measure-performance command handled
currently in lenet.py and some of the other files in the pytorch starter
code. Hence if you run measure-performance on lenet.py, it will not
display anything. One way to run performance measure for lenet is, add
the following in the main function:

```text
elif args.command == "measure-performance":
        common_app_driver(args, model, inputs, optimizer, name='ffn_mnist_torch', app_dir=utils.get_file_dir(__file__))
```
