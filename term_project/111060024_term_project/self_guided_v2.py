# import packages
import os
import numpy as np
import cv2
import matplotlib.pyplot as plt
import seam_carving
import image_io_v2
# OPENCV IS IN BGR!!!!!
# use opencv to process but use plt.imshow() to show the image


def n_seam_carving(reference_image, target_image, num_seam):
    r = reference_image.copy()
    output = target_image.copy()
    M, N = reference_image.shape
    index_map = np.tile(np.arange(N), (M, 1))
    frames = []
    # print("index_map", index_map.shape)
    # print(index_map)
    seams = np.zeros((num_seam, M), dtype=int)
    for _iter in range(num_seam):
        seam = seam_carving.dp_find_seam(r)
        for i, j in enumerate(seam):
            target_image[i, j] = [255, 0, 0]
        # frames.append(output)
        # print("1:", seam)
        seams[_iter, :] = index_map[np.arange(M), seam]
        # print(seams.shape)
        # print("1.5", seams)
        output, index_map = seam_carving.remove_seam(output, seam, index_map)
        frames.append(output)
        # print(output.shape, index_map.shape)
    marked_image = seam_carving.mark_all_seam(target_image, seams)
    # imageio.mimsave(gif_dir, frames, fps=2)
    return marked_image, output

# read the image from the directory
file_name = '2007_000504'
depth_dir = 'image_data/depth_map/'
img_dir = 'image_data/image/'


image = cv2.imread(img_dir + file_name + '.jpg', cv2.IMREAD_UNCHANGED)
depth_map = cv2.imread(depth_dir + file_name + '.png', cv2.IMREAD_COLOR)

image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

depth_map = cv2.cvtColor(depth_map, cv2.COLOR_RGBA2GRAY)
depth_norm = depth_map / 255

original_marked, original_seamed = n_seam_carving(depth_norm, image, 50)
# original_marked, original_seamed = n_seam_carving(image, 50)
# filtered_marked, filtered_seamed = n_seam_carving(depth_map, filtered_image, 50)

image_io_v2.show_image(depth_map, image, original_marked, original_seamed)


# difference = filtered_energy_map - img_energy_map
# # print(difference)
# unique_values = np.unique(difference)
# counts = len(unique_values)
# print("there are", counts, "value in difference")
# difference_hist = cv2.calcHist([difference.astype(np.float32)], [0], None, [11], [-0.1, 1])

# hist = cv2.calcHist([depth_map.astype(np.float32)], [0], None, [256], [0, 255])
# hist = hist / np.sum(hist)
# # print("hist.sum", hist.sum())
# cumulative_hist = np.cumsum(hist)
# cumulative_hist = cumulative_hist / cumulative_hist[-1]

# plt.axvline(x=th, color='r', linestyle='--')
# plt.title("Histogram with Otsu's Threshold")
# plt.figure(figsize=(8, 10))

# 畫直方圖（藍色）
# plt.plot(np.linspace(0, 255, 256), hist, color='blue', label='Normalized Histogram')

# 畫累計直方圖（紅色）
# plt.plot(np.linspace(0, 255, 256), cumulative_hist, color='red', label='Cumulative Histogram')
# plt.yticks(np.arange(0, 0.18, 0.005))  # 可以根據需要調整刻度
# plt.xticks(np.arange(0, 255, 1))
# plt.figure()
# plt.imshow(image)
# plt.axis('off')

# plt.figure(figsize=(8, 10))

# plt.plot(np.linspace(-0.1, 1, 11), difference_hist, color='blue', label='Normalized Histogram')

# plt.yticks(np.arange(0, 90000, 2000))  # 可以根據需要調整刻度
# plt.xticks(np.arange(-0.1, 1, 0.1))

