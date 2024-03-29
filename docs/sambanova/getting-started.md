# Getting Started

## On-Boarding

See [Get Started](https://www.alcf.anl.gov/support-center/get-started)
to request an account and additional information.

## Setup

### System View

Connection to a SambaNova node is a two-step process. The first step is to **ssh** into the **login node**.
This step requires an MFA passcode for authentication - an
eight-digit passcode generated by an app on your mobile device, e.g., MobilePASS+.
The second step is to log in to a SambaNova node from the **login node**.

The SambaNova system has four racks, r1..4 and two hosts, h1..2, per rack.  So, **sn30-r2-h1** is the
node on **rack 2** and **host 1**.

![SambaNova System View](sambanova_login.jpg "SambaNova System View")

### Log in to Login Node

Log in to the SambaNova login node from your local machine using the below command. This uses the MobilPass+ token generated every time you log in to the system. This is the same passcode used to authenticate into other ALCF systems, such as Theta and Cooley.

*In the examples below, replace* ***ALCFUserID*** *with your ALCF user id.*

```bash
ssh ALCFUserID@sambanova.alcf.anl.gov
Password: < MobilPass+ code >
```

Note: Use the ssh "-v" option in order to debug any ssh problems.

### Log in to a SambaNova Node

Once you are on the login node, the SambaNova system can be accessed using one of the following aliases:

```text
sn30-r1-h1
sn30-r1-h2

sn30-r2-h1
sn30-r2-h2

sn30-r3-h1
sn30-r3-h2

sn30-r4-h1
sn30-r4-h2
```

Example:

```bash
ssh sn30-r1-h1
```

### SDK setup

<!-- TODOBRW Show that these commands get executed. -->
<!-- The SambaNova system has a bash shell script to set up the required software environment.
This sets up the SambaFlow software stack, and the associated environmental variables and starts
a pre-configured virtual environment.

Use
-->
<!-- TODOBRW Is this still true?
```bash
ALCFUserID@sn30-r1-h1:~$ source /software/sambanova/envs/sn_env.sh
(venv) ALCFUserID@sn30-r1-h1:~$
```

The contents of the sn_env.sh script is shown below for convenience.

```bash
alias snpath='export PATH=$PATH:/opt/sambaflow/bin' # This is the path to SambaFlow which is the software stack running on SambaNova systems. This stack includes the Runtime, the compilers, and the SambaFlow Python SDK which is used to create and run models.

alias snthreads='export OMP_NUM_THREADS=16' # The OMP_NUM_THREADS environment variable sets the number of threads to use for parallel regions. The value of this environment variable must be a list of positive integer values. The values of the list set the number of threads to use for parallel regions at the corresponding nested levels. For the SambaNova system, it is usually set to 1.

alias snvenv='source /opt/sambaflow/venv/bin/activate' # This starts the pre-configured virtual environment that consists of sambaflow and other built-in libraries.
```

**NOTE:  SambaNova operations will fail unless a SambaNova venv is set-up.**

**NOTE:  With 1.14 there is no longer a common venv. Each model has its own venv.** -->

With SambaFlow version 1.14, the base SambaFlow python environment is installed as part of the system, and the user path is updated automatically to include the directories for the sambanova binaries.
Use of python virtual environments made with e.g. `virtualenv` is recommended. Conda is not supported.
See [Virtual Environment](Virtual-Environment.md) for details.
<!---
```bash
virtualenv --system-site-packages sn_venv
source sn_venv/bin/activate
```
-->
<!--
#### Starters

```bash
source /opt/sambaflow/apps/starters/mlp/venv/bin/activate
source /opt/sambaflow/apps/starters/lenet/venv/bin/activate
source /opt/sambaflow/apps/starters/ffn_mnist/venv/bin/activate
source /opt/sambaflow/apps/starters/logreg/venv/bin/activate
source /opt/sambaflow/apps/starters/upscalenet/venv/bin/activate
source /opt/sambaflow/apps/starters/power_pca/venv/bin/activate
```

#### Images

```bash
source /opt/sambaflow/apps/image/segmentation_3d/venv/bin/activate
source /opt/sambaflow/apps/image/deepvit/venv/bin/activate
source /opt/sambaflow/apps/image/segmentation/venv/bin/activate
source /opt/sambaflow/apps/image/object_detection/venv/bin/activate
source /opt/sambaflow/apps/image/classification/venv/bin/activate
```

#### Recommenders

```bash
source /opt/sambaflow/apps/recommender/dlrm/venv/bin/activate
source /opt/sambaflow/apps/recommender/ncf/venv/bin/activate
source /opt/sambaflow/apps/recommender/deepinterest/venv/bin/activate
```

#### NLP

```bash
source /opt/sambaflow/apps/nlp/transformers_on_rdu/venv/bin/activate
source /opt/sambaflow/apps/nlp/transformers_on_rdu/gpt13b/venv/bin/activate
source /opt/sambaflow/apps/nlp/data_processing/venv/bin/activate
```

#### Other

```bash
source /opt/sambaflow/apps/private/anl/venv/bin/activate
source /opt/sambaflow/apps/micros/venv/bin/activate
```

You may deactivate the environment if finished.

```bash
deactivate
```
