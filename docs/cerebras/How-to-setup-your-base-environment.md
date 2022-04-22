# How to setup your base environment

```bash
After sshing to the CS-02 chief node,
source /software/cerebras/cs2-02/envs/cs_env.sh<br>
```

No other steps are required.

<!---
## Optionally configure history size
[TODO Assess whether ALCF default HISTSIZE and HISTFILESIZE is sufficient for new users. If not, suggest adding a zero or two or three to these lines in .bashrc:<br>
.bashrc:HISTSIZE=1000000<br>
.bashrc:HISTFILESIZE=2000000<br>]
--->

<!---
## Making permissions user-only except for a transfer directory
[TODO this or equivalent will be taken care of for new users. The various vendors will have access, and probably shouldn't see ports to other vendors systems or application logs/exceptions. If required as a manual step, it only needs to be done once, and some users may have already done this or similar.]<br>
[TODO there will definitely need to be a way to share possibly-large files with vendors.]<br>

To make permissions all user-only (tested on Ubuntu 18.04 and centos 7):<br>
Edit ~/.profile and add a new line with:<br>
```umask 077```
Log out and back in again. Then: 
```bash
cd ~
chmod -R o=,g= ~
mkdir transfer
chmod a+rxw transfer/
chmod a+xr .
```
--->
