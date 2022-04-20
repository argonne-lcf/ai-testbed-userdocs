### Connect to a CS-2 node

These instructions presume that you have completed steps 1 and 2 on ALCFs
<a href="https://www.alcf.anl.gov/support-center/get-started">Get Started - Follow these steps to get your research project up and running on ALCF computing resources</a>



Connection to a CS-2 node is a two step process. <br>
Both steps require a MFA passcode for authentication - either a 8 digit passcode generted by an app on your mobile device (e.g. mobilePASS+) or a CRYPTOCard-generated passcode prefixed by a 4 digit pin.<br>
*In the examples below, replace ALCFUserID with your ALCF user id.*<br>
[TODO the need for the second authentication step may be eliminated soon.]<br>
[TODO short names may become available for testbed-cs2-0[0-2]-med1.ai.alcf.anl.gov, i.e. cs2-01, cs2-02]<br>
[TODO testbed-cs2-02-med1.ai.alcf.anl.gov is not stable "med8" is suggested]<br>
[TODO testbed-cs2-01-med1.ai.alcf.anl.gov is not currently accessible]<br>
To connect to a CS-2 ("chief") node:<br>

(1) ssh to the bastion node first: <br>

|                                                                             |
|-----------------------------------------------------------------------------|
| **ssh ALCFUserID@cerebras.alcf.anl.gov** |

(2) Then ssh to the destination CS-2; either cs2-01 or cs2-01:<br>

|                                                                             |
|-----------------------------------------------------------------------------|
| **ssh ALCFUserID@testbed-cs2-01-med1.ai.alcf.anl.gov** |
| **ssh ALCFUserID@testbed-cs2-02-med1.ai.alcf.anl.gov** |


Alternatively, this (and scp operations) maybe done in one command line (two passcodes required):

|                                                                             |
|-----------------------------------------------------------------------------|
| **ssh -o "ProxyJump ALCFUserID@cerebras.alcf.anl.gov" ALCFUserID@testbed-cs2-02-med1.ai.alcf.anl.gov** |

To copy a file to your CS-2 home dir:

|                                                                                  |
|----------------------------------------------------------------------------------------------------------------------|
| **scp -o "ProxyJump ALCFUserID@cerebras.alcf.anl.gov" filename ALCFUserID@testbed-cs2-02-med1.ai.alcf.anl.gov:~/** |

To copy a file from your CS-2 home dir to the current local directory:

|                                                                                  |
|----------------------------------------------------------------------------------|
| **scp -o "ProxyJump ALCFUserID@cerebras.alcf.anl.gov" ALCFUserID@testbed-cs2-02-med1.ai.alcf.anl.gov:~/filename .** |



