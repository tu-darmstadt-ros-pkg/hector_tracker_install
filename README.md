# hector_tracker_install
Basic install setup for hector tracker workspace

## Install
A Ubuntu 14.04/AMD64/Indigo setup is supported for this installation. To install ROS, follow the instructions here:
http://wiki.ros.org/indigo/Installation/Ubuntu

Gazebo needs to be  installed if you want to run simulation. If unsure, run
```
sudo apt-get install ros-kinetic-gazebo-ros-control ros-kinetic-gazebo-plugins
```
Make sure you have no other catkin workspace sourced (i.e. `env | grep ROS` should not return anything).
```
git clone -b kinetic-experimental https://github.com/tu-darmstadt-ros-pkg/hector_tracker_install.git
cd hector_tracker_install
./update.sh
```

### Optional Installs

There are some components that can be installed optionally. These are detailed below

#### gazebo_sim_pkgs

For installing all packages required for gazebo-based simulation run:
```
wstool merge optional_installs/gazebo_sim.rosinstall
```


#### icp_mapping

To install ethzasl_icp_mapping, use the corresponding rosinstall file:
```
wstool merge optional_installs/icp_mapping.rosinstall
```

#### GUI

To install GUI packages, use
```
wstool merge optional_installs/gui.rosinstall
```

## Updating and Building

This install script installs dependencies, adds all repos to the workspace and builds the workspace contents. These steps can also be performed separately:
* Workspace update:
```
wstool update
```
* Build:
```
catkin build
```

## Basic Testing

Open new terminal, run a core:
```
roscore
```
Start a simulation scenario
```
roslaunch hector_nist_arena_worlds rc_2016_man5.launch
```
Spawn the robot:
```
roslaunch hector_tracker_sim_launch spawn_tracker_with_ground_truth.launch 
```
