sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y autoremove

wget -O enable_kernel_sources.sh http://bit.ly/en_krnl_src
bash ./enable_kernel_sources.sh
rm enable_kernel_sources.sh

# add Intel's RealSense repository; otherwise we get problems installing librealsense
sudo apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
sudo add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main" -u

sudo apt-get update

sudo apt-get install -y librealsense2-dkms librealsense2-utils librealsense2-dev
sudo apt-get install -y ros-kinetic-turtlebot ros-kinetic-turtlebot-msgs ros-kinetic-turtlebot-apps ros-kinetic-turtlebot-interactions ros-kinetic-turtlebot-simulator ros-kinetic-kobuki ros-kinetic-kobuki-msgs ros-kinetic-yujin-ocs ros-kinetic-astra-*

wget https://raw.githubusercontent.com/clearpathrobotics/turtlebot2_setup/master/56-orbbec-usb.rules
sudo mv 56-orbbec-usb.rules /etc/udev/rules.d/

wget https://github.com/TurtleBot-Mfg/turtlebot-wallpapers/raw/master/root/usr/share/backgrounds/TurtleBot_Lite_by_IHE.jpg -O //home/turtlebot/Pictures/TurtleBot_Lite_by_IHE.jpg
gsettings set org.gnome.desktop.background picture-uri file:///home/turtlebot/Pictures/TurtleBot_Lite_by_IHE.jpg

echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
echo "export TURTLEBOT_3D_SENSOR=astra" >> ~/.bashrc
source ~/.bashrc
