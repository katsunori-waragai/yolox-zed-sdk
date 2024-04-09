import cv2
print(f"{cv2.__version__=}")
print(f"{cv2.__file__=}")

name = "dog.jpg"
image = cv2.imread(name)
cv2.namedWindow(name, cv2.WINDOW_NORMAL)
cv2.imshow(name, image)
key = cv2.waitKey(-1)
cv2.destroyAllWindows()
