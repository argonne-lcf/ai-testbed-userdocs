### Best Practices and FAQs ( We can link here to the vendor docs as well)

This covers sharding and shuffling datasets.<br>
https://docs.cerebras.net/en/latest/tensorflow-docs/tuning-tf-for-cs/best-practices-tf.html

This covers output to the console (and only to the console) during compile.<br>
Search the compile console output for any lines with the substring "input_fn".<br>
https://docs.cerebras.net/en/latest/compiler-reports/input-function-report.html

and more advanced (but 1.2 only?) introduces the "cs_input_analyzer" script, which compiles the code, analyses the input pipeline, then suggests a slurm configuration and estimates the input performance. 
https://docs.cerebras.net/en/latest/scripts-and-templates/cs-input-analyzer.html
