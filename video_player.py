from pathlib import Path
import cv2

import argparse

parser = argparse.ArgumentParser(description="movie player")
parser.add_argument("src", help="video source")
args = parser.parse_args()

src = Path(args.src)

cap = cv2.VideoCapture(str(src))

while True:
    r, image = cap.read()
    if image is None:
        break
    cv2.imshow("video", image)

    key = cv2.waitKey(1)
    if key & 0xff == ord('q'):
        break
cv2.destroyAllWindows()

