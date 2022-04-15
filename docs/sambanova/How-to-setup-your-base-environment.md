# How to setup your base environment

## Accounts

Get an account on the SambaNova (SN) system. Contact <support@alcf.anl.gov> for access.

## Setup

Log in to the SambaNova login node.

```bash
ssh ___ALCF_username___@sambanova.alcf.anl.gov
___ALCF_username___@sambanova.alcf.anl.gov's password: < MobilPass+ code >
```

Use the ssh "-v" switch to debug ssh problems.

### Aliases

The SambaNova system that has two nodes **sm-01** and **sm-02**.

Now

```bash
ssh sm-01
source /software/sambanova/envs/sn_env.sh
```




Explain
export OMP_NUM_THREADS=1





Begin put into script /software/sambanova/
These four commands could be put into your .bashrc file on a SambaNova
node.

They can also be executed from the command line.

export PATH=$PATH:/opt/sambaflow/bin
export OMP_NUM_THREADS=1
source /opt/sambaflow/venv/bin/activate
snpath;snthreads;snvenv
put into script /software/sambanova/

Currently, the **.bashrc** file is not automatically being executed at this time.
Each time you log in **source** the file.

```bash
source .bashrc
```

Next, activate the SambaNova virtual environment.

```bash
snp
(venv) ___ALCF_username___@sm-01:~$
```

**NOTE:  SambaNova operations will fail unless the SambaNova venv is set
up.**

You may deactivate the environment if finished.

```bash
deactivate
```
