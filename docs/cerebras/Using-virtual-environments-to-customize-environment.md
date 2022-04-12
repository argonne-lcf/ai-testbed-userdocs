Cerebras
========

### Using virtual environments to customize environment
It is considered good practice to create a python virtual environment for python projects with dependencies not satisfied by the base environment.
This prevents dependency conflicts between projects.

<table>
<tbody>
<tr class="odd">
<td><strong>
python3 -m venv ~/testp3env<br>
source ~/testp3env/bin/activate<br>
pip install --upgrade pip<br>
pip install wget<br>
# to exit the virtual env:<br>
deactivate<br>
</strong></td>
</tr>
</tbody>
</table>

To use this virtual env, e.g. in a script started with csrun_wse or csrun_cpu, or in a singularity shell:
<table>
<tbody>
<tr class="odd">
<td><strong>
source testp3env/bin/activate
</strong></td>
</tr>
</tbody>
</table>


