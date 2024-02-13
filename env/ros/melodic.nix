
{ pkgs ? import ../. {} }:
with pkgs;
with rosPackages.melodic;
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
