inputImage = imread('input.tif');
inputImage = im2single(inputImage);
inputImage_centered = center(inputImage);
D0 = input('what is D0\n');
F = fft2(inputImage_centered);
[M, N] = size(inputImage);
H = myGLPF(D0, M, N);
low_gaussianed = F .* H;
low_filtered_picture = ifft2(low_gaussianed);
low_filtered_picture = real(low_filtered_picture);
low_filtered_picture = center(low_filtered_picture);
figure
imshow(inputImage);
title('inputImage')
figure
imshow(low_filtered_picture, []);
title(sprintf('GLPF with D0 = %d', D0))

