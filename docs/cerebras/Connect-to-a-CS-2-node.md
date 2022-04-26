# Connecting to a CS-2 node

<!---These instructions presume that you have completed steps 1 and 2 on ALCFs
<a href="https://www.alcf.anl.gov/support-center/get-started">Get Started - Follow these steps to get your research project up and running on ALCF computing resources</a>--->

![CS-2 connection diagram](./Cerebras-connectivity-diagram.png)
Connection to a CS-2 node is a two step process. <br>
The first step requires a MFA passcode for authentication - either a 8 digit passcode generted by an app on your mobile device (e.g. mobilePASS+) or a CRYPTOCard-generated passcode prefixed by a 4 digit pin. This is the same passcode used to authenticate into other ALCF systems, such as Theta and Cooley. <br>
*In the examples below, <strong>replace ALCFUserID with your ALCF user id.</strong>*<br>
<!---[TODO the need for the second authentication step may be eliminated soon.]<br>--->
<!---[TODO testbed-cs2-01-med8.ai.alcf.anl.gov is not currently accessible]<br>--->
To connect to a CS-2 ("chief") node:<br>

(1) From the local machine, ssh to the login node first: 
```bash
ssh ALCFUserID@cerebras.alcf.anl.gov
```

(2) From the login node, ssh to the destination CS-2 chief node:
```bash
ssh cs2-02-med8
```

Alternatively, this maybe done in one command line from the local machine. (two passcodes required):
```bash
ssh -o "ProxyJump ALCFUserID@cerebras.alcf.anl.gov" ALCFUserID@cs2-02-med8
```

Verify that the connection was successful with
```bash
uname -a
```
and by making sure the output message contains says `testbed-cs2-02-med8` and <strong>not</strong> `cs-login`.

## Setup the environment
After sshing to the CS-02 chief node,
```bash
source /software/cerebras/cs2-02/envs/cs_env.sh
```
This will add some CS2 scripts to the path, and set the CS_IP environment variable. 




