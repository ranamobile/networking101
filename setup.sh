#!/bin/bash
#
# Set up the Networking 101 training.
cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd
source functions.sh

# Install VirtualBox
sudo yum install -y VirtualBox-5.2

# Download and import a minimal Debian image
if [ ! -f debian-7.8-amd64-minimal.ova ]; then
  wget -O debian-7.8-amd64-minimal.ova https://sourceforge.net/projects/virtualappliances/files/Linux/Debian/Debian-7.8-amd64-minimal.ova/download
fi

# Import the Debian VM into VirtualBox
if [ ! "$(vboxmanage list vms | grep -i debian)" ]; then
  vboxmanage import debian-7.8-amd64-minimal.ova
fi

# Set up network interfaces
while [ $(vboxmanage list hostonlyifs | grep -E ^Name | wc -l) -lt 5 ]; do
  vboxmanage hostonlyif create
done

# Set up Debian VM to allow IPv4 traffic through
startvm Debian-7.8-amd64-minimal
waitforvm Debian-7.8-amd64-minimal
sendcmd Debian-7.8-amd64-minimal /bin/sed -i "s/#net.ipv4.ip_forward/net.ipv4.ip_forward/g" /etc/sysctl.conf
sendcmd Debian-7.8-amd64-minimal /sbin/sysctl -p
sendcmd Debian-7.8-amd64-minimal /sbin/poweroff

exit 0