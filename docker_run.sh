#!/bin/bash
sudo docker run -it --rm --net=host --runtime nvidia -e DISPLAY=$DISPLAY \
	-v ~/github/yolox-docker/YOLOX_outputs:/root/YOLOX/YOLOX_outputs \
        -v ~/github/yolox-docker:/root/YOLOX/yolox-docker \
	-v ~/github/yolox-zed-sdk:/root/YOLOX/yolox-zed-sdk \
	--device /dev/bus/usb \
	--device /dev/video0:/dev/video0:mwr \
	-v /tmp/.X11-unix/:/tmp/.X11-unix yolox:100
 
