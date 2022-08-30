# GroqFlow™ Installation Guide

The following describes how to install **GroqFlow**. These instructions enable users to build models for **Groq** hardware, as well as execute those builds in systems that have **GroqCard™** accelerators physically installed.

## Connect to Groq

Connect to a Groq system, i.e., groq1, groq2, groq3, and groq4, using your CELS GCE account information.

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

## Step 1: Create and Activate a Miniconda Virtual Environment

The following example demonstrates downloading, installing, and creating a Miniconda virtual environment.

```bash
cd ~
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
source ~/.bashrc
conda create -n groqflow_env python=3.8.13
conda activate groqflow_env
```

## Step 2: Pip install GroqFlow

Install the **groqflow** package into your conda virtual environment:

```bash
pip install --upgrade pip
cd groqflow
pip install -e .
```

where **groqflow** is the directory where you cloned the **GroqFlow** repo in the **prerequisites**.

## Step 3: Add GroqWare Suite to Python Path

This adds the **Groq** tools to your path:

```bash
export PYTHONPATH="/opt/groq/runtime/site-packages:$PYTHONPATH"
```

## Step 4: Rock-It with groqit()

To confirm that you're setup correctly, navigate to the examples folder at **groqflow/examples/** and run the **hello_pytorch_world.py** example:

```bash
python hello_pytorch_world.py
```
