sudo apt-get update

wget -O enable_kernel_sources.sh http://bit.ly/en_krnl_src
bash ./enable_kernel_sources.sh
rm enable_kernel_sources.sh

sudo apt-get update

sudo apt-get install -y ros-kinetic-turtlebot ros-kinetic-turtlebot-msgs ros-kinetic-turtlebot-apps ros-kinetic-turtlebot-interactions ros-kinetic-turtlebot-simulator ros-kinetic-kobuki ros-kinetic-kobuki-msgs ros-kinetic-yujin-ocs ros-kinetic-astra-*

wget https://raw.githubusercontent.com/clearpathrobotics/turtlebot2_setup/master/56-orbbec-usb.rules
sudo mv 56-orbbec-usb.rules /etc/udev/rules.d/

wget https://github.com/TurtleBot-Mfg/turtlebot-wallpapers/raw/master/root/usr/share/backgrounds/TurtleBot_Lite_by_IHE.jpg -O //home/turtlebot/Pictures/TurtleBot_Lite_by_IHE.jpg
gsettings set org.gnome.desktop.background picture-uri file:///home/turtlebot/Pictures/TurtleBot_Lite_by_IHE.jpg

echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
echo "export TURTLEBOT_3D_SENSOR=astra" >> ~/.bashrc
source ~/.bashrc
