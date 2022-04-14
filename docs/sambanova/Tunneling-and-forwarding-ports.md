# Tunneling and forwarding ports

You can port-forward with another ssh command that need not be tied to how you are connecting to the server (as an alternative to the other answer). Thus, the ordering of the below steps is arbitrary.

1. From your local machine, run
**ssh __ANL_Username__@sambanova.alcf.anl.gov**
and use your MobilePass + code for the password.

2. From **sambanova.alcf.anl.gov**, run
**ssh -N -f -L localhost:16006:localhost:6006 __ANL_Username__@sm-01.cels.anl.gov**

3. On **sm-01.cels.anl.gov**, run
**tensorboard --logdir /logs --port 6006**

4. From your local machine, run
**ssh -v -N -f -L localhost:16006:localhost:16006 -o PreferredAuthentications=password -o PubkeyAuthentication=no wilsonb@sambanova.alcf.anl.gov**

5. Then, navigate [in your browser] to (in this example) http://localhost:16006 on your local machine.

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
