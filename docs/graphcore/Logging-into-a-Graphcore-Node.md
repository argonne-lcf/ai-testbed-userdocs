# Getting Started

## On-Boarding

See [Get Started](https://www.alcf.anl.gov/support-center/get-started)
to request an account and additional information.

## Setup

### System View

Connection to a Graphcore node is a two-step process.

The first step is to **ssh** to the **login node**.



The second step is to log in to a Graphcore node from the **login node**.

![SambaNova System View](sambanxova_login.jpg "SambaNova System View")

### Log in to Login Node

Login to the SambaNova login node from your local machine using the below command. This uses the MobilPass+ token generated every time you log in to the system. This is the same passcode used to authenticate into other ALCF systems, such as Theta and Cooley.

*In the examples below, replace* ***CELSGCEUserID*** *with your CELS GCE user id.*

```bash
ssh CELSGCEUserID@homes.cels.anl.gov
```

Note: Use the ssh "-v" option in order to debug any ssh problems.

### Log in to a Graphcore Node

Once you are on the login node, one of the four Graphcores node can be accessed using **ssh**.

```bash
ssh gc-poplar-01.ai.alcf.anl.gov
# or
ssh gc-poplar-02.ai.alcf.anl.gov
# or
ssh gc-poplar-03.ai.alcf.anl.gov
# or
ssh gc-poplar-04.ai.alcf.anl.gov
```


**NOTE: xxxxxxxxxxxxxxxxxxxx each have a separate scheduler.  If you have already
ssh'd into one of those nodes, you are all set.**

### SDK setup

The Graphcore system has a bash shell scripts to set up the required software environment.

Use

```bash
source /lambda_stor/software/graphcore/poplar_sdk/3.0.0/popart-ubuntu_20_04-3.0.0+5691-1e179b3b85/enable.sh
source /lambda_stor/software/graphcore/poplar_sdk/3.0.0/poplar-ubuntu_20_04-3.0.0+5691-1e179b3b85/enable.sh
```
