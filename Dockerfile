FROM ros:melodic-perception-bionic

ENV CATKIN_WS /root/catkin_ws

RUN apt-get update \
    && \
    apt-get install -y \
      sudo \
      gdb \
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
      ros-$ROS_DISTRO-rviz \
      openssh-client \
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

RUN pip3 install --no-cache-dir -r $CATKIN_WS/src/gazebo-room-with-furniture/models/ikea_models/pip-requirements.txt

RUN echo '#!/bin/bash \n\
source $CATKIN_WS/devel/setup.bash \n\
source $CATKIN_WS/src/gazebo-room-with-furniture/setup.bash \n\
echo "Checking for dirs" 1>&2; \n\
[ -d "$IKEA_MESHES_DIR" ] || { echo "Need IKEA_MESHES_DIR" 1>&2 && false; }\n\
[ -d "$IG_LEARNING_DATA_DIR" ] || { echo "Need IG_LEARNING_DATA_DIR" 1>&2 && false; } \n\
cd $CATKIN_WS/src/gazebo-room-with-furniture/models/ikea_models \n\
rm -f meshes \n\
ln -s $IKEA_MESHES_DIR meshes \n\
echo "Creating meshes" 1>&2; \n\
cd $CATKIN_WS/src/gazebo-room-with-furniture/models/ && python3 ikea_models/create_models.py && cd -\n\
echo "Running cmd" "$@" 1>&2; \n\
exec "$@" \n\
echo "Done cmd" "$@" 1>&2; \n\
' > /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR $CATKIN_WS
ENTRYPOINT ["/entrypoint.sh"]
CMD ["roslaunch", "ig_learning_experiments", "example_aggrevate.launch"]

