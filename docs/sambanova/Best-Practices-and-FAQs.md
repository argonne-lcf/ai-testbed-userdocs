# Miscellaneous


## SambaNova Daemon Service

The following command checks if SambaNova daemon service is running.

```bash
systemctl status snd
```

The output should look something like:

```text
* snd.service - SN Devices Service
   Loaded: loaded (/usr/lib/systemd/system/snd.service; enabled; vendor preset: enabled)
   Active: active (running) since Fri 2022-02-18 11:45:15 CST; 1 months 25 days ago
 Main PID: 3550 (snd)
    Tasks: 10 (limit: 19660)
   CGroup: /system.slice/snd.service
           `-3550 /opt/sambaflow/bin/snd

Warning: Journal has been rotated since unit was started. Log output is incomplete or unavailable.
```

## OMP_NUM_THREADS

The OMP_NUM_THREADS environment variable sets the number of threads to use for parallel regions.

The value of this environment variable must be a list of positive integer values. The values of the list set the number of threads to use for parallel regions at the corresponding nested levels.

For the SambaNova system it is usually set to one.

```bash
export OMP_NUM_THREADS=1
```

## Where is the Model?

Two copies of model are maintained.  One in CPU memory and one in RDU
memory. They do not interfere with each other unless you explicitly sync
the model/parameter in between using:

```text
SambaTensor.rdu() # Moves the CPU model to the RDU
SambaTensor.cpu() # Moves the RDU model to the CPU
```

In order to run the model on CPU, you can simply use the pytorch model
as if there is no RDU.
In order to run the model on RDU, you would need to use **session.run()**.

<!---
## Computing Loss on Host - to be removed. 

From Engineering:

"If we want to compute loss on the host, the first step is to run
forward section first on RDU, then compute a loss between an output
tensor and a label tensor, run loss backward on host to compute output’s
gradients afterwards, and finally run backward and optimizer sections on
RDU.  Look at
/opt/sambaflow/apps/image/pytorch/unet/estimators/estimatorcore.py on
sm-02."

1. Run forward section on RDU;

2. Compute a loss between an output tensor and a label tensor;

3. Run loss backward on host to compute output’s gradients; and

4. Run backward and optimizer sections on RDU.

## Slurm -- to be moved as part as Job queueing 

**NOTE:  Please be mindful of how you are using the system.
For example, run larger jobs in the evening or on weekends.**

### Srun

You may use **srun** to execute the Python interpreter with a script.

Example:

```bash
srun python lenet.py compile -b=1 --pef-name="lenet" --output-folder="pef"
```

### Sbatch

To use Slurm **sbatch**, create **submit-lenet-job.sh** with the following
contents:

```bash
#!/bin/sh

python lenet.py compile -b=1 --pef-name="lenet" --output-folder="pef"
```

Then

```bash
sbatch --output=pef/lenet/output.log submit-lenet-job.sh
```

### Squeue

Squeue will give you the queue status.

```bash
squeue
```

## MPI -- TODO -- this needs to be redone - may be part of data parallel page. 

1. How are MPI ranks mapped to RDU?

    - Ranks are assigned by MPI, but the mapping between ranks and RDU
    is created and maintained by the SambaCCL (Collective
    Communication Library).

2. What is the ordering of RDUs and replicas?

    - SambaFlow has no preferred ordering and which replicas go to
    which RDUs is ultimately decided by resource availability.

3. Does SambaFlow handle the mapping to RDUs, or is that handled by
    **mpirun**?

    - Yes, it is handled by SambaFlow, specifically by the SambaCCL.

4. How are ALL-GATHER and ALL-REDUCE actually carried out (e.g., what
    algorithms do we use)?

    - For both, we support ring and hierarchical algorithms.

## Select RDU and Node -- no use case for this

You can tell Slurm what node to use. To specify a tile you can set and
environment variable.
Use the 32-bit **SF\_RNT\_TILE\_AFFINITY** environment variable to hint
scheduler to choose the physical RDU/TILE, where your graph should be
running. Each nibble (4-bit set) maps to an RDU. In other words,

```text
Bit\[0-3\] maps to RDU0, Bit\[4-7\] maps to RDU1, and so on until
Bit\[31-28\] maps to RDU7. Each bit within the nibble is a Tile ID that
maps to a physical tile on the RDU, starting from LSB (0) to MSB (3).
RDU0= 0xf all of 0
RDU1= 0xf0 all of 1
RDU2= 0xf00 all of 2
RDU3= 0xf000 all of 3
RDU4= 0xf0000 all of 4
RDU5= 0xf00000 all of 5
RDU6= 0xf000000 all of 6
RDU7= 0xf0000000 all of 7
```


## FFTs -- to be removed - may be obsolete. 

Here is an update from SambaNova about the FFT.  They can already do
1dfft on **n** in array **[bs, n, m]** (bs: batch size). The maximum
**n x m** size is 256 x 256. Their next step is to make the array larger
than 256 and make it work for 2D.

Arthur, I tried replacing F.interpolate( with nn.ConvTranspose2d( in
smallUnet.py - it seems to work, with slightly smaller training and test
losses after 600 epochs. I'm emailing a patch file for you to look
at.

```text
(my_env) arnoldw@thetagpu05:/projects/datascience/arnoldw/SkX_NN$ cat smallUnet.py.patch 
--- smallUnet.py.baseline   2021-09-02 16:15:25.000000000 -0500
+++ smallUnet.py    2021-09-02 16:17:32.000000000 -0500
@@ -161,14 +161,24 @@
         self.conv = nn.Conv2d(
             input_channels, output_channels,
             kernel_size=1, stride=1, padding=0)
+        self.upsample2x = nn.ConvTranspose2d(
+            input_channels,
+            input_channels,
+            3,
+            stride=2,
+            padding=(1, 1),
+            output_padding=(1, 1))
     def forward(self, x):
         '''Defines a forward path'''
-        x = F.interpolate(
-            x, scale_factor=self.scale_factor, mode=self.mode)
+        # pdb.set_trace()
+        if (self.scale_factor == 2):
+            x  = self.upsample2x(x)
+        else:
+            x = F.interpolate(
+                x, scale_factor=self.scale_factor, mode=self.mode)
         return self.conv(x)
-
 def rng_seed(seed):
     torch.manual_seed(seed)
     np.random.seed(seed)```
```
--->
## How busy is the system?

Use one of

```bash
top
htop
```
<!---
## How to Use Inference Arg - TODO - this needs to be redone - we are not sure what changes with or without inference - should be done with a use case.

Bruce: just add --inference both to compile and run commands. See here: https://docs.sambanova.ai/sambanova-docs/1.8/developer/getting-started.html#_options

Examples: https://docs.sambanova.ai/sambanova-docs/1.8/developer/run-examples-language.html -Rick W
9/8/2021
It sounds like --inference is supposed to work with every CLI command.

So, compile --inference and measure-performance --inference work.
Also, run --inference works.

## Data Parallel -- This should be part of Dataparallel page anyway

If the code is correct(distributed loader) the compile looks like:

```bash
python unet_main.py compile --batch-size=48 --data-parallel -ws 2 --pef-name=dillon_2k_b48_dp
```

The run command looks like:

```bash
python unet_main.py run -p ${SOFTWARE_HOME}/out/dillon_2k_b48_dp/dillon_2k_b48_dp.pef --data-parallel --reduce-on-rdu
```

You put the run command in a script and use **mpirun** to run the script.

Look at /var/tmp/Additional/slurm/Models/ANL_Acceptance_RC1_8_1/bert_lrg_8.sh
--->

## Tile status

```bash
sntilestat
watch sntilestat
```
<!---
## What are Spatial Batches ?

--spatial_train argument is used for training in "spatial mapping mode" for applications like Uno, where the loss is calculated across the entire spatial batch size. This mode aggregates many minibatches of training inputs (aka samples) and performs multiple iterations of fwd->bwd->param_update in one single execution context. Here a minibatch really means a batch, i.e. how many samples of data you need to perform fwd->bwd to calculate weight gradients and make a weight update. This means in a single execution context, the number weight-updates happened is equal to the number of minibatches inputs provided, and that is what minibatch_count is referring to. In the Uno specific config, minibatch_count=2000 per each execution context, and minibatch_size=16. In 1 epoch, it performs 1 execution context -> train with 2000 batches or 2000 * 16 samples. Why is it done this way? In “spatial mapping”, we do not fetch/dump the (updated)parameters from/to the off-chip memory or host, therefore saving the overhead of memory load/store and host<->device transfers, which significantly helps the performance/throughput.
--->

## Finding Hung Tiles

```bash
snconfig show Node dynamic | grep perfect
```
