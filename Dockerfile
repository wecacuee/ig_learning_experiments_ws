FROM ros:kinetic-ros-core-xenial

ENV CATKIN_WS /root/catkin_ws

RUN apt-get update \
    && \
    apt-get install -y \
      libboost-all-dev \
      libeigen3-dev \
      libpcl-dev \
      python-catkin-tools \
      ros-kinetic-angles \
      ros-kinetic-gazebo-ros-control \
      ros-kinetic-gazebo-ros-pkgs \
      ros-kinetic-octomap \
      ros-kinetic-pcl-ros  \
      ros-kinetic-stereo-image-proc \
      ros-kinetic-tf \
      ros-kinetic-tf-conversions \
    && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir $CATKIN_WS && cd $CATKIN_WS && \
    catkin config --init --mkdirs --extend /opt/ros/kinetic && \
    rosdep install -y -a

