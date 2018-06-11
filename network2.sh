#!/bin/bash
#
# Configure Network 2 for the training.
#
# client1 ---net0--- router1 ---net1--- client2
cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd
source functions.sh

case $1 in
  start)
    # Clone nodes from Debian image
    clonevms client1 router1 client2

    # Connect both nodes to the first host-only interface and start the VMs
    startvm client1 vboxnet0
    startvm router1 vboxnet0 vboxnet1
    startvm client2 vboxnet1
    ;;

  stop)
    # Poweroff the running nodes
    stopvms client1 router1 client2
    ;;

  destroy)
    # Destroy all nodes
    destroyvms client1 router1 client2
    ;;

  *)
    echo "usage: $0 (start|stop|destroy)"
    ;;
esac
