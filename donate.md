# Denote this repository to StereoLabs

ZED SDKと物体検出との連動は、StereoLabsのユーザーのほとんどが願っていることだと思います。
また、その物体検出のライブラリが商業利用可能なライブラリであることを願っていると思います。
ただ、現時点でのcustom detectorにあるYoloはAGPL-3.0 License: です。
https://github.com/stereolabs/zed-sdk/tree/master/object%20detection/custom%20detector/python

そこで、MIT LICENSE であるYOLOX とのbinding を作成した。
pytorch_yolov8 のフォルダを元に改変しています。
改変後のフォルダはpytorch_yolox としています。

このリポジトリの作者は、このリポジトリの実装が、StereoLabsのユーザーの全てに供給されることを望んでいます。

StereoLabsのZED SDK の開発者のみなさんがこのリポジトリの実装に関心をもっていただけたら、
テストして標準のZED SDK のリポジトリに加えていただけることを希望いたします。


