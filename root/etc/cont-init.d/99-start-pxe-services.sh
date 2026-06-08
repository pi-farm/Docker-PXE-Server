#!/command/with-contenv bash

echo "Starte PXE-relevante Dienste via systemctl-shim..."

# Fix für rpcbind: Fehlendes Verzeichnis erstellen
mkdir -p /run/sendsigs.omit.d

systemctl start rpcbind
systemctl start nfs-kernel-server
systemctl start dnsmasq
systemctl start lighttpd
systemctl start smbd
systemctl start nmbd
