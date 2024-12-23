#!/bin/sh
cd $(dirname $0)
export MESA_GL_VERSION_OVERRIDE=3.3
(pip3 list | grep torch2trt) || ( cd .. ; make prepare)
python3 demo_zed.py webcam -n yolox-s --trt --conf 0.25 --nms 0.45 --device=gpu
# python3 demo_zed.py webcam -n yolox-s -c yolox_s.pth --conf 0.25 --nms 0.45 --device=gpu
