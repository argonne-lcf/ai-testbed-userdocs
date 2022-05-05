# System Overview

## Introduction

The **Gaudi** architecture includes a cluster of fully programmable **TPCs**, Tensor Processing Cores.
Along with development tools and libraries, and a configurable Matrix Math engine.

The **TPC** is a **VLIW SIMD**, Very Long Instruction Word Single Instruction Multiple Data, processor.  And, it is programmable, providing the user flexibility.

The **TPC** natively supports the following data types: FP32, BF16, INT32, INT16, INT8, UINT32, UINT16 and UINT8.

![Gaudi Processor High-level Architecture](Gaudi-Architecture.png "Gaudi Processor High-level Architecture")


See [Gaudi Architecture](https://docs.habana.ai/en/latest/Gaudi_Overview/Gaudi_Architecture.html) for more information.

The SambaNova DataScale system is architected around the next-generation Reconfigurable Dataflow Unit (RDU) processor for optimal dataflow processing and acceleration. The AI Testbed's SambaNova system is a half-rack system consisting of two nodes, each of which features eight RDUs interconnected to enable model and data parallelism. SambaFlow, its software stack, extracts, optimizes, and maps dataflow graphs to the RDUs from standard machine learning frameworks, like PyTorch.

Here is the link to the sambanova white paper: [Accelerated Computing with a Reconfigurable Dataflow Architecture](https://sambanova.ai/wp-content/uploads/2021/06/SambaNova_RDA_Whitepaper_English.pdf)
