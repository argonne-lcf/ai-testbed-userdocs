# Tunneling and Forwarding Ports

## TensorBoard Port-Forwarding

Use ports other than 6026 and 16026 to avoid collisions with other users.

### From your local machine

Run

### TODO Add link to ALCF Onboarding

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

**NOTE:  sm-01 is getting resolved by the DNS server.  The abbreviation is correct.
The full name is sm-01.ai.alcf.anl.gov.**

```bash
ssh -N -f -L localhost:16026:localhost:6026 wilsonb@sm-01
ssh wilsonb@sm-01
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

