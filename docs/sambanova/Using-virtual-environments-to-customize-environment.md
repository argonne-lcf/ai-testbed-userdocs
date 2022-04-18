# Using Virtual Environments to Customize Environment

## Using Virtualenv

To create a virtual environment, one can use the --system-site-packages flag:

```bash
python -m venv --system-site-packages my_env
source my_env/bin/activate
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
