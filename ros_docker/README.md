# About

This directory is used to launch and use ROS2 in a Docker container.

Dockerfile build a simple docker ready to use.

Justfile is used to simplify the cli usage, but is not mandatory and can be bypassed.

# Docker and GitHub submodules

The Docker doesn't copy anything from the current directory. Instead, GitHub repos need to be cloned inside the Docker directly.

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
