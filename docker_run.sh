#!/bin/bash
export GIT_ROOT=${HOME}/github
sudo docker run -it --rm --net=host --runtime nvidia -e DISPLAY=$DISPLAY \
	-v ${GIT_ROOT}/yolox-docker/YOLOX_outputs:/root/YOLOX/YOLOX_outputs \
  -v ${GIT_ROOT}/yolox-docker:/root/YOLOX/yolox-docker \
	-v ${GIT_ROOT}/yolox-zed-sdk:/root/yolox-zed-sdk \
	--device /dev/bus/usb \
	--device /dev/video0:/dev/video0:mwr \
	-v /tmp/.X11-unix/:/tmp/.X11-unix yolox:100
 
