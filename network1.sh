#!/bin/bash
#
# Configure Network 1 for the training.
#
# node1 ---net0--- node2
cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd
source functions.sh

case $1 in
  start)
    # Clone node1 and node2 from Debian image
    clonevms node1 node2

    # Connect both nodes to the first host-only interface and start the VMs
    startvm node1 vboxnet0
    startvm node2 vboxnet0
    ;;

  stop)
    # Poweroff the running nodes
    stopvms node1 node2
    ;;

  destroy)
    # Destroy all nodes
    destroyvms node1 node2
    ;;

  *)
    echo "usage: $0 (start|stop|destroy)"
    ;;
esac
