# Run:
# roslaunch turtlebot3_gazebo turtlebot3_world.launch
# roslaunch turtlebot3_teleop turtlebot3_teleop_key.launch

{ pkgs ? import ../. {} }:
with pkgs;
with rosPackages.noetic;
with pythonPackages;

mkShell {
  buildInputs = [
    glibcLocales
    (buildEnv { paths = [
      rosbash
      rviz
      xacro
    ]; })
  ];

  ROS_HOSTNAME = "localhost";
  ROS_MASTER_URI = "http://localhost:11311";
}
