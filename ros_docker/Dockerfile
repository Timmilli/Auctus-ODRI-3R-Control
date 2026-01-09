FROM osrf/ros:humble-desktop

# Install Gazebo + ROS tools
RUN apt-get update && apt-get install -y \
    ros-humble-gazebo-ros-pkgs \
    ros-humble-gazebo-ros2-control \
    ros-humble-ros2-control \
    ros-humble-ros2-controllers \
    ros-humble-xacro \
    python3-colcon-common-extensions \
    vim \
    net-tools \
    git \
    wget \
    gperf \
    python3 \
    python3-pip \
    python3-setuptools \
    cmake \
    ccache \
    libffi-dev \
    libssl-dev \
    dfu-util 

RUN update-alternatives --install /usr/local/bin/python python /usr/bin/python3 10

# Create workspace
WORKDIR /odri
COPY . /odri/

# Source ROS automatically
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

CMD ["bash"]


