HowToBuild and setup

Clone this repo: "git clone https://github.com/pi-farm/Docker-PXE-Server.git"
and cd into it: "cd Docker-PXE-Server"

#####################################################################################################

1:   run: "bash start" or "bash t-start"

1.1: choose (b) to build the image and installing everything in the PXE-Container
1.2: restart your pi

#####################################################################################################

2:   run: "bash start" or "bash t-start"

2.1: choose (e) to edit the p2-include-handle file in RPi-PXE-Server
     (look here: https://github.com/beta-tester/RPi-PXE-Server#p2-include-handle--c2-custom-handle)
2.2: choose (s) to setup the PXE-Container
2.3: restart your pi

#####################################################################################################

3:   run: "bash start" or "bash t-start"

3.1: choose (u) for update

After that, your PXE-Container is ready!

#####################################################################################################

to check, if the volumes are mounted, go into the running container:
- run: "docker exec -it pxe-container bash"
- run: "df -h"
- run: "showmount -e"

Check if all services are up and running:

"systemctl status chrony dnsmasq lighttpd nfs-mountd nfs-server nfs-kernel-server"

if not, try to start the services:

"systemctl start chrony dnsmasq lighttpd nfs-mountd nfs-server nfs-kernel-server"

 NOTE: win-pxe / SAMBA feature not tested... coming soon!
