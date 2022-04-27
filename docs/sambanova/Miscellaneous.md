# Miscellaneous

## SambaNova Documentation

SambaNova has provided the following documentation:

```text
compiler-options.pdf
getting-started.pdf
intro-tutorial-pytorch.pdf
release-notes.pdf
run-examples-language.pdf
run-examples-pytorch.pdf
run-examples-vision.pdf
runtime-faq.pdf
slurm-sambanova.pdf
snconfig-userguide.pdf
sntilestat-manpage.pdf
using-layernorm.pdf
using-venvs.pdf
```

From your development machine:

```bash
cd <your docs destination>
scp -r ALCFUserID@sambanova.alcf.anl.gov:/software/sambanova/docs/latest/* .
```

View the PDFs in your favorite viewer or web browser.

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

## Resources

- <https://docs.ai.alcf.anl.gov/sambanova/>

- [Argonne SambaNova Training
  11/20](https://anl.app.box.com/s/bqc101mvt3r7rpxbd2yxjsf623ea3gpe)

- [https://docs.sambanova.ai](https://docs.sambanova.ai/) Create a
  SambaNova account if you do not have one.

- [Getting Started with
  SambaFlow](https://docs.sambanova.ai/sambanova-docs/1.6/developer/getting-started.html)
  Skip this one.

- [Tutorial: Creating Models with
  SambaFlow](https://docs.sambanova.ai/sambanova-docs/1.6/developer/intro-tutorial.html)

- Administrators
-- @ryade

## Further Information

[Human Decisions Files notes](/display/AI/Human+Decisions+Files+notes)

## PyTorch Mirrors

See <https://github.com/pytorch/examples> .

There are two mirrors (in the python docs) used for downloading the
mnist dataset.

```text
mirrors = [
        'http://yann.lecun.com/exdb/mnist/',
        'https://ossci-datasets.s3.amazonaws.com/mnist/']
```

[yann.lecun.com](http://yann.lecun.com) appears to be intermittently
broken (503 errors).
