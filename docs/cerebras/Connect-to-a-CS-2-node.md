### Connect to a CS-2 node

These instructions presume that you have completed steps 1 and 2 on ALCFs
<a href="https://www.alcf.anl.gov/support-center/get-started">Get Started - Follow these steps to get your research project up and running on ALCF computing resources</a>



Connection to a CS-2 node is a two step process. <br>
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


Alternative, this (and scp operations) maybe done in one command line:

|                                                                             |
|-----------------------------------------------------------------------------|
| **ssh -o "ProxyJump ALCFUserID@cerebras.alcf.anl.gov" ALCFUserID@testbed-cs2-02-med1.ai.alcf.anl.gov** |

To copy a file to your CS-2 (chief) node home dir:

|                                                                                  |
|----------------------------------------------------------------------------------------------------------------------|
| **scp -o "ProxyJump ALCFUserID@cerebras.alcf.anl.gov" filename ALCFUserID@testbed-cs2-02-med1.ai.alcf.anl.gov:~/** |

To copy a file from your CS-2 (chief) node home dir to the correct directory:

|                                                                                  |
|----------------------------------------------------------------------------------|
| **scp -o "ProxyJump ALCFUserID@cerebras.alcf.anl.gov" ALCFUserID@testbed-cs2-02-med1.ai.alcf.anl.gov:~/filename .** |



