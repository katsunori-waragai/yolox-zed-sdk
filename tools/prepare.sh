#!/bin/sh
export BINDING_HOME=/root/yolox-zed-sdk/tools
cd ${BINDING_HOME}
if [ ! -f yolox_s.pth ]; then
  wget https://github.com/Megvii-BaseDetection/YOLOX/releases/download/0.1.1rc0/yolox_s.pth
fi
export TRTMODEL_S=${BINDING_HOME}/YOLOX_outputs/yolox_s/model_trt.pth
if [ ! -f ${TRTMODEL_S} ]; then
	python3 trt.py -n yolox-s -c yolox_s.pth
else
  echo "skipped conversion by torch2trt. already exists."
fi
