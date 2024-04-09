patch:
	patch ../tools/demo.py demo.diff

prepare:
	sh prepare.sh
	
webcam:
	# python3 tools/demo_zed.py webcam -n yolox-s --trt --conf 0.25 --nms 0.45 --device gpu
	wget https://github.com/Megvii-BaseDetection/YOLOX/releases/download/0.1.1rc0/yolox_s.pth
	python3 tools/demo_zed.py webcam -n yolox-s -c yolox_s.pth --conf 0.25 --nms 0.45 --device gpu
