# Tunneling and forwarding ports

## TensorBoard Port-Forwarding

Use ports other than 6006 and 16006 to avoid collisions with other users.

4. From your local machine, run
**ssh -v -N -f -L localhost:16006:localhost:16006 -o PreferredAuthentications=password -o PubkeyAuthentication=no wilsonb@sambanova.alcf.anl.gov**

1. From your local machine, run
**ssh __ANL_Username__@sambanova.alcf.anl.gov**
and use your MobilePass + code for the password.

2. From **sambanova.alcf.anl.gov**, run
**ssh -N -f -L localhost:16006:localhost:6006 __ANL_Username__@sm-01.cels.anl.gov**

2. From **sambanova.alcf.anl.gov**, run
**ssh __ANL_Username__@sm-01.cels.anl.gov**

3. On **sm-01.cels.anl.gov**, navigate to the appropriate directory for your model.

3. On **sm-01.cels.anl.gov**, execute **snp**.

3. On **sm-01.cels.anl.gov**, launch your model.

3. In another **sm-01.cels.anl.gov** terminal window
**tensorboard --logdir /logs --port 6016**

5. Then, navigate [in your browser] to (in this example) http://localhost:16016 on your local machine.

(explanation of ssh command:

-N : no remote commands

-f : put ssh in the background

-L <machine1>:<portA>:<machine2>:<portB> :

forward <machine1>:<portA> (local scope) to <machine2>:<portB> (remote scope)

Adapted from:  https://stackoverflow.com/questions/37987839/how-can-i-run-tensorboard-on-a-remote-server

## Stop here
The folloowing are notes.

ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no wilsonb@sambanova.alcf.anl.gov

ssh -v -N -f -L localhost:16006:localhost:16006 -o PreferredAuthentications=password -o PubkeyAuthentication=no wilsonb@sambanova.alcf.anl.gov
