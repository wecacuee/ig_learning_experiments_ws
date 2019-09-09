FROM ros:melodic-perception-bionic

ENV CATKIN_WS /root/catkin_ws

RUN apt-get update \
    && \
    apt-get install -y \
      sudo \
      libboost-all-dev \
      libeigen3-dev \
      libpcl-dev \
      python3-pip \
      python3-virtualenv \
      python-catkin-tools \
      python-wstool \
      ros-$ROS_DISTRO-angles \
      ros-$ROS_DISTRO-gazebo-ros-control \
      ros-$ROS_DISTRO-gazebo-ros-pkgs \
      ros-$ROS_DISTRO-octomap \
      ros-$ROS_DISTRO-pcl-ros  \
      ros-$ROS_DISTRO-stereo-image-proc \
      ros-$ROS_DISTRO-tf \
      ros-$ROS_DISTRO-tf-conversions \
      ros-$ROS_DISTRO-xacro \
      openssh-client \
      openssh-server \
    && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir ~/.ssh && echo "StrictHostKeyChecking no " > ~/.ssh/config
RUN mkdir -p $CATKIN_WS/src && \
    cd $CATKIN_WS/src && \
    git clone --recursive https://bitbucket.org/sanjiban/ig_learning_experiments.git && \
    git clone --recursive https://bitbucket.org/sanjiban/ig_learning.git && \
    git clone --recursive --branch fix-octomap-1.7-to-1.8 https://github.com/wecacuee/rpg_ig_active_reconstruction.git && \
    git clone --recursive https://bitbucket.org/castacks/alglib.git && \
    git clone --recursive https://github.com/wecacuee/gazebo-room-with-furniture.git

ENV PYTHONIOENCODING UTF-8
RUN cd $CATKIN_WS && \
    catkin config --init --mkdirs --extend /opt/ros/$ROS_DISTRO && \
    catkin build

CMD [/usr/sbin/sshd -D]

