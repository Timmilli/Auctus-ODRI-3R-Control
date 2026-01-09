# About

This directory is used to launch and use ROS2 in a Docker container.

Dockerfile makes the docker ready by copying the current directory contents into the docker workspace.

Justfile is used to simplify the cli usage, but is not mandatory and can be bypassed.

# Docker and GitHub submodules

The Docker expects that the current directory has the GitHub repositories that will be used (and copied) in the Docker.
It doesn't install or download any repo by itself.

The basic repositories used in such a Docker are:
- open-dynamic-robot-initiative/master-board
- open-dynamic-robot-initiative/odri_control_interface
- open-dynamic-robot-initiative/example-robot-data
They can all be installed by cloning this repo with the `--recurse-submodules` option.
If the repository is already cloned, then:
```bash
git submodule init
```

# Commands

The commands are proposed supposedly that Justfile is used. Otherwise, refer to its content.

To build and run the container:
```bash
just
```

To build the container:
```bash
just build
```

To run the container:
```bash
just run
```
