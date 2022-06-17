# Tunneling and Forwarding Ports

Port forwarding is covered here.  This is specifically for TensorBoard.

## TensorBoard Port-Forwarding

This section describes the steps to be followed to set-up port forwarding for applications,
like TensorBoard, that run on this system and bind to one or more ports.
This example uses 6006 and 16006 as port numbers. Using port numbers other than these may
avoid collisions with other users.

### From your local machine

In the next command, there is **localhost:16006:localhost:16006**.
Think of this as **here:there**.  The first half is **here** on your local machine.
The second half is **there** on the remote machine.

Run
*replacing* ***CELSGCEUserID*** *with your CELS GCE User ID.*

```bash
ssh -N -f -L localhost:16006:localhost:16006 CELSGCEUserID@homes.cels.anl.gov
```

Now **ssh** to the login node:

```bash
ssh CELSGCEUserID@homes.cels.anl.gov
```

### From **homes.cels.anl.gov**

Forward **habana-01.ai.alcf.anl.gov:6006** to **homes.cels.anl.gov:16006**.

Run

```bash
ssh -N -f -L localhost:16006:localhost:6006 CELSGCEUserID@habana-01.ai.alcf.anl.gov
CELSGCEUserID@habana-01 password:
```

Now **ssh** to **habana-01**:

```bash
ssh CELSGCEUserID@habana-01.ai.alcf.anl.gov
CELSGCEUserID@habana-01.ai.alcf.anl.gov's password:
```

### On **habana-01**

Activate your virtual environment:

```bash
CELSGCEUserID@habana-01:~$ source ~/PT_venv/bin/activate
(PT_venv) CELSGCEUserID@habana-01:~$
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
tensorboard --logdir ./runs --port 6006
```

```bash
cd /path/to/your/project
tensorboard --logdir ./runs --port 6006
```

### Browser on Local Machine

Then, navigate in your browser to, in this example, [http://localhost:16006](http://localhost:16006) on your local machine.

## Notes

Explanation of **ssh** command:

```text
-N : no remote commands

-f : put ssh in the background

-L <machine1>:<portA>:<machine2>:<portB> :

The full command line will forward <machine1>:<portA> (local scope) to <machine2>:<portB> (remote scope)
```

Adapted from:  [How can I run Tensorboard on a remote server?](https://stackoverflow.com/questions/37987839/how-can-i-run-tensorboard-on-a-remote-server)
