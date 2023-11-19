FROM ubuntu:latest

RUN apt-get update && apt upgrade -y && apt-get autoremove -y
RUN apt-get install util-linux nano xz-utils wget systemctl sudo git -y

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

RUN rm -rf /temp/*
WORKDIR /app/RPi-PXE-Server

ENTRYPOINT [ "/init" ]

