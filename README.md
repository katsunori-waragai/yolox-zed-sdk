# yolox-zed-sdk
YOLOX binding with ZED SDK

## requirement
- StereoLabs ZED2i camera
- NVIDIA Jetson AGX Orin

### Script in tools
- tools/webcam_as_usb.sh # Detector script to use ZED2i as USB camera
- tools/webcam_zed.sh # Detector script to use ZED2i in the framework of ZED SDK
- tools/demo_zed.py Object detection in yolox using ZED camera (trying to send detection results back to ZED SDK for 3D display)

- The inference time for object detection
  - tensorRT model: around 10ms.
  - pyTorch model: about 30ms.

#### examples
bash webcam_as_usb.sh
![](tools/figures/webcam_as_usb.png)
bash webcam_zed.sh 
![](tools/figures/webcam_zed.png)

