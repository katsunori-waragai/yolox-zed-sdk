#!/usr/bin/env python3

import argparse
from loguru import logger
import os

import cv2
import numpy as np
import pyzed.sl as sl

from yolox.data.data_augment import ValTransform
from yolox.data.datasets import COCO_CLASSES
from yolox.exp import get_exp
from yolox.utils import fuse_model, get_model_info, postprocess, vis

from demo import Predictor
from demo import make_parser,  get_exp

def main(exp, args):

    print("Initializing Camera...")

    zed = sl.Camera()

    input_type = sl.InputType()

    # Create a InitParameters object and set configuration parameters
    init_params = sl.InitParameters()
    init_params.coordinate_units = sl.UNIT.METER
    init_params.depth_mode = sl.DEPTH_MODE.ULTRA  # QUALITY
    init_params.coordinate_system = sl.COORDINATE_SYSTEM.RIGHT_HANDED_Y_UP
    init_params.depth_maximum_distance = 50

    runtime_params = sl.RuntimeParameters()
    status = zed.open(init_params)

    if status != sl.ERROR_CODE.SUCCESS:
        print(repr(status))
        exit()

    print("Initialized Camera")



    # Display
    image_left = sl.Mat()

    if args.trt:
        args.device = "gpu"

    logger.info("Args: {}".format(args))

    if args.conf is not None:
        exp.test_conf = args.conf
    if args.nms is not None:
        exp.nmsthre = args.nms
    if args.tsize is not None:
        exp.test_size = (args.tsize, args.tsize)

    model = exp.get_model()
    logger.info("Model Summary: {}".format(get_model_info(model, exp.test_size)))

    if args.device == "gpu":
        model.cuda()
        if args.fp16:
            model.half()  # to FP16
    model.eval()

    if args.fuse:
        logger.info("\tFusing model...")
        model = fuse_model(model)

    if 1:
        trt_file = None
        decoder = None

    predictor = Predictor(
        model, exp, COCO_CLASSES, trt_file, decoder,
        "cpu", args.fp16, args.legacy,
    )
    while 1:
        if zed.grab(runtime_params) == sl.ERROR_CODE.SUCCESS:
            # -- Get the image
            zed.retrieve_image(image_left, sl.VIEW.LEFT)
            frame = image_left.get_data()
            frame = np.array(frame[:, :, :3], dtype=np.uint8)
            assert len(frame.shape) == 3
            assert frame.shape[2] == 3
            cv2.imwrite("junk.jpg", frame)
            # frame = cv2.imread("junk.jpg")
            outputs, img_info = predictor.inference(frame)
            print(f"{outputs=}")
            result_frame = predictor.visual(outputs[0], img_info, predictor.confthre)

            cv2.imshow("ZED | 2D View and Birds View", result_frame)
            key = cv2.waitKey(10)
            if key == 27:
                exit_signal = True
        else:
            exit_signal = True

    zed.close()


if __name__ == '__main__':
    args = make_parser().parse_args()
    exp = get_exp(args.exp_file, args.name)
    main(exp, args)
