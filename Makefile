patch:
	patch ../tools/demo.py demo.diff

prepare:
	sh prepare.sh
	
webcam:
	python3 tools/demo_zed.py webcam -n yolox-s --trt --conf 0.25 --nms 0.45 --device gpu
