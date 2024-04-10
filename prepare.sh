#!/bin/sh
# torch2trt
cd /root
git clone https://github.com/NVIDIA-AI-IOT/torch2trt ; cd torch2trt; python3 setup.py install

export PROJECT_HOME=/root/yolox-zed-sdk
cd ${PROJECT_HOME}
export TRTMODEL_S=${PROJECT_HOME}/YOLOX_outputs/yolox_s/model_trt.pth
if [ ! -f ${TRTMODEL_S} ]; then
	python3 tools/trt.py -n yolox-s -c yolox_s.pth
fi
