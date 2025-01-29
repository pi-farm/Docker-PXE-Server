#!/bin/bash

docker stop pxe-container
docker rm pxe-container
docker rmi pxe-image:latest

docker build --load -t pxe-image:latest .
