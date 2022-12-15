# Profiling MNIST

Follow all the instructions in [Getting Started](/docs/graphcore/Getting-Started) to log into a Graphcore node.

Follow the instructions in [Virtual Environments](/docs/graphcore/Virtual-Environments) up to and including **PopART Environment Setup**.

Following the instructions in [Example Programs](/docs/graphcore/Example-Programs) up to and including
**MNIST, Install Requirements**.

## Change Directory

```bash
cd ~/DL/github.com/graphcore/tutorials/simple_applications/pytorch/mnist
cd ~/graphcore/tutorials/simple_applications/pytorch/mnist
```

## Set Poplar Options

Set the option to generate all reports, i.e., **"autoReport.all":"true"**.

Set the reports directory, i.e., **"autoReport.directory":"./reports"**.

Do so by running the following commands:

```bash
POPLAR_ENGINE_OPTIONS='{"autoReport.all":"true", "autoReport.directory":"./reports"}'
```

## Run MNIST

Do so by running the following command:

```bash
python mnist_poptorch.py
```

When MNIST has finished running, see [Profiling](/docs/graphcore/Profiling) to use **Graph Analyser**.


