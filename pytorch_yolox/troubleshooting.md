# 解決済みのtrouble
# on converting into tensortRT
[TRT] [W] Unknown embedded device detected. Using 59656MiB as the allocation cap for memory on embedded devices.
harmless

https://forums.developer.nvidia.com/t/w-trt-unknown-embedded-device-detected-using-59656mib-as-the-w-trt-unknown-embedded-device-detected-using-59656mib-as-the-allocation-ca/256657


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
