# Tunneling and forwarding ports

## TensorBoard Port-Forwarding

Use ports other than 6026 and 16026 to avoid collisions with other users.

From your local machine, run

```bash
ssh -v -N -f -L localhost:16026:localhost:16026 -o PreferredAuthentications=password -o PubkeyAuthentication=no wilsonb@sambanova.alcf.anl.gov
```

From your local machine, run

```bash
ssh wilsonb@sambanova.alcf.anl.gov
```

and use your MobilePass + code for the password.

From **sambanova.alcf.anl.gov**, run

```bash
ssh -N -f -L localhost:16026:localhost:6026 wilsonb@sm-01.cels.anl.gov
```

From **sambanova.alcf.anl.gov**, run

```bash
ssh wilsonb@sm-01.cels.anl.gov
```

On **sm-01.cels.anl.gov**, navigate to the appropriate directory for your model.

On **sm-01.cels.anl.gov**, execute

```bash
export PATH=$PATH:/opt/sambaflow/bin
export OMP_NUM_THREADS=1
source /opt/sambaflow/venv/bin/activate
```

On **sm-01.cels.anl.gov**, launch your model.

In another **sm-01.cels.anl.gov** terminal window

```bash
tensorboard --logdir /logs --port 6026
```

Then, navigate [in your browser] to (in this example) http://localhost:16026 on your local machine.

Explanation of ssh command:

```text
-N : no remote commands

-f : put ssh in the background

-L <machine1>:<portA>:<machine2>:<portB> :

forward <machine1>:<portA> (local scope) to <machine2>:<portB> (remote scope)
```

Adapted from:  https://stackoverflow.com/questions/37987839/how-can-i-run-tensorboard-on-a-remote-server

