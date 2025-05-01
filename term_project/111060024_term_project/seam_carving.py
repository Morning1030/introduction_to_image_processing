import numpy as np
import cv2
import matplotlib
# N means the number of seam carved
# main function of performing seamCarving
# def seamCarving(energy_map, image, N):


def dp_find_seam(energy_map):
    M, N = energy_map.shape
    dp = energy_map.copy()
    seam = np.zeros((M, ), dtype=int)
    for i in range(1, M):
        for j in range(N):
            up_left = dp[i - 1, j - 1] if j > 0 else np.inf
            up = dp[i - 1, j]
            up_right = dp[i - 1, j + 1] if j < (N-1) else np.inf
            
            dp[i, j] = min(up_left, up, up_right) + energy_map[i, j]
            if (dp[i, j] > 10000):
                print(dp[i, j])
    # entry with the smallest cumulative cost        
    seam[-1] = np.argmin(dp[-1])
    # backtracking
    for i in range(M - 2, -1, -1):
        prev_col_chosed = seam[i + 1] 
        possible = dp[i, max(prev_col_chosed-1, 0):min(prev_col_chosed+2, N-1)]
        # argmin returns index from 0 to 2
        seam[i] = np.argmin(possible) + max(prev_col_chosed - 1, 0)
    return seam

# image is original image
def mark_all_seam(image, seams):
    M, N, C = image.shape
    output = image.copy()
    for seam in seams:
        # print("2:", seam)
        for i, j in enumerate(seam):
            output[i, j] = [255, 0, 0]
    return output

def remove_seam(image, seam, index_map):
    # print(index_map.shape)
    # print(image.shape)
    M, N, C = image.shape
    mask = np.ones((M, N), dtype=bool)
    mask[np.arange(M), seam] = False
    image = image[mask].reshape(M, N - 1, C)
    index_map = index_map[mask].reshape(M, N - 1)
    return image, index_map
        