Cerebras
========
[TODO fix the final resolvable hostnames when available]

### Connect to a CS-2 node
To connect to a CS-2 [chief?] node:<br>
ssh to the bastion node with first with: <br>

|                                                                             |
|-----------------------------------------------------------------------------|
| **ssh ALCFid@cerebras.alcf.anl.gov** |

Then ssh the the destination CS-2:<br>

|                                                                             |
|-----------------------------------------------------------------------------|
| **ssh ALCFid@cs2.ai.alcf.anl.gov** |


Alternative, this (and scp operations) maybe done in one command line:

|                                                                             |
|-----------------------------------------------------------------------------|
| **ssh -o "ProxyJump ALCFid@cerebras.alcf.anl.gov" ALCFid@cs2.ai.alcf.anl.gov** |

To copy a file to your CS-2 [ed: chief?] node home dir:

|                                                                                  |
|----------------------------------------------------------------------------------------------------------------------|
| **scp -o "ProxyJump ALCFid@cerebras.alcf.anl.gov" filename ALCFid@cs2.ai.alcf.anl.gov:~/** |

To copy a file from your CS-2 [ed: chief?] node home dir to the currect directory:

|                                                                                  |
|----------------------------------------------------------------------------------|
| **scp -o "ProxyJump ALCFid@cerebras.alcf.anl.gov" ALCFid@cs2.ai.alcf.anl.gov:~/filename .** |



TODO are there instructions for ALCF id onboarding?


