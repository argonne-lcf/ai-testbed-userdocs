# ALCF AI Testbed

ALCF provides an infrastructure for the next-generation of AI-accelerator
machines. 

The AI Testbed aims to help evaluate the usability and performance of machine learning-based high-performance computing applications running on these accelerators. The goal is to better understand how to integrate with existing and upcoming supercomputers at the facility to accelerate science insights.

You can find more information about the available systems on this [link](https://www.alcf.anl.gov/alcf-ai-testbed). Here you can find the documentation on how to use these systems. The
documentation is based on [MkDocs](https://www.mkdocs.org/) and source files are
on [GitHub](https://github.com/argonne-lcf/ai-testbed-userdocs). You can
contribute to the documentation by creating a pull request.


### Git

Using Git ssh. Make sure you add ssh public key to your profile.

Https cloning can be used with a Personal Access Token.

```
$ git clone git@github.com:argonne-lcf/ai-testbed-userdocs.git
```

### Installing Mkdocs

To install `mkdocs` in the current environment: 

```
$ cd ai-testbed-userdocs
$ make install-dev
```

### Preview the Docs Locally

This launches a server.  Do this in a seperate terminal.

Run `mkdocs serve` or `make serve` to auto-build and serve the docs for preview in your web browser.

```
$ make serve
```

### Working on documentation

* All commits must have the commit comment
* Create your own branch from the main branch.  For this writing we are using YOURBRANCH as an example.

```
$ cd ai-testbed-userdocs
$ git fetch --all
$ git checkout main
$ git pull origin main
$ git checkout -b YOURBRANCH
$ git push -u origin YOURBRANCH
```
* Commit your changes to the remote repo
```
$ cd ai-testbed-userdocs
$ git status                         # check the status of the files you have editted
$ git commit -a -m "Updated docs"    # preferably one issue per commit
$ git status                         # should say working tree clean
$ git push origin YOURBRANCH         # push YOURBRANCH to origin
$ git checkout main                  # move to the local main
$ git pull origin main               # pull the remote main to your local machine
$ git checkout YOURBRANCH            # move back to your local branch
$ git merge main                     # merge the local develop into **YOURBRANCH** and
                                     # make sure NO merge conflicts exist
$ git push origin YOURBRANCH         # push the changes from local branch up to your remote branch
```
* Create pull request from https://github.com/argonne-lcf/ai-testbed-userdocs from YOURBRANCH to main branch.
