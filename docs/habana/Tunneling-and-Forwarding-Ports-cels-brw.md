# Tunneling and Forwarding Ports

Port forwarding is covered here.  This is specifically for TensorBoard.

## TensorBoard Port-Forwarding

This section describes the steps to be followed to set-up port forwarding for applications,
like TensorBoard, that run on this system and bind to one or more ports.
This example uses 6008 and 16008 as port numbers. Using port numbers other than these may
avoid collisions with other users.

### From your local machine

In the next command, there is **localhost:16008:localhost:16008**.
Think of this as **here:there**.  The first half is **here** on your local machine.
The second half is **there** on the remote machine.

Run
*replacing* ***ALCFUserID*** *with your ALCF User ID.*

```bash
ssh -N -f -L localhost:16008:localhost:16008 wilsonb@homes.cels.anl.gov
```

Now **ssh** to the login node:

```bash
ssh wilsonb@homes.cels.anl.gov
```

### From **homes.cels.anl.gov**

Forward **habana-01.ai.alcf.anl.gov:6008** to **homes.cels.anl.gov:16008**.

Run

```bash
ssh -N -f -L localhost:16008:localhost:6008 wilsonb@habana-01.ai.alcf.anl.gov
password
ssh wilsonb@habana-01.ai.alcf.anl.gov
```

Now **ssh** to habana-01:

```bash
ssh wilsonb@habana-01.ai.alcf.anl.gov
```

### On **habana-01**

Activate your virtual environment:

```bash
ALCFUserID@habana-01:~$ source ~/path/to/my_env/bin/activate
(my_env) ALCFUserID@habana-01:~$
```

Navigate to the appropriate directory for your model.
Run your model.

```bash
cd /path/to/your/project
python <your_model>
```

### On Another habana-01 Terminal Window

Navigate to the appropriate directory for your model:

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
