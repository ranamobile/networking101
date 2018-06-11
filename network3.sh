#!/bin/bash
#
# Configure Network 3 for the training.
#
# client1 ---net0--- router1 ---net1--- router2 ---net2--- client2
cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd
source functions.sh

case $1 in
  start)
    # Clone nodes from Debian image
    clonevms client1 router1 router2 client2

    # Connect both nodes to the first host-only interface and start the VMs
    startvm client1 vboxnet0
    startvm router1 vboxnet0 vboxnet1
    startvm router2 vboxnet1 vboxnet2
    startvm client2 vboxnet2
    ;;

  stop)
    # Poweroff the running nodes
    stopvms client1 router1 router2 client2
    ;;

  destroy)
    # Destroy all nodes
    destroyvms client1 router1 router2 client2
    ;;

  *)
    echo "usage: $0 (start|stop|destroy)"
    ;;
esac
