# yolox-zed-sdk
YOLOX binding with ZED SDK

## requirement
- StereoLabs ZED2i camera
- NVIDIA Jetson AGX Orin

#### examples
```commandline
bash webcam_as_usb.sh
```
![](pytorch_yolox/figures/webcam_as_usb.png)
```commandline
bash webcam_zed.sh 
```
![](pytorch_yolox/figures/webcam_zed.png)


# Donate this repository to StereoLabs

We think that the linkage between the ZED SDK and object detection is something that most StereoLabs users are hoping for.
We also hope that the object detection library is a commercially available library.
However, Yolo in custom detector at the moment is AGPL-3.0 License:.
https://github.com/stereolabs/zed-sdk/tree/master/object%20detection/custom%20detector/python

Therefore, we created a binding with YOLOX which is MIT LICENSE.
The folder pytorch_yolox is modified from the original folder pytorch_yolov8.

We hope that this implementation will be supplied to all StereoLabs users.

If you find useful, we hope you will test it and add it to the standard ZED SDK repository