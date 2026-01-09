# About

This directory is used to launch and use ROS2 in a Docker container.

Dockerfile makes the docker ready by copying the current directory contents into the docker workspace.

Justfile is used to simplify the cli usage, but is not mandatory and can be bypassed.

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
