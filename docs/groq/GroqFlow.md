# GroqFlow™ Installation Guide

## Introduction

The following describes how to install **GroqFlow**. These instructions enable users to build models for **Groq** hardware, as well as execute those builds in systems that have **GroqCard™** accelerators physically installed.

## Connect to Groq

From your development machine, connect to a Groq system, i.e., groq1, groq2, groq3, and groq4, using your CELS GCE account information.

```console
ssh CELS-GCE-UserID@groq1.cels.anl.gov
CELS-GCE-UserID@groq1.cels.anl.gov's password:
```

## Prerequisites

- Download and install the **GroqWare™** Suite version 0.9.0.

--For more information, see the **GroqWare Quick Start Guide** at support.groq.com.

--To compile your model for **Groq** hardware, **GroqFlow** requires the **Groq Developer Tools Package** (groq-devtools). To run your compiled model on hardware, **GroqFlow** requires the **Groq Runtime Package** (groq-runtime).

-Clone the **GroqFlow** GitHub repo using the following command:

```bash
cd ~
git clone https://github.com/groq/groqflow.git
```

## Step 1: Install Miniconda

Run:

```bash
cd ~
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
source ~/.bashrc
```

## Step 2: Miniconda Environment

You may use or clone a prebuilt environment.

### Use Miniconda Environment

Activate existing environment.

```bash
conda activate /lambda_stor/software/groq/groqit/0.9.0/miniconda3/envs/groqflow-11-21
```

### Clone Miniconda Environment

Run:

```bash
conda activate base
conda create --clone /lambda_stor/software/groq/groqit/0.9.0/miniconda3/envs/groqflow-11-21 --prefix ~/miniconda3/envs/groqflow-11-21
conda activate groqflow-11-21

which python3
# Output
#/home/CELS-GCE-UserID/miniconda3/envs/groqflow-11-21/bin/python3
```

## Step 3: Add GroqWare Suite to Python Path

This adds the **Groq** tools to your path:

```bash
export PYTHONPATH="/opt/groq/runtime/site-packages:$PYTHONPATH"
```

## Step 4: Rock-It with groqit()

To confirm that you're setup correctly, navigate to the examples folder at **groqflow/examples/** and run the **hello_world.py** example:

```bash
cd ~/groqflow/examples/pytorch/
python hello_world.py
```
