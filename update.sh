#!/bin/bash

source /opt/ros/indigo/setup.bash

git pull

# This should be extended to first check if everything is installed and only do the sudo requiring call when there's anything missing.
echo "Installing needed packages (both ROS package and system dependency .deb packages) ..."

#---------------------
# Below adds the PPA required for eth grid map
# Approach taken from http://askubuntu.com/questions/381152/how-to-check-if-ppa-is-already-added-to-apt-sources-list-in-a-bash-script

the_ppa=ethz-asl/common  # set appropriately

if ! grep -q "$the_ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
  echo ""
  echo "---------------------------------------------------------------------"
  echo " PPA ppa:ethz-asl/common not detected, adding to sources."
  echo " Please press Enter (confirm) when asked if you want to add the PPA"
  echo "---------------------------------------------------------------------"

  # commands to add the ppa ...
  sudo add-apt-repository ppa:ethz-asl/common
  sudo apt-get update
fi


PACKAGES_TO_INSTALL="\
mercurial \
git \
python-rosdep \
python-wstool \
python-catkin-tools \
libnlopt-dev \
ros-$ROS_DISTRO-desktop \
ros-$ROS_DISTRO-moveit-ros \
ros-$ROS_DISTRO-moveit-simple-controller-manager \
ros-$ROS_DISTRO-moveit-setup-assistant \
ros-$ROS_DISTRO-moveit-commander \
ros-$ROS_DISTRO-moveit-planners-ompl \
ros-$ROS_DISTRO-nav-core \
ros-$ROS_DISTRO-base-local-planner \
ros-$ROS_DISTRO-hector-marker-drawing \
ros-$ROS_DISTRO-hector-slam \
ros-$ROS_DISTRO-hector-geotiff \
ros-$ROS_DISTRO-hector-nav-msgs \
ros-$ROS_DISTRO-hector-map-tools \
ros-$ROS_DISTRO-hector-marker-drawing \
ros-$ROS_DISTRO-message-to-tf \
ros-$ROS_DISTRO-driver-base \
ros-$ROS_DISTRO-laser-filters \
ros-$ROS_DISTRO-image-proc \
ros-$ROS_DISTRO-image-transport-plugins \
ros-$ROS_DISTRO-depth-image-proc \
ros-$ROS_DISTRO-ros-control \
ros-$ROS_DISTRO-ros-controllers \
ros-$ROS_DISTRO-effort-controllers \
ros-$ROS_DISTRO-joint-trajectory-controller \
ros-$ROS_DISTRO-joint-state-controller \
ros-$ROS_DISTRO-perception-pcl
ros-$ROS_DISTRO-map-server \
ros-$ROS_DISTRO-amcl \
ros-$ROS_DISTRO-sbpl \
ros-$ROS_DISTRO-perception-pcl \
ros-$ROS_DISTRO-pointcloud-to-laserscan \
ros-$ROS_DISTRO-joy \
ros-$ROS_DISTRO-um7 \
ros-$ROS_DISTRO-teleop-twist-joy \
ros-$ROS_DISTRO-costmap-2d \
ros-$ROS_DISTRO-octomap \
ros-$ROS_DISTRO-octomap-msgs \
ros-$ROS_DISTRO-octomap-ros \
ros-$ROS_DISTRO-move-base-msgs \
ros-$ROS_DISTRO-hector-worldmodel-msgs \
ros-$ROS_DISTRO-rqt-joint-trajectory-controller \
ros-$ROS_DISTRO-rqt-robot-steering \
ros-$ROS_DISTRO-robot-localization \
ros-$ROS_DISTRO-serial \
ros-$ROS_DISTRO-urg-node \
ros-$ROS_DISTRO-dynamixel-driver \
ros-$ROS_DISTRO-dynamixel-msgs \
ros-$ROS_DISTRO-dynamixel-controllers \
schweizer-messer-common-dev \
schweizer-messer-timing-dev"

dpkg -s $PACKAGES_TO_INSTALL 2>/dev/null >/dev/null || sudo apt-get -y install $PACKAGES_TO_INSTALL


if ! [ -e "./.rosinstall" ]; then
  wstool init
fi

wstool merge default_packages.rosinstall 

wstool update

# We build using catkin_tools per default
#catkin_make_isolated -DCMAKE_BUILD_TYPE=Release
catkin build -DCMAKE_BUILD_TYPE=Release


PWD=$(pwd)

# Initialization done, print info
cat <<EOF

===================================================================
Workspace initialization completed.
You can setup your current shell's environment to use the workpace
by entering

    source ${PWD}/devel/setup.bash

or by adding this command to your .bashrc file for automatic setup on
each invocation of an interactive shell:

    echo "source ${PWD}/devel/setup.bash" >> ~/.bashrc

You can also modify your workspace config (e.g. for adding additional
repositories or packages) using the wstool command.
===================================================================

EOF