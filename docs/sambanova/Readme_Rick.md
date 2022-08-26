# SambaTune

## Run

To run
sambatune configfile --artifact_root $(pwd)/artifact_root --modes benchmark instrument run

samples config file
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

To install sambatune UI:

From your laptop:
#old scp ac.rick.weisner@lambda0:tmp/sambatune/sambatune_1.0.1.tar
scp ac.rick.weisner@lambda0:tmp/sambatune/sambatune_1.1.tar

On sambanova.alcf.anl.gov
mkdir /tmp
cd /tmp
cp /home/rweisner/tmp/sambatune/sambatune_1.1.tar .

On your dev machine
mkdir /tmp
cd /tmp
scp wilsonb@sambanova:tmp/sambatune/sambatune_1.1.tar .

scp the artifact_root from your home directory.

#Old docker image load -i sambatune_1.0.1.tar
sudo snap install docker
sudo docker image load -i sambatune_1.1.tar

sudo docker image ls

on my laptop I get:

rickw-mbp:sudo docker image ls

REPOSITORY                                                                                      TAG       IMAGE ID       CREATED         SIZE
artifacts.sambanovasystems.com/sustaining-docker-lincoln-dev/sambatune/sambatune-client         1.1       bf1d5834776d   3 weeks ago     737MB
artifacts.sambanovasystems.com/sustaining-docker-lincoln-dev/sambatune/basic-sambatune-client   1.0.1     3001727bd003   4 months ago    664MB
tutorial-environment_app                                                                        latest    30bbbed54304   18 months ago   25.1MB
grafana/tns-db                                                                                  latest    b2ca96aa0d5f   19 months ago   25.8MB
artifacts.sambanovasystems.com/sw-docker-prod/stable/ubuntu-stable                              latest    5bc8d0b14150   20 months ago   7.22GB
grafana/grafana                                                                                 7.2.0     84537aac1f95   21 months ago   180MB

This is the image you want
#old artifacts.sambanovasystems.com/sustaining-docker-lincoln-dev/sambatune/basic-sambatune-client   1.0.1     3001727bd003   4 months ago    664MB
artifacts.sambanovasystems.com/sustaining-docker-lincoln-dev/sambatune/sambatune-client         1.1       bf1d5834776d   3 months ago    737MB


My artifact root in in work.
So...

#old docker container run --mount type=bind,source=/Users/rickw/work,target=/work -it  -p 5050:8576 artifacts.sambanovasystems.com/sustaining-docker-lincoln-dev/sambatune/basic-sambatune-client:1.0.1
sudo docker container run --mount type=bind,source=/Users/rickw/work,target=/work -it  -p 5050:8576 artifacts.sambanovasystems.com/sustaining-docker-lincoln-dev/sambatune/sambatune-client:1.1

sudo docker container run --mount type=bind,source=/home/bwilson/work,target=/work -it  -p 5050:8576 artifacts.sambanovasystems.com/sustaining-docker-lincoln-dev/sambatune/sambatune-client:1.1

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
