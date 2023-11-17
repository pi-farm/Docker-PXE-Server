#!/bin/bash
systemctl start chrony dnsmasq lighttpd nfs-mountd nfs-server nfs-kernel-server nmbd rsync samba-ad-dc smbd
systemctl stop rpcbind

systemctl status chrony dnsmasq lighttpd nfs-mountd nfs-server nfs-kernel-server nmbd rsync samba-ad-dc smbd