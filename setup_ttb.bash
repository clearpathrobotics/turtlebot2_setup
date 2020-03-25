#!/bin/bash
# DESCRIPTION       Installs & configures ROS for the Turtlebot
#                   Intended to be run after installing Ubuntu on the target computer
#
# AUTHOR            Dave Niewinski <dniewinski@clearpathrobotics.com>
#                   Chris Iverach-Brereton <civerachb@clearpathrobotics.com>
#
# USAGE             bash setup_ttb.bash
#
# NOTE              This script must _not_ be run as root as it modifies files in the user's home folder

# check that we are _not_ running as root
# running this script as root is _very_ bad and will break things
if [[ $EUID -eq 0 ]]; then
   echo "This script must not be run as root" 
   exit 1
fi

# ensure all updates are applied before continuing!
sudo apt-get update
sudo apt-get -y upgrade

# enable debian kernel sources
wget -O enable_kernel_sources.sh http://bit.ly/en_krnl_src
bash ./enable_kernel_sources.sh
rm enable_kernel_sources.sh

# add Intel's RealSense repository; otherwise we get problems installing librealsense
# see: https://github.com/IntelRealSense/librealsense/blob/master/doc/distribution_linux.md#installing-the-packages
sudo apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
sudo add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main" -u

# re-update apt since we've just added sources!
sudo apt-get update

# install some super-useful extra packages
sudo apt-get install -y nano bash-completion

# install the realsense kernel modules, utils & dev files
sudo apt-get install -y librealsense2-dkms librealsense2-utils librealsense2-dev

# install the core turtlebot system + dependencies
sudo apt-get install -y ros-kinetic-turtlebot ros-kinetic-turtlebot-msgs ros-kinetic-turtlebot-apps ros-kinetic-turtlebot-interactions ros-kinetic-turtlebot-simulator ros-kinetic-kobuki ros-kinetic-kobuki-msgs ros-kinetic-yujin-ocs ros-kinetic-astra-*

# set up the udev rules for the Orbbec Astra family of cameras
wget https://raw.githubusercontent.com/clearpathrobotics/turtlebot2_setup/master/56-orbbec-usb.rules
sudo mv 56-orbbec-usb.rules /etc/udev/rules.d/

# change the current user's wallpaper
wget https://github.com/TurtleBot-Mfg/turtlebot-wallpapers/raw/master/root/usr/share/backgrounds/TurtleBot_Lite_by_IHE.jpg -O //home/turtlebot/Pictures/TurtleBot_Lite_by_IHE.jpg
gsettings set org.gnome.desktop.background picture-uri file:///home/turtlebot/Pictures/TurtleBot_Lite_by_IHE.jpg

# modify bashrc to load ROS automatically & use the Astra camera
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
echo "export TURTLEBOT_3D_SENSOR=astra" >> ~/.bashrc
source ~/.bashrc
