Cerebras
========

### How to setup your base environment
[Is there anything to do here for Cerebras?]<br>
[Maybe add a zero or two to the default HISTSIZE and HISTFILESIZE in .bashrc?]<br>
.bashrc:HISTSIZE=1000000<br>
.bashrc:HISTFILESIZE=2000000<br>

##### Making permissions user-only except for a transfer directory
[TODO is this required? The vendors will have access, and probably shouldn't see ports to other vendors systems. If required, it only needs to be done once, and some users may have already done this or similar.]<br>
To make permissions all user-only (tested on Ubuntu 18.04 and centos 7):<br>
Edit ~/.profile and add a new line with:<br>
```umask 077```<br>
Log out and back in again. Then: 
<table>
<tbody>
<tr class="odd">
<td>
<strong>
cd ~<br>
chmod -R o=,g= ~<br>
mkdir transfer<br>
chmod a+rxw transfer/<br>
chmod a+xr .<br>
</strong>
</td>
</tr>
</tbody>
</table>
