# System Overview

## Overview

The SambaNova DataScale system is architected around the next-generation Reconfigurable Dataflow Unit (RDU) processor for optimal dataflow processing and acceleration. The SambaNova is a half-rack system consisting of two nodes, each of which features eight RDUs interconnected to enable model and data parallelism. SambaFlow, its software stack, extracts, optimizes, and maps dataflow graphs to the RDUs from standard machine learning frameworks, like PyTorch.

## TODO Add figure to show going from login node to lksdjf

## Configuration

SambaNova node can be accessed as sm-01.ai.alcf.anl.gov.

The snconfig utility shows the static configuration. For example, on
sm-01, and showing just the first RDU:

```text
Platform Name: DataScale SN10-8
Node Name: NODE
Number of XRDUS: 4
XRDU Name: XRDU_0
Number of RDUS: 2
RDU name: RDU_0
Number of TILES: 4
TILE Name: TILE_0
Serial Number : N/A
...
Number of PCIES: 4
PCIE Name: PCIE_0
Bandwidth : 32 GB/s
Speed : 16 GT/s
Width : 16
Serial Number : N/A
...
Number of DDRCHs: 6
DDR CH Name: DDRCH_0
Number of DIMMS: 2
DIMM Name: DIMM_C0
Size : 64.0 GB
DIMM Name: DIMM_C1
Size : 0.0 GB
Serial Number : N/A
Current utilization can be seen with sntilestat. In this example, only
four tiles in one RDU are in use.
TILE %idle %exec %pload %aload %chkpt %quiesce PID USER COMMAND
/XRDU_0/RDU_0/TILE_0 80.4 7.0 10.4 2.2 0.0 0.0 49880 arnoldw python
res_ffn_mnist.py run --pef=pef/res_ffn_mnist/res_ffn_mnist.pef
--num-epochs 100
/XRDU_0/RDU_0/TILE_1 80.5 6.9 11.3 1.3 0.0 0.0 49880 arnoldw python
res_ffn_mnist.py run --pef=pef/res_ffn_mnist/res_ffn_mnist.pef
--num-epochs 100
/XRDU_0/RDU_0/TILE_2 82.1 4.7 11.4 1.8 0.0 0.0 49880 arnoldw python
res_ffn_mnist.py run --pef=pef/res_ffn_mnist/res_ffn_mnist.pef
--num-epochs 100
/XRDU_0/RDU_0/TILE_3 80.1 6.3 11.7 1.9 0.0 0.0 49880 arnoldw python
res_ffn_mnist.py run --pef=pef/res_ffn_mnist/res_ffn_mnist.pef
--num-epochs 100
/XRDU_0/RDU_1/TILE_0 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_0/RDU_1/TILE_1 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_0/RDU_1/TILE_2 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_0/RDU_1/TILE_3 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_1/RDU_0/TILE_0 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_1/RDU_0/TILE_1 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_1/RDU_0/TILE_2 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_1/RDU_0/TILE_3 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_1/RDU_1/TILE_0 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_1/RDU_1/TILE_1 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_1/RDU_1/TILE_2 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_1/RDU_1/TILE_3 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_2/RDU_0/TILE_0 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_2/RDU_0/TILE_1 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_2/RDU_0/TILE_2 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_2/RDU_0/TILE_3 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_2/RDU_1/TILE_0 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_2/RDU_1/TILE_1 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_2/RDU_1/TILE_2 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_2/RDU_1/TILE_3 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_3/RDU_0/TILE_0 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_3/RDU_0/TILE_1 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_3/RDU_0/TILE_2 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_3/RDU_0/TILE_3 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_3/RDU_1/TILE_0 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_3/RDU_1/TILE_1 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_3/RDU_1/TILE_2 100.0 0.0 0.0 0.0 0.0 0.0
/XRDU_3/RDU_1/TILE_3 100.0 0.0 0.0 0.0 0.0 0.0
```
