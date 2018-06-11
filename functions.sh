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
  NIC1=$([ "$2" ] && echo "--nic1 hostonly --hostonlyadapter1 $2" || echo "--nic1 none")
  NIC2=$([ "$3" ] && echo "--nic2 hostonly --hostonlyadapter2 $3" || echo "--nic2 none")
  NIC3=$([ "$4" ] && echo "--nic3 hostonly --hostonlyadapter3 $4" || echo "--nic3 none")
  NIC4=$([ "$5" ] && echo "--nic4 hostonly --hostonlyadapter4 $5" || echo "--nic4 none")

  echo "Starting ${NODENAME} with ${NIC1} ${NIC2} ${NIC3} ${NIC4}..."
  if [ ! "$(vboxmanage list runningvms | grep -i ${NODENAME})" ]; then
    vboxmanage modifyvm ${NODENAME} ${NIC1} ${NIC2} ${NIC3} ${NIC4}
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

waitforvm() {
  NODENAME=$1
  echo "Waiting for ${NODENAME} to boot..."
  while ! sendcmd ${NODENAME} /bin/ls >/dev/null 2>/dev/null; do
    sleep 1
  done
}

sendcmd() {
  NODENAME=$1
  COMMAND=${@:2}
  vboxmanage guestcontrol ${NODENAME} --username root --password toor run -- ${COMMAND}
  return $?
}
