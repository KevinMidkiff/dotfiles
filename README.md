Dotfiles
========

This repository contains various configuration files.

## Installation

The `install.sh` script is the main entrypoint into installing the applications
and various configurations for those applications.

To install all expected packages for Ubuntu and the configuration for those
applications execute the following command:

```sh
./install.sh -p ubuntu -c all
```

In the command above, the `-p ubuntu` specifies to install the packages for the
Ubuntu platform and the `-c all` tells the installer to install the
configuration for all supported applications.

See the [`configs`](./configs/) directory for supported applications. Note
that not all the folders in there have something to install. They will only
install the configuration if the directory contains an `install.sh` script.

To install the configuration any individual application execute the `install.sh`
script as follows: `./install.sh -c <package>`. For example:

```sh
# Installs only the configuration for ZSH
./install.sh -c zsh
```

## `install.sh` Usage

```
usage: ./install.sh [-h] [-c <package> -c ...] [-p <platform>]
        -h               - Show this help
        -c <package>     - Install configuration for the specified package
        -p <platform>    - Install expected applications for the platform
```

See the [`packages`](./packages/) directory and [`configs`](./configs/)
directory to see all supported platforms and applications.
