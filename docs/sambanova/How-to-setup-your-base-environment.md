# How to setup your base environment

## On-Boarding

See https://www.alcf.anl.gov/support-center/get-started 
to request an acccount and additional information.

## Setup

### OMP_NUM_THREADS

The OMP_NUM_THREADS environment variable sets the number of threads to use for parallel regions.

The value of this environment variable must be a list of positive integer values. The values of the list set the number of threads to use for parallel regions at the corresponding nested levels.

For the SambaNova system it is usually set to one.

### Log In

Log in to the SambaNova login node.

```bash
ssh ALCFUserID@sambanova.alcf.anl.gov
ALCFUserID@sambanova.alcf.anl.gov's password: < MobilPass+ code >
```

Use the ssh "-v" switch to debug ssh problems.

### Aliases

The SambaNova system that has two nodes **sm-01** and **sm-02**.

Now

```bash
ssh sm-01
source /software/sambanova/envs/sn_env.sh
(venv) ALCFUserID@sm-01:~$
```

**NOTE:  SambaNova operations will fail unless the SambaNova venv is set
up.**

You may deactivate the environment if finished.

```bash
deactivate
```
