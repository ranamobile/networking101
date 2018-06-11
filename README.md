# Prerequisites

I have tested this only on CentOS 7.5.

# Setup

Run the setup script before doing anything else. This will install VirtualBox, download a Debian VM image and create a bunch of host-only network interfaces.

```
./setup.sh
./network1.sh start
```

# Training Networks

There are 4 training networks. Each network can be controlled using `./networkX.sh (start|stop|destroy)`.

```
./networkX.sh start    # Start up Network X - creates VMs, attach NICs and start up VMs
./networkX.sh stop     # Shutdown Network X - powers off VMs
./networkX.sh destroy  # Delete Network X - powers off VMs and deletes the VMs
```

## Network 1

```
-----------                  -----------
|         |                  |         |
|  node1  |-----vboxnet0-----|  node2  |
|         |                  |         |
-----------                  -----------
```

## Network 2

```
-----------              -----------              -----------
|         |              |         |              |         |
| client1 |---vboxnet0---| router1 |---vboxnet1---| client2 |
|         |              |         |              |         |
-----------              -----------              -----------
```

## Network 3

```
-----------              -----------              -----------              -----------
|         |              |         |              |         |              |         |
| client1 |---vboxnet0---| router1 |---vboxnet1---| router2 |---vboxnet2---| client2 |
|         |              |         |              |         |              |         |
-----------              -----------              -----------              -----------
```

## Network 4

```
-----------              -----------              -----------              -----------              -----------
|         |              |         |              |         |              |         |              |         |
| client1 |---vboxnet0---| router1 |---vboxnet1---| router2 |---vboxnet2---| router3 |---vboxnet3---| client2 |
|         |              |         |              |         |              |         |              |         |
-----------              -----------              -----------              -----------              -----------
```
