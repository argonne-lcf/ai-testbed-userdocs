# Notes From Habana

Please find attached TF/PT installation scripts extracted from what we shared earlier.
There are 4 scripts here, 2 files have sudo commands and need sudoer to run it after the
system wide installation. The other 2 files are for TF or PT installation inside of
python virtual environment, please run it after entering the virtual environment.

## Commands for sudo scripts

(TF) ./tensorflow_system_installation.sh
(PT) ./pytorch_system_installation.sh

## Commands for virtual environment scripts

(TF) PYTHON=`which python` ./tensorflow_venv_installation.sh --pip_user false
(PT) PYTHON=`which python` ./pytorch_venv_installation.sh -sys
