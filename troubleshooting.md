# 解決済みのtrouble
# webm file case
OpenCV: FFMPEG: tag 0x7634706d/'mp4v' is not supported with codec id 12 and format 'webm / WebM'

# mp4 file case
OK.

# on converting into tensortRT
[TRT] [W] Unknown embedded device detected. Using 59656MiB as the allocation cap for memory on embedded devices.
harmless

https://forums.developer.nvidia.com/t/w-trt-unknown-embedded-device-detected-using-59656mib-as-the-w-trt-unknown-embedded-device-detected-using-59656mib-as-the-allocation-ca/256657


# trt case failed ion mp4 movie
```
root@waragai-orin:~/YOLOX# python3 tools/demo.py image -n yolox-s --trt --save_result --path /root/yolox/yolox_data/rXzxjn-sN9M.mp4 --conf 0.25 --nms 0.45 --tsize 640             
2024-01-24 04:25:06.304 | INFO     | __main__:main:259 - Args: Namespace(camid=0, ckpt=None, conf=0.25, demo='image', device='gpu', exp_file=None, experiment_name='yolox_s', fp16=False, fuse=False, legacy=False, name='yolox-s', nms=0.45, path='/root/yolox/yolox_data/rXzxjn-sN9M.mp4', save_result=True, trt=True, tsize=640)
2024-01-24 04:25:06.850 | INFO     | __main__:main:269 - Model Summary: Params: 8.97M, Gflops: 26.93
2024-01-24 04:25:08.351 | INFO     | __main__:main:300 - Using TensorRT to inference
Traceback (most recent call last):
  File "tools/demo.py", line 320, in <module>
    main(exp, args)
  File "tools/demo.py", line 311, in main
    image_demo(predictor, vis_folder, args.path, current_time, args.save_result)
  File "tools/demo.py", line 194, in image_demo
    outputs, img_info = predictor.inference(image_name)
  File "tools/demo.py", line 140, in inference
    height, width = img.shape[:2]
AttributeError: 'NoneType' object has no attribute 'shape'
```
使い方の間違い。
動画をしていするときには,`python3 tools/demo.py video` でなくてはならない。


# cv2.imshow() failed in docker environment.
```
root@waragai-orin:~/YOLOX/yolox-docker# python3 show_image.py
Traceback (most recent call last):
  File "show_image.py", line 1, in <module>
    import cv2
  File "/usr/local/lib/python3.8/dist-packages/cv2/__init__.py", line 181, in <module>
    bootstrap()
  File "/usr/local/lib/python3.8/dist-packages/cv2/__init__.py", line 175, in bootstrap
    if __load_extra_py_code_for_module("cv2", submodule, DEBUG):
  File "/usr/local/lib/python3.8/dist-packages/cv2/__init__.py", line 28, in __load_extra_py_code_for_module
    py_module = importlib.import_module(module_name)
  File "/usr/lib/python3.8/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "/usr/local/lib/python3.8/dist-packages/cv2/mat_wrapper/__init__.py", line 39, in <module>
    cv._registerMatType(Mat)
AttributeError: partially initialized module 'cv2' has no attribute '_registerMatType' (most likely due to a circular import)
```
- これはopencv-python のバージョンが悪い。
- 別のバージョンを用いること。

# Can't initialize GTK backend
```
root@waragai-orin:~/YOLOX/yolox-docker# python3 show_image.py
cv2.__version__='4.5.0'
cv2.__file__='/usr/lib/python3.8/dist-packages/cv2/python-3.8/cv2.cpython-38-aarch64-linux-gnu.so'
No protocol specified
Unable to init server: Could not connect: Connection refused
Traceback (most recent call last):
  File "show_image.py", line 7, in <module>
    cv2.namedWindow(name, cv2.WINDOW_NORMAL)
cv2.error: OpenCV(4.5.0) /opt/opencv/modules/highgui/src/window_gtk.cpp:624: error: (-2:Unspecified error) Can't initialize GTK backend in function 'cvInitSystem'

root@waragai-orin:~/YOLOX/yolox-docker#
```

- host環境側で `xhost +` が実行されていないことによるエラー
