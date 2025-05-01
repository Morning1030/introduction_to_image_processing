import os
import numpy as np
import cv2
import matplotlib.pyplot as plt
def read_folder(img_dir, depth_dir):
    img_depth_pair = []
    files_img = {f for f in os.listdir(img_dir) if f.lower().endswith('.jpg')}
    # files_depth = {f for f in os.listdir(depth_dir)}
    for filename in files_img:
        img_path = os.path.join(img_dir, filename)
        depth_path = os.path.join(depth_dir,filename.replace('.jpg', '.png'))
        img_depth_pair.append((img_path, depth_path))


# def write_image


def show_image(depth_map, image, original_marked, original_seamed):
    plt.figure()
    plt.imshow(depth_map, cmap='gray')
    plt.axis('off')
    plt.title('depth map')


    plt.figure()
    plt.imshow(image)
    plt.axis('off')
    plt.title('original image')

    plt.figure()
    plt.imshow(original_marked)
    plt.axis('off')
    plt.title('original image seam marked')

    plt.figure()
    plt.imshow(original_seamed)
    plt.axis('off')
    plt.title('original image seam removed')

    plt.show()