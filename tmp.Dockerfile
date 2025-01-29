FROM ubuntu:20.10

RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y
RUN apt-get install unzip fdisk util-linux nano xz-utils wget systemctl sudo git tcpdump -y

ADD https://github.com/just-containers/s6-overlay/releases/download/v3.1.6.0/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz

ARG arch
RUN if [ "$arch" = "x86_64" ] ; then wget -O /tmp/s6-overlay-i686.tar.xz https://github.com/just-containers/s6-overlay/releases/download/v3.1.6.0/s6-overlay-i686.tar.xz ; fi;
RUN if [ "$arch" = "x86_64" ] ; then tar -C / -Jxpf /tmp/s6-overlay-i686.tar.xz ; fi;

RUN if [ "$arch" = "arm64" ] ; then wget -O /tmp/s6-overlay-aarch64.tar.xz https://github.com/just-containers/s6-overlay/releases/download/v3.1.6.0/s6-overlay-aarch64.tar.xz ; fi;
RUN if [ "$arch" = "arm64" ] ; then tar -C / -Jxpf /tmp/s6-overlay-aarch64.tar.xz ; fi;

RUN mkdir /app
RUN mkdir /app/RPi-PXE-Server

COPY root/ /

VOLUME /app/RPi-PXE-Server
VOLUME /srv
VOLUME /etc/samba
VOLUME /boot

RUN rm -rf /temp/*

WORKDIR /app/RPi-PXE-Server

ENTRYPOINT [ "/init" ]