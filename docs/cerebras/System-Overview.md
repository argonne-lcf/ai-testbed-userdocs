### System Overview
The Cerebras CS-2 is a wafer-scale deep learning accelerator comprising 850,000 processing cores, each providing 48KB of dedicated SRAM memory for an on-chip total of 40GB and interconnected to optimize bandwidth and latency. Its software platform integrates popular machine learning frameworks such as TensorFlow and PyTorch.<br>
For more details, see Cerebras's whitepaper:
<a href="https://f.hubspotusercontent30.net/hubfs/8968533/Cerebras-CS-2-Whitepaper.pdf">Cerebras Systems: Achieving Industry Best AI Performance Through A Systems Approach</a>



Cerebras's current Python support is built around Cerebras Estimator, which inherits from TensorFlow Estimator.<br>
Cerebras Release 1.2 will introduce PyTorch support.</br>
Release 1.1 includes a preview of the PyTorch support. 

Keras models can be converted to TF Estimator and to Cerebras Estimator.  See <https://www.tensorflow.org/tutorials/estimator/keras_model_to_estimator>

The public Cerebras documenation is at:
<https://docs.cerebras.net/en/latest/cerebras-basics/how-cerebras-works.html>

An ANL CS-2 cluster will look similar to the following diagram (but with 8 worker nodes). The worker nodes and the chief node each have two AMD EPYC 7702P 64-Core processors and 128 GB memory (131603444). [TODO verify with Ryan; that's from "free" and /proc/cpuinfo) [TODO something about filesystems when we have at least one stable system.]
![CS-2 cluster diagram](./cs-getting-started.png)



The CS system is responsible only for running and accelerating the actual training and predictions on the neural network.

All the supporting tasks such as starting with the TensorFlow and PyTorch frameworks and compiling the model, preprocessing the input data, running the input function, streaming the data, and managing the training loop, are executed in the Cerebras CPU cluster by the Cerebras software running on these nodes.

![Programming model](https://docs.cerebras.net/en/latest/_images/compile-vs-run.png)