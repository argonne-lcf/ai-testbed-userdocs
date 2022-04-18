Cerebras
========

### Performance Tools
Covers how to profile and get performance data

##### Compile Report
After a compile, see the generated compile_report.txt. The product of "Active PEs" and "Compute Utilization" is the effective wafer utilization as estimated by the compiler when the application is not I/O bound. [TODO verify this]

<table>
<tbody>
<tr class="odd">
<td>
<strong>
...$ find . -name "compile_report.txt"<br>
./model_dir_unet_base_severstal/cs_d09f2af3bc645aa0f5cc17825cf262f94b426396922df9bd1a249e65bb23d086/compile_report.txt<br>
...$ head -n 7 ./model_dir_unet_base_severstal/cs_d09f2af3bc645aa0f5cc17825cf262f94b426396922df9bd1a249e65bb23d086/compile_report.txt<br>
Estimated Overall Performance<br>
-------------------------------<br>
Samples/s:                    14724.2<br>
Compute Samples/s:            17287.7<br>
Transmission Samples/s:       14724.2<br>
Active PEs:                   62%<br>
Compute Utilization:          52%<br>
...$<br>
</strong>
</td>
</tr>
</tbody>
</table>

In this example, the wafer utilization estimate is 32 percent (0.62*0.52).<br>
There is no sharing of the wafer by different jobs, so each job should strive to maximize its use of the wafer. <br>
Consider using multiple model replicas if the model is only filling a small part of the wafer. The Cerebras software makes this straightforward; in the best case, simply add(or set) "multireplica: True" to the config yaml.<br>
See https://docs.cerebras.net/en/latest/tensorflow-docs/multiple-models/multi-replica-data-parallel-training.html<br>
[TODO for the fc_mist example, this has no apparent effect. Confirm that it works.]
[TODO are there other compilation artifacts in the model directory that are worth describing? What about checkpoint files (which need to be delete to rerun tests)?]



