#!/bin/sh
export BINDING_HOME=/root/yolox-zed-sdk/pytorch_yolox
export YOLOX_HOME=/root/YOLOX
mkdir --parents ${BINDING_HOME}/YOLOX_outputs/yolox_s
mkdir --parents ${YOLOX_HOME}/YOLOX_outputs/yolox_s

cd ${YOLOX_HOME}
if [ ! -f yolox_s.pth ]; then
  wget https://github.com/Megvii-BaseDetection/YOLOX/releases/download/0.1.1rc0/yolox_s.pth
fi
export TRTMODEL_S=${YOLOX_HOME}/YOLOX_outputs/yolox_s/model_trt.pth
if [ ! -f ${TRTMODEL_S} ]; then
  cd ${YOLOX_HOME}/
  python3 tools/trt.py -n yolox-s -c ${YOLOX_HOME}/yolox_s.pth
else
  echo "skipped conversion by torch2trt. already exists."
fi

cp -r ${YOLOX_HOME}/YOLOX_outputs/yolox_s/ ${BINDING_HOME}/YOLOX_outputs/yolox_s

