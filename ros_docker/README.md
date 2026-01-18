# About

Builds the `leg12dof:gpu` image to compile files of the ODRI project with all
required dependencies.
A Justfile is used to simplify the cli usage, but is not mandatory and can be skipped.

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

The Justfile is configured to mount the `data_collection/` directory with a
relative path (from the current directory you are in). Enter the container with
```bash
just run
```
Note that the Justfile is configured to remove the container after each run
(`--rm` option)

Inside the container, remember to source the workspace created by colcon to have
the Python3 package it built.

```bash
. install/setup.bash
```

Note that building inside the container still allows you to run the C++ executables
outside of it (containers use your hardware for compilation). The Python scripts
as well, as long as you performed the step mentioned earlier in your terminal.
