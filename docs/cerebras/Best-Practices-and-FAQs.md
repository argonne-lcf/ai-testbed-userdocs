# Best Practices and FAQs 

## Sharding and shuffling datasets
This Cerebras doc covers sharding and shuffling datasets.<br>
[https://docs.cerebras.net/en/latest/tensorflow-docs/tuning-tf-for-cs/best-practices-tf.html](https://docs.cerebras.net/en/latest/tensorflow-docs/tuning-tf-for-cs/best-practices-tf.html)

## Guidance in the compiler console output
This Cerebras doc covers output to the console (and only to the console) during compile.<br>
Search the compile console output for any WARNING lines with the substring "input_fn".<br>
[https://docs.cerebras.net/en/latest/compiler-reports/input-function-report.html](https://docs.cerebras.net/en/latest/compiler-reports/input-function-report.html)

## The Cerebras 1.2 cs_input_analyzer
Cerebras 1.2 introduces the "cs_input_analyzer" script, which compiles the code, analyses the input pipeline, then suggests a slurm configuration and estimates the input performance. [TODO determine if this script works with v 1.1)
[https://docs.cerebras.net/en/latest/scripts-and-templates/cs-input-analyzer.html](https://docs.cerebras.net/en/latest/scripts-and-templates/cs-input-analyzer.html)

