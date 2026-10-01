#!/bin/bash
#systemctl start chrony dnsmasq lighttpd nfs-mountd nfs-server nfs-kernel-server nmbd rsync samba-ad-dc smbd
##systemctl stop rpcbind
#systemctl start rpcbind && systemctl start nfs-kernel-server && rpc.mountd
#systemctl status chrony dnsmasq lighttpd nfs-mountd nfs-server nfs-kernel-server nmbd rsync samba-ad-dc smbd

# 1. Zuerst zwingend rpcbind starten
systemctl start rpcbind

# Kurze Pause, damit der Portmapper-Dienst fully up & running ist
sleep 1

# 2. Erst danach NFS-Dienste und den Rest starten
systemctl start chrony dnsmasq lighttpd nfs-mountd nfs-server nfs-kernel-server nmbd rsync samba-ad-dc smbd

# 3. Optional: Falls rpc.mountd separat benötigt wird
rpc.mountd 2>/dev/null || true

# 4. Status aller Dienste prüfen
systemctl status rpcbind chrony dnsmasq lighttpd nfs-mountd nfs-server nfs-kernel-server nmbd rsync samba-ad-dc smbd
