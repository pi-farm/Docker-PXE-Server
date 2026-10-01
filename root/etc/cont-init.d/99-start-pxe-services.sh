#!/command/with-contenv bash

echo "Starte PXE-relevante Dienste via systemctl-shim..."

# Fix für rpcbind: Fehlendes Verzeichnis erstellen
mkdir -p /run/sendsigs.omit.d

# rpcbind läuft auf dem Host (network_mode: host)
#systemctl start rpcbind

# NFS:
# Das Debian-Init-Skript verweigert den Start, weil es den
# hostseitigen rpcbind-Prozess im Container nicht erkennen kann.
# nfsd daher direkt starten.
echo "Starte NFS kernel daemon..."
exportfs -ra
rpc.nfsd 8

echo "Starte PXE-Dienste..."
systemctl start dnsmasq
systemctl start lighttpd
systemctl start smbd
systemctl start nmbd
