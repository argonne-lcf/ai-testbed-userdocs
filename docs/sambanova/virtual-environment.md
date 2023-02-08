# Virtual Environments for Custom Packages

## Using a Virtual Venv

To create a virtual environment, one can use the --system-site-packages flag:

```bash
mkdir -p ~/venvs/sambanova/
python -m venv --system-site-packages ~/venvs/sambanova/my_env
source ~/venvs/sambanova/my_env/bin/activate
```

Note: Each SambaNova application sample already include its own python virtual environment, which can be activated to compile and run the sample.
See the [Example Programs](Example-Programs.md) for more information.

### System Site Packages

There are many packages available on the system.
Run the following Python script to retrieve the
location of the packages:

```python
import sys
site_packages = next(p for p in sys.path if 'site-packages' in p)
print(site_packages)
```

Given the location of the packages, one may list the packages.
For example:

```bash
ls -al ~/venvs/sambanova/my_env/lib/python3.7/site-packages
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

Note: Conda is not supported on the SambaNova system.
