FROM ubuntu:latest

RUN apt update && apt upgrade -y && apt autoremove -y
RUN apt install util-linux nano xz-utils wget systemctl sudo git -y

ADD https://github.com/just-containers/s6-overlay/releases/download/v3.1.6.0/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v3.1.6.0/s6-overlay-aarch64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-aarch64.tar.xz

RUN mkdir /app
RUN mkdir /app/RPi-PXE-Server

COPY root/ /

#WORKDIR /app
#RUN git clone https://github.com/beta-tester/RPi-PXE-Server.git

#VOLUME /app/RPi-PXE-Server
#COPY scripts/ /app/RPi-PXE-Server/

VOLUME /app/RPi-PXE-Server
VOLUME /srv
VOLUME /etc/samba
VOLUME /boot

WORKDIR /app/RPi-PXE-Server

ENTRYPOINT [ "/init" ]

## docker build -t pxe-image:test01 .
## docker run -it -d --privileged --net=host --volume ${PWD}/RPi-PXE-Server:/app/RPi-PXE-Server --volume ${PWD}/srv:/srv --name pxe-container pxe-image:test01
## docker exec -it pxe-container bash
## systemctl start chrony dnsmasq lighttpd nfs-mountd nfs-server nfs-kernel-server nmbd rsync samba-ad-dc smbd udev && systemctl stop rpcbind

## /etc/init.d/dnsmasq start
## /etc/init.d/chrony start
## /etc/init.d/lighttpd start
## /etc/init.d/nfs-kernel-server start
