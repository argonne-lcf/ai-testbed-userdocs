# Performance Tools

## Compile Report
After a compile, see the generated compile_report.txt. The product of "Active PEs" and "Compute Utilization" is the effective wafer utilization as estimated by the compiler when the application is not I/O bound. Note: these two percentages are rounded to the nearest percent in the compile_report.txt, and e.g. can be displayed as "0%". 

```console
...$ find . -name "compile_report.txt"
./model_dir_unet_base_severstal/cs_d09f2af3bc645aa0f5cc17825cf262f94b426396922df9bd1a249e65bb23d086/compile_report.txt
...$ head -n 7 ./model_dir_unet_base_severstal/cs_d09f2af3bc645aa0f5cc17825cf262f94b426396922df9bd1a249e65bb23d086/compile_report.txt
Estimated Overall Performance
-------------------------------
Samples/s:                    14724.2
Compute Samples/s:            17287.7
Transmission Samples/s:       14724.2
Active PEs:                   62%
Compute Utilization:          52%
...$
```

In this example, the wafer utilization estimate is 32 percent (0.62*0.52).<br>
There is no sharing of the wafer by different jobs, so Cerebras users should strive to maximize their jobs' use of the wafer. <br>
For more details, see the Cerebras documentation: [Compile Report](https://docs.cerebras.net/en/latest/compiler-reports/compile-report.html)<br>
Consider using multiple model replicas if the model is only filling a small part of the wafer. The Cerebras software can make this straightforward; in the best case, simply add(or set) "multireplica: True" to the config yaml.<br>
See
[https://docs.cerebras.net/en/latest/tensorflow-docs/multiple-models/multi-replica-data-parallel-training.html](https://docs.cerebras.net/en/latest/tensorflow-docs/multiple-models/multi-replica-data-parallel-training.html)<br>

[TODO With v 1.1, for the fc_mist example, this has no apparent effect. Determine why, and document.]<br>
<!---[TODO are there other compilation artifacts in the model directory that are worth describing? What about checkpoint files (which need to be delete to rerun tests)?]--->

## Cerebras's guidance on sharding and shuffling datasets
This Cerebras document covers dataset sharding, and how to shuffle datasets.<br>
[https://docs.cerebras.net/en/latest/tensorflow-docs/tuning-tf-for-cs/best-practices-tf.html](https://docs.cerebras.net/en/latest/tensorflow-docs/tuning-tf-for-cs/best-practices-tf.html)

## Cerebras's guidance on the compiler console output
This covers output to the console (and only to the console) during compile.<br>
Search the compile console output for any WARNING lines with the substring "input_fn".<br>
[https://docs.cerebras.net/en/latest/compiler-reports/input-function-report.html](https://docs.cerebras.net/en/latest/compiler-reports/input-function-report.html)

## Cerebra's Input Analyzer
In version 1.2, Cerebras introduces the `cs_input_analyzer` script, which compiles the code, analyses the input pipeline, then suggests a slurm configuration and estimates the input performance. <br>
[https://docs.cerebras.net/en/latest/scripts-and-templates/cs-input-analyzer.html](https://docs.cerebras.net/en/latest/scripts-and-templates/cs-input-analyzer.html)

