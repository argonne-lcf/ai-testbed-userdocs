# Documentation

The SambaNova documentation is housed at `/software/sambanova/docs/latest/` accessible via login node. TODO - reorder and describe each document. 

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

The documentation can be viewed on your local system by copying the files from the login node.

```bash
cd <your docs destination>
scp -r ALCFUserID@sambanova.alcf.anl.gov:/software/sambanova/docs/latest/* .
```

View the PDFs in your favorite viewer or web browser on your local machine. 

<!--- 
ALL THESE NEED TO GO 
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

--->
