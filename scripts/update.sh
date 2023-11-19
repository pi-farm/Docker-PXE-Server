#!/bin/bash

git config --global --add safe.directory /app/RPi-PXE-Server
git pull
bash run.sh update
rpc.mountd
df -h
showmount -e
exit
