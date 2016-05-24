# hector_tracker_install
Basic install setup for hector tracker workspace

## Install
Gazebo needs to be  installed. If unsure, run
```
sudo apt-get install ros-indigo-gazebo-ros-control ros-indigo-gazebo-plugins
```
Make sure you have no other catkin workspace sourced (i.e. `env | grep ROS` should not return anything).
```
git clone https://github.com/tu-darmstadt-ros-pkg/hector_tracker_install.git
cd hector_tracker_install
./update.sh
```

### Optional Installs

There are some components that can be installed optionally. These are detailed below


#### icp_mapping

To install ethzasl_icp_mapping, use the corresponding rosinstall file:
```
wstool merge icp_mapping.rosinstall
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
