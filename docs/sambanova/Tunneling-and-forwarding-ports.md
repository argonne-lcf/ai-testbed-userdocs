# Tunneling and Forwarding Ports

## On-Boarding

See [Get Started](https://www.alcf.anl.gov/support-center/get-started )
to request an acccount and additional information.

## TensorBoard Port-Forwarding

TODO Check these for redundancy.

This section describes the steps to be followed to set up port forwarding such that the applications like tensorboard, are run on the sambanova system.
This examples uses 6006 and 16006 as port numbers. Using unique port numbers other than these avoids collisions with other users. 

This section describes the steps to be followed to set up port forwarding such that the applications like tensorboard, are run on the sambanova system.
This examples uses 6006 and 16006 as port numbers. Using unique port numbers other than these avoids collisions with other users. 

### From your local machine

Run

```bash
ssh -v -N -f -L localhost:16006:localhost:16006 ALCFUserID@sambanova.alcf.anl.gov
...
Password: < MobilPass+ code >

ssh ALCFUserID@sambanova.alcf.anl.gov
...
Password: < MobilPass+ code >
```

### From **sambanova.alcf.anl.gov**

Run

**NOTE:  sm-01 is getting resolved by the DNS server.  The abbreviation is correct.
The full name is sm-01.ai.alcf.anl.gov.**

```bash
ssh -N -f -L localhost:16006:localhost:6006 ALCFUserID@sm-01
ssh ALCFUserID@sm-01
```

### On **sm-01**

Run the next three steps.

```bash
export PATH=$PATH:/opt/sambaflow/bin
export OMP_NUM_THREADS=1
source /opt/sambaflow/venv/bin/activate
```

Navigate to the appropriate directory for your model.
Launch your model using **srun** or **sbatch**.

```bash
cd /path/to/your/project
sbatch --output=pef/my_model/output.log submit-my_model-job.sh
```

### On Another sm-01 Terminal Window

The next three steps will be automatically ran in the future.

```bash
export PATH=$PATH:/opt/sambaflow/bin
export OMP_NUM_THREADS=1
source /opt/sambaflow/venv/bin/activate
```

Navigate to the appropriate directory for your model.

```bash
cd /path/to/your/project
tensorboard --logdir /logs --port 6006
```

### Browser on Local Machine

Then, navigate \[in your browser\] to (in this example) http://localhost:16006 on your local machine.

## Notes

Explanation of **ssh** command:

```text
-N : no remote commands

-f : put ssh in the background

-L <machine1>:<portA>:<machine2>:<portB> :

forward <machine1>:<portA> (local scope) to <machine2>:<portB> (remote scope)
```

Adapted from:  https://stackoverflow.com/questions/37987839/how-can-i-run-tensorboard-on-a-remote-server

