#!/bin/bash
#
# Configure Network 1 for the training.
#
# node1 ---------- node2
source functions.sh

case $1 in
  start)
    # Clone node1 and node2 from Debian image
    clonevm node1
    clonevm node2

    # Connect both nodes to the first host-only interface and start the VMs
    startvm node1 vboxnet0
    startvm node2 vboxnet0
    ;;

  stop)
    # Poweroff the running nodes
    stopvm node1
    stopvm node2
    ;;

  *)
    echo "usage: $0 [start|stop]"
    ;;
esac
