### Using virtual python environments to customize environment
It is considered good practice to create and use a python virtual environment for python projects with dependencies not satisfied by the base environment.
This prevents dependency conflicts between projects.

<table>
<tbody>
<tr class="odd">
<td><strong>
python3 -m venv ~/testp3env<br>
source ~/testp3env/bin/activate<br>
pip install --upgrade pip<br>
# sample pip install<br>
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

### Customizing the Cerebras singularity container
See this section of the Cerebras documentation:
[Adding Custom Packages To cbcore Container](https://docs.cerebras.net/en/latest/software-guides/adding-custom-pkgs-to-cbcore-container.html)
