import cv2
import numpy as np

# image path
IMG_PATH = "img_27.jpg"

# read grayscale
img = cv2.imread(IMG_PATH, cv2.IMREAD_GRAYSCALE)

if img is None:
    print("Image not found")
    exit()

# resize to 28x28
img = cv2.resize(img, (28, 28))

# invert if needed (MNIST style: white digit on black background)
# img = 255 - img

# normalize to 0-1
img = img / 255.0

# FIX: convert to uint8 (0 to 255) to match the int8 quantization scale used during training.
# The original code used * 127, halving the input dynamic range and producing
# weak activations in the conv layer. Weights were quantized assuming 0..255 range.
img_int8 = np.round(img * 255).astype(np.uint8)

# flatten
img_flat = img_int8.flatten()

# save hex
with open("img.hex", "w") as f:
    for pixel in img_flat:
        f.write(f"{int(pixel) & 0xFF:02x}\n")  # cast to Python int before & 

print("img.hex generated")
print("Shape:", img_int8.shape)