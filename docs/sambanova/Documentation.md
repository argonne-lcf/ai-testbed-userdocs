# Documentation

The SambaNova documentation is housed at `/software/sambanova/docs/latest/` accessible via login node.

```text
getting-started.pdf             # Getting started with Sambaflow and running your first example program (LogReg).
intro-tutorial-pytorch.pdf      # A peek into the code of the above example program.
run-examples-vision.pdf         # Run UNET on RDU.
run-examples-language.pdf       # Run BERT on RDU
run-examples-pytorch.pdf        # Run Power PCA and micro models like GEMM on RDU
using-layernorm.pdf             # Example to use LayerNorm instead of BatchNorm
compiler-options.pdf            # Provides advanced compiler options for the compile command.
using-venvs.pdf                 # Python Virtual Environment.
snconfig-userguide.pdf          # Tool to display, query, configure and manage system resources on SN
sntilestat-manpage.pdf          # Display SambaNova tile status and utilization
slurm-sambanova.pdf             # Slum Installation and configuration
runtime-faq.pdf                 # FAQ’s
release-notes.pdf               # Provide new feature and bug fixes updates for each release version.

sambatune\
    user-guide.pdf            
    paths-report.pdf
    pmu-bandwidth-report.pdf
    pmu-stalls-report.pdf
    Readme
    release-notes.pdf
    sambatune-faq.pdf
    section-report.pdf        
    schema.pdf
    stage-latency-report.pdf  

```

The documentation can be viewed on your local system by copying the files from the login node.

```bash
cd <your docs destination>
scp -r ALCFUserID@sambanova.alcf.anl.gov:/software/sambanova/docs/latest/* .
```

View the PDFs in your favorite viewer or web browser on your local machine.
