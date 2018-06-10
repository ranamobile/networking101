#!/bin/bash
#
# Set up the Networking 101 training.

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
