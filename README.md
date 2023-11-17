HowToBuild and setup

Clone this repo: "git clone https://github.com/pi-farm/Docker-PXE-Server.git"
and cd into it: "cd pxe-server"

run: "bash start.sh"

1. choose (b) to build the image
2. restart your pc
3. edit the p2-include-handle file in RPi-PXE-Server folder
   (look here: https://github.com/beta-tester/RPi-PXE-Server#p2-include-handle--c2-custom-handle)
4. run "bash start.sh" again an choose (s) for setup
5. restart your pc
6. run "bash start.sh" again an choose (u) for update

afer that, your pc is ready


to check, if the volumes are mounted, go into the running container:
- run: "docker exec -it pxe-container bash"
- run: "df -h"
- run: "showmount -e"

Check if all services are up and running:

"systemctl status chrony dnsmasq lighttpd nfs-mountd nfs-server nfs-kernel-server"

if not, try to start the services:

"systemctl start chrony dnsmasq lighttpd nfs-mountd nfs-server nfs-kernel-server"


 NOTE: win-pxe / SAMBA feature not tested... coming soon!
