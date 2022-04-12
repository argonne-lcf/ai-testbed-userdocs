Cerebras
========

### Connect to a CS-2 node
To connect to a CS-2 [chief?] node:

|                                                                                  |
|----------------------------------------------------------------------------------|
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


