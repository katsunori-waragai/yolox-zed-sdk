# ZED SDK - Object Detection

This sample shows how to detect custom objects using the official Pytorch implementation of YOLOv8 from a ZED camera and ingest them into the ZED SDK to extract 3D informations and tracking for each objects.

## Getting Started

 - Get the latest [ZED SDK](https://www.stereolabs.com/developers/release/) and [pyZED Package](https://www.stereolabs.com/docs/app-development/python/install/)
 - Check the [Documentation](https://www.stereolabs.com/docs/object-detection/custom-od/)

## Setting up

 - Install YOLOX

```sh
pip install ultralytics
```

## Run the program
bash webcam_zed.sh

bash webcam_as_usb.sh

# yolox/tools-derived scripts and pytorch_yoloxv8-derived library
- cv_viewer/
- ogl_viewer/ 
is a drawing library derived from pytorch_yolov8

# demo_zed.py
- Script derived from pytorch_yolov8 with detection changed to yolox.
- It uses two viewers from pytorch_yolov8.