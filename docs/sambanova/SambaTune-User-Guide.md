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

### Rick

8/24/2022

I have updated ~rweisner/tmp/sambatune with sambatune_ui 1.1 and updated the readme.

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
[--compile-only | -m MODES [MODES ...]]
[--version]
config
positional arguments:
config
YAML file with model, compile, run configuration.
optional arguments:
-h, --help
--artifact-root
show this help message and exit
ARTIFACT_ROOT
Custom location to save compile/run artifacts;
defaults to '$DUMP_ROOT/artifact_root'
--disable-override Reuse the placement from the baseline compilation
--compile-only Run compilation of PEFs for selected modes only
-m MODES [MODES ...], --modes MODES [MODES ...]
Select modes to execute from ['benchmark',
'instrument', 'run'] default: ['benchmark']
--version
version of sambatune and sambaflow.
```

## Command Overview

By default, it will run with the benchmarking mode enabled. Use the --modes flag to run
modes individually or in any combination.
Benchmark-Only:

```bash
sambatune linear_net.yaml --artifact-root $(pwd)/artifact_root --modes benchmark
```

Instrument-Only:

```bash
sambatune linear_net.yaml --artifact-root $(pwd)/artifact_root --modes instrument
```

All modes:

```bash
sambatune linear_net.yaml --artifact-root $(pwd)/artifact_root --modes instrument
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

You might want to delete **artifact_root** if you have prior runs that you might not want to copy to your dev machine.  If so:

```bash
rm -rf artifact_root
```

**NOTE:** The following takes 45 minutes to run.

Run the following example:

```bash
sambatune linear_net.yaml --artifact-root $(pwd)/artifact_root --modes benchmark instrument run
```

where **linear_net.yaml** is a user-specified configuration file you created above.

## Install SambaTune UI on Your Development Machine

### Copy Conda Tar File on SambaNova

On sambanova.alcf.anl.gov:

```bash
mkdir ~/tmp
cd ~/tmp
cp /home/rweisner/tmp/sambatune/sambatune_1.1.tar .
```

### Copy Conda Tar File To Your Dev Machine

On your dev machine:

```bash
mkdir -p ~/sambatune/work/
cd ~/sambatune/work/
scp ALCFUserID@sambanova.alcf.anl.gov:tmp/sambatune_1.1.tar .
# Or
scp ac.rick.weisner@lambda0:tmp/sambatune/sambatune_1.1.tar .
# Or
scp wilsonb@sambanova.alcf.anl.gov:tmp/sambatune_1.1.tar .
```

### Copy Artifact File to Your Dev Machine

On your dev machine:

```bash
cd ~/sambatune/work/
scp -r wilsonb@sambanova.alcf.anl.gov:sambatune/artifact_root .
# Or
rsync -a --ignore-existing ./ wilsonb@sambanova.alcf.anl.gov:sambatune/artifact_root/
```

### Install Docker

If necessary:

```bash
sudo apt-get install docker
# Or
sudo snap install docker
```

### Docker

If you have changed directories:

```bash
cd /tmp
```

Load Docker image:

```bash
sudo docker image load -i sambatune_1.1.tar
```

List Docker images:

```bash
sudo docker image ls
```

Your output will look something like:

```text
REPOSITORY                                                                                      TAG       IMAGE ID       CREATED         SIZE
artifacts.sambanovasystems.com/sustaining-docker-lincoln-dev/sambatune/sambatune-client         1.1       bf1d5834776d   3 months ago    737MB
```

This is the image you want
artifacts.sambanovasystems.com/sustaining-docker-lincoln-dev/sambatune/sambatune-client         1.1       bf1d5834776d   3 months ago    737MB

### Run the Docker Container

Make a work directory:

```bash
mkdir -p /path/to/work
# Or
mkdir -p /home/bwilson/sambatune/work
```

Run the container:

```bash
sudo docker container run --mount type=bind,source=/path/to/work,target=/work -it  -p 5050:8576 artifacts.sambanovasystems.com/sustaining-docker-lincoln-dev/sambatune/sambatune-client:1.1
# Or
sudo docker container run --mount type=bind,source=/home/bwilson/sambatune/work,target=/work -it  -p 5050:8576 artifacts.sambanovasystems.com/sustaining-docker-lincoln-dev/sambatune/sambatune-client:1.1
```

The first time you run the above command, you will see many layers being loaded.  It will load immediately from then on.

Your artifact_root on **sm-01** or **sm-02** should be at sambatune/artifact_root.

Start the UI:
It will tell you the port and password.

```bash
sambatune_ui --directory /home/wilsonb/sambatune/artifact_root/sambatune_gen   xxxsambatune/artifact_root/sambatune_gen
```

Do

```bash
sambatune_ui --directory /home/wilsonb/tmp/sambatune_gen --port 8580
```

You will see something like:

```console
Welcome to SambaTune Client
@fa65be938da7:/project$sambatune_ui --directory sambatune/artifact_root/sambatune_gen
with the,
   username: "admin", password: "4dde37d6-2872-11ed-9a4f-0242ac110002"
[2022-08-30 07:44:51 -0700] [8] [INFO] Starting gunicorn 20.1.0
[2022-08-30 07:44:51 -0700] [8] [INFO] Listening at: http://0.0.0.0:8576 (8)
[2022-08-30 07:44:51 -0700] [8] [INFO] Using worker: sync
[2022-08-30 07:44:51 -0700] [11] [INFO] Booting worker with pid: 11
[2022-08-30 07:44:51 -0700] [12] [INFO] Booting worker with pid: 12
```

In your local browser, enter the url **localhost:5050**.

Use the username and password above to log in.



root@477a49bd9e55:/project# sambatune_ui --directory /work/lincoln/vae_tst/artifact_root/sambatune_gen
Starting server on localhost:8576         with the following directory: /work/lincoln/vae_tst/artifact_root/sambatune_gen
with the,
         username: "admin", password: "fd11af8a-edad-11ec-89c9-0242ac110002"
 * Serving Flask app 'sambatune.uiwebserver' (lazy loading)
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: off
 * Running on all addresses.
   WARNING: This is a development server. Do not use it in a production deployment.
 * Running on http://172.17.0.2:8576/ (Press CTRL+C to quit)

RCW: use localhost:8576 to connect


Now connect via browser.
