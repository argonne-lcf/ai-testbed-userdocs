# Tunneling and forwarding ports

## TensorBoard Port-Forwarding

Use ports other than 6026 and 16026 to avoid collisions with other users.

### From your local machine

Run

```bash
ssh -v -N -f -L localhost:16026:localhost:16026 wilsonb@sambanova.alcf.anl.gov
...
Password: < MobilPass+ code >

ssh wilsonb@sambanova.alcf.anl.gov
...
Password: < MobilPass+ code >
```

### From **sambanova.alcf.anl.gov**

Run

```bash
Now
ssh -N -f -L localhost:16026:localhost:6026 wilsonb@sm-01.cels.anl.gov
ssh wilsonb@sm-01.cels.anl.gov

Future
ssh -N -f -L localhost:16026:localhost:6026 wilsonb@sm-01.alcf.anl.gov
ssh wilsonb@sm-01.alcf.anl.gov
```

### On **sm-01.alcf.anl.gov**

The next three steps will be automatically ran in the future.

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

### On Another sm-01.alcf.anl.gov Terminal Window

The next three steps will be automatically ran in the future.

```bash
export PATH=$PATH:/opt/sambaflow/bin
export OMP_NUM_THREADS=1
source /opt/sambaflow/venv/bin/activate
```

Navigate to the appropriate directory for your model.

```bash
cd /path/to/your/project
tensorboard --logdir /logs --port 6026
```

### Browser on Local Machine

Then, navigate [in your browser] to (in this example) http://localhost:16026 on your local machine.

## Notes

Explanation of **ssh** command:

```text
-N : no remote commands

-f : put ssh in the background

-L <machine1>:<portA>:<machine2>:<portB> :

forward <machine1>:<portA> (local scope) to <machine2>:<portB> (remote scope)
```

Adapted from:  https://stackoverflow.com/questions/37987839/how-can-i-run-tensorboard-on-a-remote-server

