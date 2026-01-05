FROM osrf/ros:humble-desktop

# Install Gazebo + ROS tools
RUN apt-get update && apt-get install -y \
    ros-humble-gazebo-ros-pkgs \
    ros-humble-gazebo-ros2-control \
    ros-humble-ros2-control \
    ros-humble-ros2-controllers \
    ros-humble-xacro \
    python3-colcon-common-extensions \
		vim

# Create workspace
COPY ./leg3dof_ws /leg3dof_ws
WORKDIR /leg3dof_ws

# Source ROS automatically
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

CMD ["bash"]

