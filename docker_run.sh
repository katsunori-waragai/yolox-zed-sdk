#!/bin/bash
xhost +
export CWD=$(cd $(dirname $0)/; pwd)
docker run -it --rm --net=host --runtime nvidia -e DISPLAY=$DISPLAY \
	-v ${CWD}:/root/yolox-zed-sdk \
	--device /dev/bus/usb \
	--device /dev/video0:/dev/video0:mwr \
	-v /tmp/.X11-unix/:/tmp/.X11-unix yolox-zed:100
 
