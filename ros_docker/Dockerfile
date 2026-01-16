FROM ubuntu:22.04

RUN apt update && apt install -y curl python-is-python3 python3-pip cmake zip git \
	autoconf autoconf-archive automake libtool vim pkg-config catch2 \
        libboost-all-dev libyaml-cpp-dev

# install colcon
RUN python3 -m pip install -U colcon-common-extensions

# install eigenpy
RUN curl http://robotpkg.openrobots.org/packages/debian/robotpkg.asc | tee /etc/apt/keyrings/robotpkg.asc
RUN tee /etc/apt/sources.list.d/robotpkg.list <<EOF
deb [arch=amd64 signed-by=/etc/apt/keyrings/robotpkg.asc] http://robotpkg.openrobots.org/packages/debian/pub jammy robotpkg
EOF
RUN apt-get update && apt-get install -y robotpkg-py310-eigenpy

ENV CMAKE_PREFIX_PATH=/opt/openrobots
ENV LD_LIBRARY_PATH=/opt/openrobots/lib
ENV PYTHONPATH=/opt/openrobots/lib/python3.10/site-packages

WORKDIR /odri/data_collection
RUN colcon build
