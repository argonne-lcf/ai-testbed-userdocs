# SambaTune

## Notes

```text
#TODOBRW
ssh wilsonb@homes.cels.anl.gov
ssh sm-02
MobilePass+ password
On sm-02
source /opt/sambaflow/venv/bin/activate
sambatune_ui --directory /home/wilsonb/tmp/sambatune_gen --port 8580
#There will be a username and password displayed that you will use in your browser on your laptop.
Command used on laptop for port forward
ssh -XL 8580:127.0.0.1:8580 wilsonb@sm-02.cels.anl.gov
MobilePass+ password
# You will be logged into sm-02 but, you do not need to do anything.
address used in browser on laptop localhost:8580
#Use username and password from sambatune_ui.
Username
Password
```

## About SambaTune

SambaTune is a tool for profiling, debugging, and tuning performance of applications
running on SN hardware.

The tool automates collection of hardware performance counters, metrics aggregation,
report generation, and visualization. It also automates benchmarking of the application
to compute average throughput over a sufficient number of runs. The tool is designed to
aid the user with performance bottleneck analysis and tuning.

SambaTune is currently used by SN engineers involved in performance tuning efforts.
SambaTune is also planned for release to external customers to aid with performance
bottleneck analysis and resolution.

## Run SambaTune

```bash
ssh ALCFUserID@sambanova.alcf.anl.gov
# Enter MobilePass+ pass code
ssh sm-01
```

```bash
#TODOBRW
ssh wilsonb@sambanova.alcf.anl.gov
# Enter MobilePass+ pass code
ssh sm-01
```

First, enter the virtual environment on **sm-01** or **sm-02**:

```bash
source /opt/sambaflow/venv/bin/activate
```

Update path:

```bash
export PATH=/opt/sambaflow/bin:$PATH
```

## Usage

```console
usage: sambatune [-h] [--artifact-root ARTIFACT_ROOT] [--disable-override]
                 [--compile-only | -m MODES [MODES ...]] [--version]
                 config

positional arguments:
  config                YAML file with model, compile, run configuration.

optional arguments:
  -h, --help            show this help message and exit
  --artifact-root ARTIFACT_ROOT
                        Custom location to save compile/run artifacts;
                        defaults to '$DUMP_ROOT/artifact_root' (default: None)
  --disable-override    Reuse the placement from the baseline compilation
                        (default: False)
  --compile-only        Run compilation of PEFs for selected modes only
                        (default: False)
  -m MODES [MODES ...], --modes MODES [MODES ...]
                        Select modes to execute from ['benchmark',
                        'instrument', 'run'] (default: ['benchmark'])
  --version             version of sambatune and sambaflow.
```

## Command Overview

By default, it will run with the benchmarking mode enabled. Use the --modes flag to run
modes individually or in any combination.
Benchmark-Only:

```bash
sambatune example_net.yaml --artifact-root $(pwd)/artifact_root --modes benchmark
```

Instrument-Only:

```bash
sambatune example_net.yaml --artifact-root $(pwd)/artifact_root --modes instrument
```

All modes:

```bash
sambatune example_net.yaml --artifact-root $(pwd)/artifact_root --modes instrument
```

## Command Example

### Running

Create a directory for your work.

```bash
mkdir ~/sambatune
cd ~/sambatune
```

Create **linear_net.yaml** with the following content using your favorite editor.

```yaml
app: /opt/sambaflow/apps/micros/linear_net.py

model-args: >
  -b 1024
  -mb 64
  --in-features 8192
  --out-features 4096
  --repeat 128
  --inference

compile-args: >
  --n-chips 2
  --plot

env:
  SF_RNT_FSM_POLL_BUSY_WAIT: 1
  SF_RNT_DMA_POLL_BUSY_WAIT: 1
  CONVFUNC_DEBUG_RUN": 0
```

**NOTE:** The following takes 45 minutes to run.

Run the following example:

```bash
sambatune linear_net.yaml --artifact-root $(pwd)/artifact_root --modes benchmark instrument run
```

where **linear_net.yaml** is a user-specified configuration file you created above.

## Start SambaTune UI

Your artifact_root should be at ~/sambatune/artifact_root.

Start the UI:

It will tell you the **username** and **password**.

**NOTE:** It is recommended to use a port other than **8576** in case someone else is using it.  Select another port close to **8576**.

Next

```bash
sambatune_ui --directory ~/sambatune/artifact_root/sambatune_gen/ --port 8576
```

```bash
#TODOBRW
sambatune_ui --directory ~/sambatune/artifact_root/sambatune_gen/ --port 8580
```

You will see something like:

```console
with the,
    username: "admin", password: "05c63938-2941-11ed-93a3-f7ef9c6e5d46"
[2022-08-31 15:24:36 +0000] [1344959] [Info] Starting gunicorn 20.1.0
[2022-08-31 15:24:36 +0000] [1344959] [Info] Listening at: http://0.0.0.0:8576 (1344959)
[2022-08-31 15:24:36 +0000] [1344959] [Info] Using worker: sync
[2022-08-31 15:24:36 +0000] [1345092] [Info] Booting worker with pid: 1345092
[2022-08-31 15:24:36 +0000] [1345093] [Info] Booting worker with pid: 1345093
```

**NOTE:** Write down the username and password.

**NOTE:** The password only works with this one instance of sambatune_ui.  If you stop this instance of sambatune_ui and start another instance, it will have a new password.

## Use Port-Forwarding

This sambatune_ui describes the steps to be followed to set up port-forwarding for applications,
like SambaTune UI, which runs on the SambaNova system and binds to one or more ports.
This example uses 8576 and 18576 as port numbers. **Using port numbers other than these may
avoid collisions with other users.**

### From your local machine

This command sets up a port forward SambaNova login node to your local machine.

Run

```bash
ssh -N -f -L localhost:18576:localhost:18576 ALCFUserID@sambanova.alcf.anl.gov
...
Password: < MobilPass+ code >

ssh ALCFUserID@sambanova.alcf.anl.gov
```

```bash
#TODOBRW
ssh -v -N -f -L localhost:8580:localhost:8580 wilsonb@sambanova.alcf.anl.gov
```

*replacing* ***ALCFUserID*** *with your ALCF User ID.*

```bash
#TODOBRW
ssh wilsonb@sambanova.alcf.anl.gov
```

### From **sambanova.alcf.anl.gov**

This command sets up a port forward from a SambaNova node to the sambanova login machine.

Below are the commands specific to sm-01. You may replace **sm-01** with **sm-02** when using that system.

Run

**NOTE:  The full name is sm-01.ai.alcf.anl.gov and it may also be used.**

```bash
ssh -N -f -L localhost:18576:localhost:8576 ALCFUserID@sm-01
```

```bash
#TODOBRW
ssh -N -f -L localhost:8580:localhost:8580 wilsonb@sm-01
```

### Browser on Local Machine

Then, navigate in your browser to, in this example, [http://localhost:18576](http://localhost:18576) on your local machine.

Use the username and password from **sm-01** to log in.

b89e4184-2966-11ed-93a3-f7ef9c6e5d46

## SSH Notes

Explanation of **ssh** command:

```text
-N : no remote commands

-f : put ssh in the background

-L <machine1>:<portA>:<machine2>:<portB> :

The full command line will forward <machine1>:<portA> (local scope) to <machine2>:<portB> (remote scope)
```

Adapted from:  [How can I run Tensorboard on a remote server?](https://stackoverflow.com/questions/37987839/how-can-i-run-tensorboard-on-a-remote-server)
