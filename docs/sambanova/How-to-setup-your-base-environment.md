# How to setup your base environment

## Accounts

Get an account on the SambaNova (SN) system. Contact <support@alcf.anl.gov> for access.

## Setup

You will first need to login to SambaNova login node.

```bash
ssh ___ALCF_username___@sambanova.alcf.anl.gov
___ALCF_username___@sambanova.alcf.anl.gov's password: < MobilPass+ code >
```

Use the ssh "-v" switch to debug ssh problems.

### Aliases

The SambaNova system that has two nodes **sm-01** and **sm-02**. Host names for
SambaNova are [sm-01.cels.anl.gov](http://sm-01.cels.anl.gov) and [sm-02.cels.anl.gov](http://sm-02.cels.anl.gov)

This would be good to put into your **sm-login-1** computer .bashrc file.  Or,
execute them from the command line.

```bash
alias sm1='ssh sm-01.cels.anl.gov'
alias sm2='ssh sm-02.cels.anl.gov'
```

Now

```bash
source .bashrc
sm1
```

These four commands could be put into your .bashrc file on a SambaNova
node.

They can also be executed from the command line.

```bash
alias snpath='export PATH=$PATH:/opt/sambaflow/bin'
alias snthreads='export OMP_NUM_THREADS=1'
alias snvenv='source /opt/sambaflow/venv/bin/activate'
alias snp='snpath;snthreads;snvenv'
```

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
