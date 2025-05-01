# import packages
import os
import numpy as np
import cv2
import matplotlib.pyplot as plt
import seam_carving
import image_io
# OPENCV IS IN BGR!!!!!
# use opencv to process but use plt.imshow() to show the image
np.set_printoptions(threshold=np.inf)
# read the value from depth map and transform to the parameter tau

def find_threshold(depth_map):
    # hist return number not probability
    hist, bin_edges = np.histogram(depth_map.flatten(), bins = 256, range=(0, 256))
    cdf = np.cumsum(hist * np.diff(bin_edges))
    M, N = depth_map.shape
    total_pixel = M * N
    global_sum = np.sum(hist * np.arange(256))
    best_threshold = 0
    max_var = 0
    class1_mean = 0
    class1_p = 0
    variance = 0
    for threshold in range(1, 256):
        class1_mean = np.sum(hist[:threshold] * np.arange(threshold)) / np.sum(hist[:threshold])
        class1_p = np.sum(hist[:threshold]) / total_pixel
        class2_mean = (global_sum - np.sum(hist[:threshold] * np.arange(threshold))) / np.sum(hist[threshold:])
        variance = (class1_p) * (1 - class1_p) * np.square(class1_mean - class2_mean)
        if variance > max_var:
            best_threshold = threshold
            max_var = variance
    return best_threshold
        
        
        


def kappa_transformation(depth_map, kappa_max, kappa_min, c, threshold):
    # t0 = (-1 / c) * np.log(np.log(0.5) / -0.69)
    # depth_map = depth_map / 255
    kappa = (kappa_max - kappa_min) * np.exp(-0.69 * np.exp(-1 * c * (depth_map - threshold))) + kappa_min
    # print(kappa)
    # print(kappa.shape)
    return kappa
    
# self-guided filter
def selfGuidedFilter(image, patch_radius, kappa, epsilon):
    image = np.astype(image, np.float64)
    pad_radius = patch_radius // 2
    patch_pixel = patch_radius ** 2
    padded_image = cv2.copyMakeBorder(image, pad_radius, pad_radius,
                                      pad_radius, pad_radius, cv2.BORDER_REFLECT)
    padded_kappa = cv2.copyMakeBorder(kappa, pad_radius, pad_radius,
                                      pad_radius, pad_radius, cv2.BORDER_REFLECT)
    average_kernel = np.ones((patch_radius, patch_radius), np.float64) / patch_pixel
    padded_image = padded_image.astype(np.float64)
    output = np.zeros_like(image, np.float64)
    local_mean = np.zeros_like(padded_image, np.float64)
    local_var = np.zeros_like(padded_image, np.float64)
    a = np.zeros_like(padded_image, np.float64)
    alpha = np.zeros_like(padded_image, np.float64)
    w_alpha = np.zeros_like(padded_image)
    w_1minus_alpha_mean = np.zeros_like(padded_image)
    weighted_alpha = np.zeros_like(image)
    weighted_1minus_alpha_mean = np.zeros_like(image)
    
    M, N, C = image.shape
    # seperate each color component
    for c in range(C):
        
        local_mean = cv2.filter2D(padded_image[:, :, c], -1, average_kernel) # range from [0, 255]
        local_var = cv2.filter2D(np.square(padded_image[:, :, c]), -1, average_kernel) - np.square(local_mean)
        # print(local_mean)
        negative_mask = local_var < 0
        local_var[negative_mask] = 0

        # got a and alpha for each patch
        a = local_var / (local_var + epsilon)
        alpha = 0.5 * (a + np.sqrt(np.power(a, 2) + 4 * padded_kappa * (1 - a)))
        # print(alpha)
         
        negative_mask = a > 1
        # a[negative_mask] = 0
        # print(np.sum(a[negative_mask]))
        
        negative_mask = alpha > 1
        # print(np.sum(alpha[negative_mask]))
        # local_var[negative_mask] = 0
        
        w_alpha = cv2.filter2D(alpha, -1, average_kernel)
        w_1minus_alpha_mean = cv2.filter2D((1 - alpha) * local_mean, -1, average_kernel)
        weighted_alpha = w_alpha[pad_radius : -pad_radius, pad_radius : -pad_radius]
        weighted_1minus_alpha_mean = w_1minus_alpha_mean[pad_radius : -pad_radius, pad_radius : -pad_radius]
        output[:, :, c] = image[:, :, c] * weighted_alpha + weighted_1minus_alpha_mean
        output[:, :, c] = np.clip(output[:, :, c], 0, 255)
        
        # output[:, :, c] = (output[:, :, c] - np.min(output[:, :, c])) / (np.max(output[:, :, c]) - np.min(output[:, :, c]))
    output_uint8 = output.astype(np.uint8)
    return output_uint8
                

"""
    calculate the energy map(by magnitude of gradient) of an image
    using Sobel operator
"""
def energy_calc(image):
    # normalize first
    image = image.astype(np.float64) / 255.0
    gradient = np.zeros_like(image)
    # print(image)
    # print(image.shape)
    for cc in range(image.shape[2]):
        grad_x = cv2.Sobel(image[:, :, cc], -1, dx=1, dy=0, ksize=3)
        grad_y = cv2.Sobel(image[:, :, cc], -1, dx=0, dy=1, ksize=3)
        gradient[:, :, cc] = np.abs(grad_x) + np.abs(grad_y)
    gradient = np.sum(gradient, axis=2)
    # print(gradient)
    print(gradient.shape)
    return gradient

def n_seam_carving(image, num_seam):
    output = image.copy()
    M, N, C = image.shape
    index_map = np.tile(np.arange(N), (M, 1))
    frames = []
    # print("index_map", index_map.shape)
    # print(index_map)
    seams = np.zeros((num_seam, M), dtype=int)
    for _iter in range(num_seam):
        energy_map = energy_calc(output)
        seam = seam_carving.dp_find_seam(energy_map)
        for i, j in enumerate(seam):
            output[i, j] = [255, 0, 0]
        # frames.append(output)
        # print("1:", seam)
        seams[_iter, :] = index_map[np.arange(M), seam]
        # print(seams.shape)
        # print("1.5", seams)
        output, index_map = seam_carving.remove_seam(output, seam, index_map)
        frames.append(output)
        # print(output.shape, index_map.shape)
    marked_image = seam_carving.mark_all_seam(image, seams)
    # imageio.mimsave(gif_dir, frames, fps=2)
    return marked_image, output

# read the image from the directory
file_name = '2007_000042'
depth_dir = 'image_data/depth_map/'
img_dir = 'image_data/image/'
# gif_dir_org = 'result/original_seam_carving.gif'
# gif_dir_fil = 'result/filtered_seam_carving.git'
kappaMax = 10
kappaMin = 0
c = 10
threshold = 0.25
patchRadius = 5
epsilon = 100

image = cv2.imread(img_dir + file_name + '.jpg', cv2.IMREAD_UNCHANGED)
depth_map = cv2.imread(depth_dir + file_name + '.png', cv2.IMREAD_COLOR)

image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

depth_map = cv2.cvtColor(depth_map, cv2.COLOR_RGBA2GRAY)
depth_norm = depth_map / 255
th_num = find_threshold(depth_map)
th = th_num / 256
hist, bin_edges = np.histogram(depth_map.flatten(), bins = 256, range=(0, 256), density=True)
cdf = np.cumsum(hist * np.diff(bin_edges))
print("th = ", th)


kappa = kappa_transformation(depth_norm, kappaMax, kappaMin, c, th)

filtered_image = selfGuidedFilter(image, patchRadius, kappa, epsilon)
# differnece_image = filtered_image - image
# print(differnece_image)
img_energy_map = energy_calc(image)
filtered_energy_map = energy_calc(filtered_image)

original_marked, original_seamed = n_seam_carving(image, 50)
filtered_marked, filtered_seamed = n_seam_carving(filtered_image, 50)

image_io.show_image(depth_map, kappa, img_energy_map, filtered_energy_map, image, filtered_image, \
    original_marked, filtered_marked, original_seamed, filtered_seamed)


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

plt.figure()
plt.hist(depth_map.flatten(), bins=256, range=(0, 256), density=True)
plt.plot(bin_edges[:-1], cdf, color='green', linestyle='-')
plt.axvline(x=th_num, color='r', linestyle='--')
plt.xlabel('depth map intensity')
plt.ylabel('probability of intensity')
plt.title('Histogram of depth map with cdf')


plt.figure()
plt.hist(depth_map.flatten(), bins=256, range=(0, 256), density=True)
# plt.plot(bin_edges[:-1], cdf, color='green', linestyle='-')
plt.axvline(x=th_num, color='r', linestyle='--')
plt.xlabel('depth map intensity')
plt.ylabel('probability of intensity')
plt.title('Histogram of depth map')
plt.show()
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

