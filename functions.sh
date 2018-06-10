#!/bin/bash
#
# Basic VirtualBox functions.

clonevm() {
  NODENAME=$1
  echo "Cloning ${NODENAME}..."
  if [ ! "$(vboxmanage list vms | grep -i ${NODENAME})" ]; then
    vboxmanage clonevm "Debian-7.8-amd64-minimal" --name "${NODENAME}" --register
  fi
}

clonevms() {
  for nodename in "$@"; do
    clonevm ${nodename}
  done
}

startvm() {
  NODENAME=$1
  NIC1=${2:-vboxnet0}
  NIC2=${3:-none}
  echo "Starting ${NODENAME} with nic1 ${NIC1} and nic2 ${NIC2}..."
  if [ ! "$(vboxmanage list runningvms | grep -i ${NODENAME})" ]; then
    vboxmanage modifyvm ${NODENAME} --nic1 hostonly --hostonlyadapter1 ${NIC1} --nic2 ${NIC2} --nic3 none --nic4 none    
    vboxmanage startvm ${NODENAME}
  fi
}

stopvm() {
  NODENAME=$1
  echo "Stopping ${NODENAME}..."
  if [ "$(vboxmanage list runningvms | grep -i ${NODENAME})" ]; then
    vboxmanage controlvm ${NODENAME} poweroff
  fi
}

stopvms() {
  for nodename in "$@"; do
    stopvm ${nodename}
  done
}

destroyvm() {
  NODENAME=$1
  stopvm ${NODENAME}
  sleep 0.5  # Give VM time to update VirtualBox status
  if [ "$(vboxmanage list vms | grep -i ${NODENAME})" ]; then
    vboxmanage unregistervm ${NODENAME} --delete
  fi
}

destroyvms() {
  for nodename in "$@"; do
    destroyvm ${nodename}
  done
}
