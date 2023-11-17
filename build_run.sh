#!/bin/bash

docker stop pxe-container-s6
docker rm pxe-container-s6
docker rmi pxe-image:s6-test01

docker build -t pxe-image:s6-test01 .
#docker run -it --privileged --net=host --volume ${PWD}/RPi-PXE-Server:/app/RPi-PXE-Server --volume ${PWD}/srv:/srv --name pxe-container-s6 pxe-image:s6-test01
##docker exec -it pxe-container-s6 bash
