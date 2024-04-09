patch:
	patch ../tools/demo.py demo.diff

prepare:
	sh prepare.sh
	
webcam:
	cd .. ; python3 tools/demo.py webcam -n yolox-s --trt --conf 0.25 --nms 0.45 --device gpu
