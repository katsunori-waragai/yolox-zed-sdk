# yolox-zed-sdk
YOLOX binding with ZED SDK

### full usage of demo_zed.py

```
root@orin:~/yolox-zed-sdk/pytorch_yolox# python3 demo_zed.py -h
usage: YOLOX Demo! [-h] [-expn EXPERIMENT_NAME] [-n NAME] [--path PATH] [--camid CAMID]
                   [--save_result] [-f EXP_FILE] [-c CKPT] [--device DEVICE] [--conf CONF]
                   [--nms NMS] [--tsize TSIZE] [--fp16] [--legacy] [--fuse] [--trt] [--as_USB]
                   demo

positional arguments:
  demo                  demo type, eg. image, video and webcam

optional arguments:
  -h, --help            show this help message and exit
  -expn EXPERIMENT_NAME, --experiment-name EXPERIMENT_NAME
  -n NAME, --name NAME  model name
  --path PATH           path to images or video
  --camid CAMID         webcam demo camera id
  --save_result         whether to save the inference result of image/video
  -f EXP_FILE, --exp_file EXP_FILE
                        please input your experiment description file
  -c CKPT, --ckpt CKPT  ckpt for eval
  --device DEVICE       device to run our model, can either be cpu or gpu
  --conf CONF           test conf
  --nms NMS             test nms threshold
  --tsize TSIZE         test img size
  --fp16                Adopting mix precision evaluating.
  --legacy              To be compatible with older versions
  --fuse                Fuse conv and bn for testing.
  --trt                 Using TensorRT model for testing.
  --as_USB              camera as USB Camera

root@orin:~/YOLOX#

```
### Trouble in `view_gl = True` Case
- If you modify demo_zed.py.
````
- view_gl = False
+ view_gl = True
```
I get the following error
 ERROR: Internal error <FBConfig with necessary capabilities not found> in function fgOpenWindow

- I have not found a solution to the error yet.

## TensorRT Support
### Sources.
  - How to deploy TensorRT by YOLOX official site
  https://github.com/Megvii-BaseDetection/YOLOX/tree/main/demo/TensorRT/python

  https://yolox.readthedocs.io/en/latest/demo/trt_py_readme.html
### Conversion scriopt to TensorRT
```
# python3 tools/trt.py -n <YOLOX_MODEL_NAME> -c <YOLOX_CHECKPOINT>

# python3 tools/trt.py -n yolox-s -c yolox_s.pth
2024-01-24 03:28:15.999 | INFO     | __main__:main:71 - Converted TensorRT model done.
2024-01-24 03:28:16.051 | INFO     | __main__:main:79 - Converted TensorRT model engine file is saved for C++ inference.
