FROM stereolabs/zed:4.2-py-devel-jetson-jp5.1.0

RUN apt update
RUN apt install sudo
RUN apt-get install -y zip
RUN apt-get install -y build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
RUN apt-get install -y libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev
RUN apt-get install -y libv4l-dev v4l-utils qv4l2
RUN apt-get install -y curl
RUN apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
RUN apt-get install -y tensorrt nvidia-tensorrt-dev python3-libnvinfer-dev
# RUN apt-get install -y libGLdispatch
RUN python3 -m pip install -U pip
COPY ./requirements.txt /root/
RUN python3 -m pip install -r /root/requirements.txt

RUN cd /root && git clone https://github.com/Megvii-BaseDetection/YOLOX.git
RUN cd /root/YOLOX && \
    sed -i '/torchvision/d' requirements.txt && \
    sed -i '/numpy/d' requirements.txt && \
    sed -i '/torch/d' requirements.txt && \
    sed -i 's/opencv[-_]python/opencv-python<=3.4.18.65/' requirements.txt && \
    sed -i '/pycocotools/d' requirements.txt && \
    sed -i '/onnx/d' requirements.txt && \
    sed -i '/onnx/d' requirements.txt && \
    sed -i '/onnx/d' requirements.txt
RUN cd /root/YOLOX && python3 -m pip install -v -e .
RUN cd /root/YOLOX && wget https://github.com/Megvii-BaseDetection/YOLOX/releases/download/0.1.1rc0/yolox_s.pth

# torch2trt
ENV CUDA_HOME="/usr/local/cuda"
RUN cd /root/ && git clone https://github.com/NVIDIA-AI-IOT/torch2trt ;
RUN echo ${CUDA_HOME}
RUN cd /root/torch2trt && python3 -m pip install .
# RUN cd /root/YOLOX && python3 tools/trt.py -n yolox-s -c yolox_s.pth
