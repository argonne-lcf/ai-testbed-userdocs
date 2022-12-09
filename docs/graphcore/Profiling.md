# Profiling

This is an adaptation of [Capturing IPU Reports](https://docs.graphcore.ai/projects/graph-analyser-userguide/en/latest/user-guide.html#capturing-ipu-reports).

## From Alex

Yes - you will need to tunnel a port through ssh like ssh .... -L 8090:127.0.0.1:22 and then open the "remote" report in the Graph Analyser using Hostname 127.0.0.1 and Port 8090.

```bash
ssh -J wilsonb@homes.cels.anl.gov wilsonb@gc-poplar-01 -L 8090:127.0.0.1:22
```

Launch Graph Analyser on local machine

cd location

./popvision-graph-analyser-3.11.6.AppImage

click "Open a report..."

click remote tab

Enter your username for remote machine

127.0.0.1

8090

Press OK

Enter password and click OK

Navigate to your reports directory

Select training directory

Select 'archive.a' file

Click 'Open' button

You will be on the 'Summary Report' by default


![Graphcore System View](image.png "Graphcore System View")

## Download PopVision

1. Download [PopVision Tools](https://www.graphcore.ai/developer/popvision-tools).

2. Click **Download Now** button.

3. In the **Graph Analyser** section, select you operating system.

4. Install per selected operating system.

## Execution

Launch **Graph Analyser**.

See [Capturing IPU Reports](https://docs.graphcore.ai/projects/graph-analyser-userguide/en/latest/user-guide.html#capturing-ipu-reports) for more information.

### Capturing IPU Reports

This section describes how to generate the files that the Graph Analyser can analyse. The Graph Analyser uses report files generated during compilation and execution by the Poplar SDK.

### lkjsldfs

```bash
POPLAR_ENGINE_OPTIONS='{"autoReport.all":"true", "autoReport.directory":"./reports"}'
```

### IPU Memory Overhead

Because of all these extra memory requirements, a model with high memory consumption may go out of memory when profiling is enabled. Depending on the model, you can adjust its parameters to leave space for the instrumentation. For example, you can try decreasing the batch size. In TensorFlow BERT you can adjust the micro batch-size.

### Host Computing Overhead

It is essential that you also try to reduce the iterations on each run. For instance, by reducing the number of steps or the number of batches per step you can get a lighter execution profile. This will not only reduce the host computation overhead but will also speed up visualisation in the Graph Analyser.
