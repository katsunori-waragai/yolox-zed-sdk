# yolox-zed-sdk
docker environment for YOLOX on Jetson AGX Orin with ZED SDK

- Pytorchを含むJetson 用のDockerImage を用いて、 ZED SDK を利用できる環境を提供する。
- ZED SDK によるデータ取得を用いて、その環境内でyoloxによる物体検出を実行する。

## requirement
- StereoLabs ZED2i camera
- NVIDIA Jetson AGX Orin
- docker

### docker
```
$ xhost +
$ bash docker_build.sh
$ bash docker_run.sh
```

### tools/demo.py の使い方

```
root@waragai-orin:~/YOLOX# python3 tools/demo.py -h
usage: YOLOX Demo! [-h] [-expn EXPERIMENT_NAME] [-n NAME] [--path PATH] [--camid CAMID] [--save_result] [-f EXP_FILE] [-c CKPT]
                   [--device DEVICE] [--conf CONF] [--nms NMS] [--tsize TSIZE] [--fp16] [--legacy] [--fuse] [--trt]
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
root@waragai-orin:~/YOLOX#

```

### image example
```
cd YOLOX
# yolox-s　model
python3 tools/demo.py image -n yolox-s -c ./yolox_s.pth --path assets/dog.jpg --conf 0.25 --nms 0.45 --tsize 640 --save_result --device gpu

# yolox-tiny model
python3 tools/demo.py image -n yolox-tiny -c ./yolox_tiny.pth --path assets/dog.jpg --conf 0.25 --nms 0.45 --tsize 640 --save_result --device gpu

```

saved results in YOLOX/YOLOX_outputs/yolox_s/vis_res/

### video example
- host環境側で表示可能なように設定しておくこと。

```
$ xhost +
```

- Docker 環境での操作
```
python3 tools/demo.py video -n yolox-s -c ./yolox_s.pth --path [VIDEOFILE] --conf 0.25 --nms 0.45 --tsize 640 --save_result --device gpu
```

root@waragai-orin:~/YOLOX# python3 tools/demo.py video -n yolox-s -c ./yolox_s.pth --path yolox-docker/rXzxjn-sN9M.mp4 --conf 0.25 --nms 0.45 --tsize 640  --device gpu

pip install "opencv-python<=3.4.18.65"

```
root@waragai-orin:~/YOLOX# python3 tools/demo.py video -n yolox-s -c ./yolox_s.pth --path [VIDEOFILE] --conf 0.25 --nms 0.45 --tsize 640 --save_result --device gpu
root@waragai-orin:~/YOLOX# python3 tools/demo.py video -n yolox-s -c ./yolox_s.pth --path yolox-docker/rXzxjn-sN9M.mp4 --conf 0.25 --nms 0.45 --tsize 640  --device gpu
```

### webcam example
```
root@waragai-orin:~/YOLOX# python3 tools/demo.py webcam -n yolox-s -c ./yolox_s.pth --camid 0 --conf 0.25 --nms 0.45  --device gpu
```

### ZED2i の場合
- cap.read() で左、右画像が連結された画像が取得される。
  - frame.shape=(1242, 4416, 3)
- そのため、次のようにして、左画像だけを取得する。
- np.array() で囲む理由は、深層学習の入力データは、連続していることを前提としている。
- 省くと、検出結果が得られなくなる。

```commandline
root@waragai-orin:~/YOLOX# git diff tools/demo.py 
diff --git a/tools/demo.py b/tools/demo.py
index b16598d..dc89d8d 100644
--- a/tools/demo.py
+++ b/tools/demo.py
@@ -8,6 +8,7 @@ import time
 from loguru import logger
 
 import cv2
+import numpy as np
 
 import torch
 
@@ -226,6 +227,8 @@ def imageflow_demo(predictor, vis_folder, current_time, args):
         )
     while True:
         ret_val, frame = cap.read()
+        h, w = frame.shape[:2]
+        frame = np.array(frame[:, : w // 2 , :])
         if ret_val:
             outputs, img_info = predictor.inference(frame)
             result_frame = predictor.visual(outputs[0], img_info, predictor.confthre)
```


## TensorRT対応
### 情報源
  - YOLOX の公式サイトによるTensorRT化のdeploy 方法
  https://github.com/Megvii-BaseDetection/YOLOX/tree/main/demo/TensorRT/python

  https://yolox.readthedocs.io/en/latest/demo/trt_py_readme.html
### TensortRTの利用のための準備
- prepare.sh が実施すること。
  torcht2trt のインストール
  指定したtrtモデルへの変換。

Docker 環境内：
```
cd /root/YOLOX/yolox-docker_run
bash prepare.sh

```
### 変換作業
```
# python3 tools/trt.py -n <YOLOX_MODEL_NAME> -c <YOLOX_CHECKPOINT>

# python3 tools/trt.py -n yolox-s -c yolox_s.pth
2024-01-24 03:28:15.999 | INFO     | __main__:main:71 - Converted TensorRT model done.
2024-01-24 03:28:16.051 | INFO     | __main__:main:79 - Converted TensorRT model engine file is saved for C++ inference.

## TensorRTに変換済みのファイルが置かれる場所
root@waragai-orin:~/YOLOX# ls -lF YOLOX_outputs/yolox_s/
total 48932
-rw-r--r-- 1 root root 20431374 Jan 24 03:28 model_trt.engine
-rw-r--r-- 1 root root 29663539 Jan 24 03:28 model_trt.pth
drwxr-xr-x 3 root root     4096 Jan 24 04:20 vis_res/
```
#### Docker 環境でのTRT化したモデルをDocker環境外に保存する方法
- docker_run.sh の中で設定するvolume のマウントポイントにYOLOX_outputs/を追加した。
  - このことで、各実行時のYOLOX_outputs/ディレクトリを永続化した。

### 変換後のモデルを利用した推論
```
# python3 tools/demo.py image -n yolox-s --trt --save_result --path assets/dog.jpg --conf 0.25 --nms 0.45 --tsize 640 --save_result --device gpu

# python3 tools/demo.py video -n yolox-s --trt --save_result --path /root/yolox/yolox_data/rXzxjn-sN9M.mp4 --conf 0.25 --nms 0.45 --tsize 640 --device gpu

root@waragai-orin:~/YOLOX# python3 tools/demo.py video -n yolox-tiny --trt --path yolox-docker/rXzxjn-sN9M.mp4 --conf 0.25 --nms 0.45  --device gpu


```

- 検出結果のGUIへの表示

## 制限事項
- 動画ではwebm 形式は用いず、mp4形式を使おう。

## SEE ALSO
[Jetson Xavier AGXでYOLOXを動かす　ちょっとだけベンチマーク](https://qiita.com/sowd0726/items/bd916f712946961a7432)

