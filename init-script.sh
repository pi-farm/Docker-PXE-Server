#!/bin/bash
systemctl start chrony dnsmasq lighttpd nfs-mountd nfs-server nfs-kernel-server nmbd rsync samba-ad-dc smbd
#systemctl stop rpcbind
systemctl start rpcbind && systemctl start nfs-kernel-server && rpc.mountd
systemctl status chrony dnsmasq lighttpd nfs-mountd nfs-server nfs-kernel-server nmbd rsync samba-ad-dc smbd
