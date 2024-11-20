#!/bin/sh
export PROJECT_HOME=/root/yolox-zed-sdk
export YOLOX_HOME=/root/YOLOX
mkdir --parents ${PROJECT_HOME}/YOLOX_outputs/yolox_s
export TRTMODEL_S=${PROJECT_HOME}/YOLOX_outputs/yolox_s/yolox_s/model_trt.pth
if [ ! -f ${TRTMODEL_S} ]; then
	python3 tools/trt.py -n yolox-s -c ${YOLOX_HOME}/yolox_s.pth
else
  echo "skipped conversion by torch2trt. already exists."
fi
