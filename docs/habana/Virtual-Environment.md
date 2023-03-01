# Virtual Environments to Customize Environment

## Using Virtualenv

### Framework Packages

**NOTE: The [Example Programs](Example-Programs.md) use PyTorch.**

#### TensorFlow

To create a virtual environment:

```bash
export VENV_DIR=~/venvs/habana_1.8.0
mkdir -p ${VENV_DIR}/tf
cd ${VENV_DIR}/tf
HABANALABS_VIRTUAL_DIR=${VENV_DIR}/tf /projects/Habana/habanalabs-installer-1.8.0.sh install --type tf --venv
source ${VENV_DIR}/tf/bin/activate
```

#### PyTorch

To create a virtual environment, one uses the **--system-site-packages** flag:

```bash
python3 -m venv --system-site-packages ~/PT_venv
source ~/PT_venv/bin/activate
```

### System Site Packages

There are many packages available on the system.
Run the following Python script to retrieve the
location of the packages:

```console
python
import sys
site_packages_dir = next(p for p in sys.path if 'dist-packages' in p)
print(site_packages_dir)
```

Given the location of the packages, one may list the packages.
For example:

```bash
ls -al /usr/local/lib/python3.8/dist-packages
```

## Installing Packages

Install packages in the normal manner such as:

```bash
python3 -m pip install "SomeProject"
```

For more details see [Use pip for installing](https://packaging.python.org/en/latest/tutorials/installing-packages/#use-pip-for-installing).

To install a different version of a package that is already installed in one's environment, one can use:

```bash
pip install --ignore-installed  ... # or -I
```

**Note: Conda is not supported on this system.**
