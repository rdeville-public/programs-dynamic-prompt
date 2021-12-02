# Direnv

!!! abstract
    This tutorial will succinctly present you `direnv` and how to use it for this
    repo.

## Presentation

[direnv](https://direnv.net/) is a usefull tool that will allow you to automate
loading of variable environment and even virtual environment for when entering
specific directories.

For instance, if you are working with python virtual environment, usually you
will have to go to the folder, then you will need to manually activate the
virtual environment to be able to use your python program.

Or if you are using OpenStack and you open/close terminal on the fly, you will
often need to source your `openrc.sh` file, which can be boring.

Well, `direnv` will allow you to describe a set of action in a specific `.envrc`
file which is a bash script that will be executed as soon as you enter a folder
which have this `.envrc` file.

For instance, I almost never type these following commands as they are executed
when I enter my working directory:

```bash
  $ pipenv install
  $ pipenv shell
  $ source openrc.sh
  $ export SOME_VARIABLE_NEEDED_BY_MY_PROJECT=value
```

## Installation

Please refer to the
[direnv documentation](https://direnv.net/docs/installation.html) that explain
you how to setup direnv depending on your platform.

## Configuration

Once the installation is done, you can setup your `.envrc` file for this repo.
For this repo, you may want to automatically load the python virtualenv to be
able to render the documentation and automatically set the variables `DEBUG_MODE`
and `DEBUG_LEVEL`

To do so, you simply have to put the following content in a file called `.envrc`
at the root the repo:

```bash
#!/bin/bash

# Automatically load python virtual environment
layout_pipenv
# Activate all segments
export DEBUG_MODE=1
# Set debug level to print time.
export DEBUG_LEVEL=1

#*******************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
#*******************************************************************************
```

Normally, after this command, you will have this line that will be prompt after
each command you type while in the repo :

```bash
direnv: error .envrc is blocked. Run `direnv allow` to approve its content.
```

This is normal, `direnv` come with a protection mechanism to forbid execution of
not authorized `.envrc` file. Indeed, assume you clone a repo with a `.envrc`
file which content is only one line `rm -rf ${HOME}`. If the protection
mechanism was not there, as soon as you enter this cloned repo, your entire home
directory will be deleted.

Once allowed, now each time you will enter the repo, it will automatically
activate the python virtual environment and set the variables.

## Integration with segments of dynamic prompt

Some segments, like `openstack` or `kube` rely on the existence of some
environment variable such as `OS_PROJECT_NAME` or `KUBE_ENV`. The setting of
this variable can be automate with direnv. For instance, if you do not want to
source you `openrc.sh` for openstack each times you enter, the content of your
`.envrc` can be:

```bash
#!/bin/bash

# OPENSTACK VARIABLES
# -----------------------------------------------------------------------------
# Automatically load Openstack variable. You can find them in your openrc.sh
# file.
export OS_AUTH_URL="<OPENSTACK_URL>"
export OS_USER_DOMAIN_NAME="<OPENSTACK_DOMAIN_NAME>"
if [ -z "$OS_USER_DOMAIN_NAME" ]; then unset OS_USER_DOMAIN_NAME; fi
export OS_PROJECT_DOMAIN_ID="<OPENSTACK_PROJECT_ID>"
if [ -z "$OS_PROJECT_DOMAIN_ID" ]; then unset OS_PROJECT_DOMAIN_ID; fi
unset OS_TENANT_ID
unset OS_TENANT_NAME
export OS_USERNAME=$(cmd to access to the OS_USERNAME)
# If command to access to OS_PASSWORD return 0
if $(cmd to access OS_PASSWORD > /dev/null 2>&1)
then
  export OS_PASSWORD=$(cmd to access of OS_PASSWORD)
else
  echo -e "${E_ERROR}[ERROR] No OS_PASSWORD LOADED${E_NORMAL}" >&2
fi
export OS_REGION_NAME="<OPENSTACK_REGION_NAME>"
if [ -z "$OS_REGION_NAME" ]; then unset OS_REGION_NAME; fi
export OS_INTERFACE="<OPENSTACK_INTERFACE>"
export OS_IDENTITY_API_VERSION=3
export OS_PROJECT_ID="<THE_HASH_OF_PROJECT>"

#*******************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
#*******************************************************************************
```

As you can see it is a "simple" bash script. First usefull lines are the
following:

The the file is mainly exporting variables that come from `openrc.sh`, ask user
what openstack project to use and setup export variables depending on project
use. Content you will have to change are between `<>`, like
`<OPENSTACK_PROJECT_ID>`. If you do not need some part of the file, you can
simply delete them.

Last but not least, you may remark some variable set like this:

```bash
export OS_PASSWORD=$(cmd to access of OS_PASSWORD)
```

This mean that the variable OS_PASSWORD will be set to the output value print on
stdout by `cmd to access of OS_PASSWORD`. For instance, I use a script called
`keepass` that allow me to manage my `keepass` database from the command line.
Thus my `export OS_PASSWORD` line look like this :

```bash
export OS_PASSWORD=$(keepass show PRO/openstack_pagoda)
```

This ensure that my password are not written in clear text in this file, thus
protect myself if I somehow ended to version my `.envrc` file.

If you do not use password manager with command line, you can for instance
write your password in a file, let say `~/.private/password/openstack_password`,
set the folder `~/.private/password` permission to ensure noboby have access to
this folder except you :

```bash
  $ chmod -R 0600 ~/.private/password
```

Now, you can call the content of this file in the OS_PASSWORD like this :

```bash
export OS_PASSWORD=$(cat ~/.private/password/openstack_password
```

**OF COURSE, THIS MEANS THAT YOU LOCK YOUR COMPUTER, OTHERWISE IT MAY LEAK YOUR
PASSWORD !!!**

Finally, once you have done, you can activate your `.envrc` file by typing the
following command :

```bash
  $ direnv allow
```

**REMARK**: To avoid needed to type `direnv allow` each time you modify your
`.envrc`, you can edit it using `direnv edit`, this will open the file `.envrc`
in your favorite terminal text editor. Once edition is finished, this will
automatically allow the modified `.envrc`.

And you are done ! Now, each time you will enter this repo, `direnv` will
automatically load your pipenv virtual environment, may ask you which openstack
project to use and export needed variables.

You will be notify by a line like this when entering a `direnv` managed folder :

```bash
direnv: export +ANSIBLE_CONFIG +OS_AUTH_URL +OS_IDENTITY_API_VERSION +OS_INTERFACE +OS_PASSWORD +OS_PROJECT_DOMAIN_ID +OS_PROJECT_ID +OS_PROJECT_NAME +OS_REGION_NAME +OS_USERNAME +OS_USER_DOMAIN_NAME +PIPENV_ACTIVE +TEST_GITLAB_API_TOKEN +VIRTUAL_ENV ~PATH
```

## Nested direnv folder

Sometimes you may want to export some variable in a folder, then export these
variable in a subfolder among others more.

This can easily be done with direnv by adding the following line in your
`.envrc`:

```bash
source_up
```

As `source_up`, direnv provide some other function to allow you to better fine
tune your folder environment management. See [this
manual](https://direnv.net/man/direnv-stdlib.1.html) for more information.

If you want to go further, you can check [the direnv community
Wiki](https://github.com/direnv/direnv/wiki).
