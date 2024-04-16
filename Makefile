torch2trt:
	cd /root
	git clone https://github.com/NVIDIA-AI-IOT/torch2trt ; cd torch2trt; python3 setup.py install

prepare: yolox_s.pth
	sh prepare.sh
	
yolox_s.pth:
	wget https://github.com/Megvii-BaseDetection/YOLOX/releases/download/0.1.1rc0/yolox_s.pth

webcam: prepare
	python3 tools/demo_zed.py webcam -n yolox-s --trt --conf 0.25 --nms 0.45 --device gpu
	# python3 tools/demo_zed.py webcam -n yolox-s -c yolox_s.pth --conf 0.25 --nms 0.45 --device gpu
