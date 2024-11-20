#!/bin/sh
cd /root
if [ ! -d torch2trt ]; then
  git clone https://github.com/NVIDIA-AI-IOT/torch2trt ; cd torch2trt; python3 setup.py install
else
  echo "skipped install torch2trt. already exists."
fi

export PROJECT_HOME=/root/yolox-zed-sdk
export YOLOX_HOME=/root/YOLOX
cd ${YOLOX_HOME}
if [ ! -f yolox_s.pth ]; then
  wget https://github.com/Megvii-BaseDetection/YOLOX/releases/download/0.1.1rc0/yolox_s.pth
fi
export TRTMODEL_S=${YOLOX_HOME}/YOLOX_outputs/yolox_s/model_trt.pth
if [ ! -f ${TRTMODEL_S} ]; then
	python3 tools/trt.py -n yolox-s -c yolox_s.pth
else
  echo "skipped conversion by torch2trt. already exists."
fi

mkdir --parents ${PROJECT_HOME}//YOLOX_outputs/yolox_s
cp -r ${YOLOX_HOME}/YOLOX_outputs/yolox_s/ ${PROJECT_HOME}/YOLOX_outputs/yolox_s

