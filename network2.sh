#!/bin/bash
#
# Configure Network 2 for the training.
#
# client1 ---------- router1 ---------- client2
source functions.sh

case $1 in
  start)
    clonevm client1
    clonevm router1
    clonevm client2

    # Connect both nodes to the first host-only interface and start the VMs
    startvm client1 vboxnet0
    startvm router1 vboxnet0 vboxnet1
    startvm client2 vboxnet1
    ;;

  stop)
    # Poweroff the running nodes
    stopvm client1
    stopvm router1
    stopvm client2
    ;;

  *)
    echo "usage: $0 [start|stop]"
    ;;
esac
