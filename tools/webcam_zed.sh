#!/bin/sh
export MESA_GL_VERSION_OVERRIDE=3.3
python3 demo_zed.py webcam -n yolox-s -c yolox_s.pth --conf 0.25 --nms 0.45 --device=gpu
