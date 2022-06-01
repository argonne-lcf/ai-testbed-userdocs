# Tunneling and Forwarding Ports

Port forwarding is covered here.  This is specifically for TensorBoard.

## TensorBoard Port-Forwarding

This section describes the steps to be followed to set up port forwarding for applications,
like TensorBoard, that run on this system and bind to one or more ports.
This example uses 6008 and 16008 as port numbers. Using port numbers other than these may
avoid collisions with other users.

### From your local machine

Run

```bash
ssh -v -N -f -L localhost:16008:localhost:16008 wilsonb@homes.cels.anl.gov
```

```text
ssh wilsonb@homes.cels.anl.gov

...
Password: < MobilPass+ code >
```

*replacing* ***ALCFUserID*** *with your ALCF User ID.*

### From **homes.cels.anl.gov**

Run

**NOTE:  The full name is xxxsm-01.ai.alcf.anl.gov and it may also be used.**

```bash
ssh -N -f -L localhost:16008:localhost:6008 wilsonb@habana-01.ai.alcf.anl.gov
password
ssh wilsonb@habana-01.ai.alcf.anl.gov
```

### On **sm-01**

Execute the following command:

```bash
ALCFUserID@sm-01:~$ source /software/sambanova/envs/sn_env.sh
(venv) ALCFUserID@sm-01:~$
```

Navigate to the appropriate directory for your model.
Launch your model using **srun** or **sbatch**.

```bash
cd /path/to/your/project
sbatch --output=pef/my_model/output.log submit-my_model-job.sh
```

### On Another sm-01 Terminal Window

The 

Navigate to the appropriate directory for your model.

```console
cd ~/DL/ai-testbed-tutorials/habana/habana_starter
tensorboard --logdir ./runs --port 6008
```

```bash
cd /path/to/your/project
tensorboard --logdir ./runs --port 6008
```

### Browser on Local Machine

Then, navigate in your browser to, in this example, [http://localhost:16008](http://localhost:16008) on your local machine.

## Notes

Explanation of **ssh** command:

```text
-N : no remote commands

-f : put ssh in the background

-L <machine1>:<portA>:<machine2>:<portB> :

The full command line will forward <machine1>:<portA> (local scope) to <machine2>:<portB> (remote scope)
```

Adapted from:  [How can I run Tensorboard on a remote server?](https://stackoverflow.com/questions/37987839/how-can-i-run-tensorboard-on-a-remote-server)
