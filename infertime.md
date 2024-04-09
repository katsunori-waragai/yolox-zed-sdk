root@waragai-orin:~/YOLOX# python3 tools/demo.py image -n yolox-s -c yolox_s.pth  --path yolox-docker/sample.jpg --conf 0.25 --nms 0.45 --tsize 640  --device gpu
2024-01-24 06:14:20.666 | INFO     | __main__:main:259 - Args: Namespace(camid=0, ckpt='yolox_s.pth', conf=0.25, demo='image', device='gpu', exp_file=None, experiment_name='yolox_s', fp16=False, fuse=False, legacy=False, name='yolox-s', nms=0.45, path='yolox-docker/sample.jpg', save_result=False, trt=False, tsize=640)
2024-01-24 06:14:21.185 | INFO     | __main__:main:269 - Model Summary: Params: 8.97M, Gflops: 26.93
2024-01-24 06:14:22.927 | INFO     | __main__:main:282 - loading checkpoint
2024-01-24 06:14:23.083 | INFO     | __main__:main:286 - loaded checkpoint done.
2024-01-24 06:14:25.449 | INFO     | __main__:inference:165 - Infer time: 2.3479s
root@waragai-orin:~/YOLOX# python3 tools/demo.py image -n yolox-s --trt  --path yolox-docker/sample.jpg --conf 0.25 --nms 0.45 --tsize 640  --device gpu
2024-01-24 06:14:39.215 | INFO     | __main__:main:259 - Args: Namespace(camid=0, ckpt=None, conf=0.25, demo='image', device='gpu', exp_file=None, experiment_name='yolox_s', fp16=False, fuse=False, legacy=False, name='yolox-s', nms=0.45, path='yolox-docker/sample.jpg', save_result=False, trt=True, tsize=640)
2024-01-24 06:14:39.817 | INFO     | __main__:main:269 - Model Summary: Params: 8.97M, Gflops: 26.93
2024-01-24 06:14:41.453 | INFO     | __main__:main:300 - Using TensorRT to inference
2024-01-24 06:14:44.888 | INFO     | __main__:inference:165 - Infer time: 0.0141s
root@waragai-orin:~/YOLOX# 


