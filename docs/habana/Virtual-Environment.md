# Virtual Environments to Customize Environment

## Using Virtualenv

To create a virtual environment, one can use the --system-site-packages flag:

```bash
cd ~
python -m venv --system-site-packages my_env
source my_env/bin/activate
```

### Framework Packages

#### TensorFlow

```bash
cd /home/ALCFUserID/path/to/project
PYTHON=`which python` /software/habana/scripts/tensorflow_venv_installation.sh --pip_user false
source ~/.bashrc
source ~/my_env/bin/activate
```

#### PyTorch

Try without any additional steps.

### System Site Packages

There are many packages available on the system.
Run the following Python script to retrieve the
location of the packages:

```python
import sys
site_packages = next(p for p in sys.path if 'dist-packages' in p)
print(site_packages)
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

Note: Conda is not supported on this system.
