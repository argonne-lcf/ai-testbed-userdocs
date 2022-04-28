# System Overview
The Cerebras CS-2 is a wafer-scale deep learning accelerator comprising 850,000 processing cores, each providing 48KB of dedicated SRAM memory for an on-chip total of 40GB and interconnected to optimize bandwidth and latency. Its software platform integrates popular machine learning frameworks such as TensorFlow and PyTorch.

For an overview of the Cerebras CS-2 system, see this whitepaper:
<a href="https://f.hubspotusercontent30.net/hubfs/8968533/Cerebras-CS-2-Whitepaper.pdf">Cerebras Systems: Achieving Industry Best AI Performance Through A Systems Approach</a>

The public Cerebras documentation is available [here](https://docs.cerebras.net/en/latest/index.html)

Instructions for viewing the release 1.1.0 documentation are at [viewing-the-cerebras-v-11-documentation](Miscellaneous.md#viewing-the-cerebras-v-11-documentation)

A typical CS-2 cluster is as shown in the figure. On the Argonne CS-2 cluster, the worker nodes and the chief node each have Intel(R) Xeon(R) Gold 6248 CPU processors totaling 80 cores and 200GB memory.<br>
The `/home` and `/projects` trees are shared across AI testbed platforms. 

![CS-2 cluster figure](./cs-getting-started.png)
(Figure from
[https://docs.cerebras.net/en/latest/getting-started/checklist-before-you-start.html](https://docs.cerebras.net/en/latest/getting-started/checklist-before-you-start.html))



The CS system is responsible only for running and accelerating the actual training and predictions with the model.

All the supporting tasks such as compiling the model, preprocessing the input data, running the input function, streaming the data, and managing the training loop, are executed in the Cerebras CPU cluster by the Cerebras software running on these nodes.

![Programming model](./compile-vs-run.png)
<!---https://docs.cerebras.net/en/latest/_images/compile-vs-run.png-->
(Figure from [https://docs.cerebras.net/en/latest/cerebras-basics/how-cerebras-works.html](https://docs.cerebras.net/en/latest/cerebras-basics/how-cerebras-works.html))
