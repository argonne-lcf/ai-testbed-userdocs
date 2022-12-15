# Profiling

This is an adaptation of [Capturing IPU Reports](https://docs.graphcore.ai/projects/graph-analyser-userguide/en/latest/user-guide.html#capturing-ipu-reports).

## Reports

### Capturing IPU Reports

See [Capturing IPU Reports](https://docs.graphcore.ai/projects/graph-analyser-userguide/en/latest/user-guide.html#capturing-ipu-reports) for more information.

This section describes how to generate the files that the Graph Analyser can analyse. The Graph Analyser uses report files generated during compilation and execution by the Poplar SDK.

### lkjsldfs

```bash
POPLAR_ENGINE_OPTIONS='{"autoReport.all":"true", "autoReport.directory":"./reports"}'
```

### From Alex

```bash
git clone https://github.com/graphcore/tutorials.git
cd tutorials/simple_applications/pytorch/mnist
POPLAR_ENGINE_OPTIONS='{"autoReport.all":"true", "autoReport.directory":"./reports"}' python mnist_poptorch.py
```

### IPU Memory Overhead

Because of all these extra memory requirements, a model with high memory consumption may go out of memory when profiling is enabled. Depending on the model, you can adjust its parameters to leave space for the instrumentation. For example, you can try decreasing the batch size. In TensorFlow BERT you can adjust the micro batch-size.

### Host Computing Overhead

It is essential that you also try to reduce the iterations on each run. For instance, by reducing the number of steps or the number of batches per step you can get a lighter execution profile. This will not only reduce the host computation overhead but will also speed up visualisation in the Graph Analyser.

## Download PopVision

1. Download [PopVision Tools](https://www.graphcore.ai/developer/popvision-tools).

2. Click **Download Now** button.

3. In the **Graph Analyser** section, select you operating system.

4. Install per selected operating system.

### Create SSH Session

The **ssh** command will use a **jumphost** and **port forwarding**.  The format is as follows:

```bash
ssh -J CELSGCEUserID@homes.cels.anl.gov CELSGCEUserID@gc-poplar-DD -L 8090:127.0.0.1:22
```

```bash
# TODOBRW
ssh -J wilsonb@homes.cels.anl.gov wilsonb@gc-poplar-01 -L 8090:127.0.0.1:22
```

Where:

| Argument            | Help |
|---------------------|------------------------------|
| CELSGCEUserID       | Is your CELS user identification.   |
| DD                  | Is the Graphcore node to use, i.e., 01, 02, 03, or 04.   |
| 8090                | Is the port on your local machine.   |
| 127.0.0.1:22        | Is the local IP address and port on the remote machine. |
|  |  |  |

You will receive a prompt.

## Launch **Graph Analyser**

Continue on your development machine.

### Operating System

#### Ubuntu

```bash
cd /path/to/graph/analyser/directory
./popvision-graph-analyser-3.11.6.AppImage
```

### User Interface

![Graph Analyser](Graph_Ananlyser_main.jpg "Graph Analyser")

![Graphcore System View](image.png "Graphcore System View")

1. Click **Open a report...**;
2. Click the **remote** tab;
3. Enter your **Username** for remote machine;
4. Enter the **Hostname** of your local machine, i.e., 127.0.0.1;
5. Enter your **Port** address used in the **ssh** command, e.g., 8090;
2. Click **Connect**;
6. Press **OK**;  xxxx
7. Enter your **CELSGCEUserID** password;
8. Click **OK**;
9. Navigate to your reports directory;
10. Select the **training** directory;
11. Select **archive.a** file; and
12. Click **Open** button.

The **Summary Report** will be displayed.
