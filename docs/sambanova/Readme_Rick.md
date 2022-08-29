# SambaTune

## Run

### Running

Run the following example on sm-01 or sm-02:

```bash
sambatune small_vae.yaml --artifact_root $(pwd)/artifact_root --modes benchmark instrument run
```

### Samples Config File

```yaml
small_vae.yaml:
app: /opt/sambaflow/apps/private/anl/moleculevae.py

model-args: -b 128 --in-width 512 --in-height 512

compile-args: compile --plot --enable-conv-tiling --compiler-configs-file /opt/sambaflow/apps/private/anl/moleculevae/compiler_configs_conv.json --mac-v2 --mac-human-decision /opt/sambaflow/apps/private/anl/moleculevae/symmetric_human_decisions_tiled_v2.json

run-args: --num-iterations 1000 --input-path /var/tmp/dataset/moleculevae/ras1_prot-pops.h5 --out-path ${HOME}/moleculevae_out --model-id 0 --epochs 10

env:
     OMP_NUM_THREADS: 16
     SF_RNT_FSM_POLL_BUSY_WAIT: 1
     SF_RNT_DMA_POLL_BUSY_WAIT: 1
     CONVFUNC_DEBUG_RUN: 0
```

## Install SambaTune UI on Your Development Machine

### Copy Conda Tar File on SambaNova

On sambanova.alcf.anl.gov:

```bash
mkdir /tmp
cd /tmp
cp /home/rweisner/tmp/sambatune/sambatune_1.1.tar .
```

### Copy Conda Tar File To Your Dev Machine

On your dev machine:

```bash
mkdir /tmp
cd /tmp
scp ALCFUserID@sambanova:tmp/sambatune/sambatune_1.1.tar .
# Or
scp ac.rick.weisner@lambda0:tmp/sambatune/sambatune_1.1.tar .
# Or
scp wilsonb@sambanova:tmp/sambatune/sambatune_1.1.tar .
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

The first time you run the above command, you will see many layers being loaded.  It will load immediate from then on.

My artifact_root is in /Users/rickw/work/vae_tst/artifact_root.

Start the UI:
It will tell you the port and password.

sambatune_ui --directory /work/lincoln/vae_tst/artifact_root/sambatune_gen

You will see something like:
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
