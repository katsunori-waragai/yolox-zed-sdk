# ZED SDK - Object Detection
YOLOX binding with ZED SDK

This sample shows how to detect custom objects using the official Pytorch implementation of YOLOX from a ZED camera and ingest them into the ZED SDK to extract 3D informations and tracking for each objects.

## Getting Started

 - Get the latest [ZED SDK](https://www.stereolabs.com/developers/release/) and [pyZED Package](https://www.stereolabs.com/docs/app-development/python/install/)
 - Check the [Documentation](https://www.stereolabs.com/docs/object-detection/custom-od/)

## Setting up
 - Install python modules
```sh
python3 -m pip install -r requirements.txt
```

 - Install YOLOX, TensorRT

## Setting up with docker

```
$ bash docker_build.sh
$ bash docker_run.sh
# cd /root/yolox-zed-sdk/pytorch_yolox
```

## Run the program
- webcam_as_usb.sh # Detector script to use ZED2i as USB camera
- webcam_zed.sh # Detector script to use ZED2i in the framework of ZED SDK
- demo_zed.py Object detection in yolox using ZED camera (trying to send detection results back to ZED SDK for 3D display)

- The inference time for object detection
  - tensorRT model: around 10ms.
  - pyTorch model: about 30ms.

```commandline
bash prepare.sh
```
```commandline
bash webcam_zed.sh
```
![](figures/webcam_as_usb.png)

```commandline
bash webcam_as_usb.sh
```
![](figures/webcam_zed.png)


# yolox/tools-derived scripts and pytorch_yoloxv8-derived library
- cv_viewer/
- ogl_viewer/ 
is a drawing library derived from pytorch_yolov8

# demo_zed.py
- Script derived from pytorch_yolov8 with detection changed to yolox.
- It uses two viewers from pytorch_yolov8.