#!/command/with-contenv bash

echo "Starte PXE-relevante Dienste via systemctl-shim..."

# Hier alle Dienste auflisten, die der PXE-Server braucht
systemctl start rpcbind
systemctl start nfs-kernel-server
systemctl start dnsmasq
systemctl start lighttpd
systemctl start smbd
systemctl start nmbd
