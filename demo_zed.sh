#!/bin/bash
python3 tools/demo_zed.py webcam -n yolox-s -c ./yolox_s.pth --camid 0 --conf 0.25 --nms 0.45 --device gpu
