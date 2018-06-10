#!/bin/bash
#
# Basic VirtualBox functions.

clonevm() {
  NODE_NAME=$1
  echo "Cloning ${NODE_NAME}..."
  if [ ! "$(vboxmanage list vms | grep -i ${NODE_NAME})" ]; then
    vboxmanage clonevm "Debian-7.8-amd64-minimal" --name "${NODE_NAME}" --register
  fi
}

startvm() {
  NODE_NAME=$1
  NIC1=${2:-vboxnet0}
  NIC2=${3:-none}
  echo "Starting ${NODE_NAME} with nic1 ${NIC1} and nic2 ${NIC2}..."
  if [ ! "$(vboxmanage list runningvms | grep -i ${NODE_NAME})" ]; then
    vboxmanage modifyvm ${NODE_NAME} --nic1 hostonly --hostonlyadapter1 ${NIC1} --nic2 ${NIC2} --nic3 none --nic4 none    
    vboxmanage startvm ${NODE_NAME}
  fi
}

stopvm() {
  NODE_NAME=$1
  echo "Stopping ${NODE_NAME}..."
  if [ "$(vboxmanage list runningvms | grep -i ${NODE_NAME})" ]; then
    vboxmanage controlvm ${NODE_NAME} poweroff
  fi
}
