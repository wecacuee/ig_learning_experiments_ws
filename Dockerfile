FROM ros:kinetic-ros-core-xenial

ENV CATKIN_WS /root/catkin_ws

RUN apt-get update \
    && \
    apt-get install -y \
      libboost-all-dev \
      libeigen3-dev \
      libpcl-dev \
      python-catkin-tools \
      python-wstool \
      ros-kinetic-angles \
      ros-kinetic-gazebo-ros-control \
      ros-kinetic-gazebo-ros-pkgs \
      ros-kinetic-octomap \
      ros-kinetic-pcl-ros  \
      ros-kinetic-stereo-image-proc \
      ros-kinetic-tf \
      ros-kinetic-tf-conversions \
      ros-kinetic-xacro \
      openssh-client \
    && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir ~/.ssh && echo "StrictHostKeyChecking no " > ~/.ssh/config
RUN mkdir -p $CATKIN_WS/src && \
    cd $CATKIN_WS/src && \
    git clone --recursive https://bitbucket.org/sanjiban/ig_learning_experiments.git && \
    git clone --recursive https://bitbucket.org/sanjiban/ig_learning.git && \
    git clone --recursive --branch fix-octomap-1.7-to-1.8 https://github.com/wecacuee/rpg_ig_active_reconstruction.git && \
    git clone --recursive https://bitbucket.org/castacks/alglib.git

ENV PYTHONIOENCODING UTF-8
RUN cd $CATKIN_WS && \
    catkin config --init --mkdirs --extend /opt/ros/kinetic && \
    catkin build

