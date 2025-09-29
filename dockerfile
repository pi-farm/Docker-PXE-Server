FROM debian:11-slim
RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y && apt-get install unzip fdisk util-linux nano xz-utils wget systemctl sudo git tcpdump zstd -y
ADD https://github.com/just-containers/s6-overlay/releases/download/v3.1.6.0/s6-overlay-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v3.1.6.0/s6-overlay-aarch64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-aarch64.tar.xz && tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz && mkdir /app && mkdir /app/RPi-PXE-Server
COPY root/ /
VOLUME /app/RPi-PXE-Server
VOLUME /srv
VOLUME /etc/samba
VOLUME /boot
RUN rm -rf /temp/* && rm -rf /var/lib/apt/lists/*
WORKDIR /app/RPi-PXE-Server
ENTRYPOINT [ "/init" ]
