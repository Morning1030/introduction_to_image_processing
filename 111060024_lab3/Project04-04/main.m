inputImage = imread('input.tif');
inputImage = im2single(inputImage);
inputImage_centered = center(inputImage);
D0 = input('what is D0\n');
F = fft2(inputImage_centered);
[M, N] = size(inputImage);
H = myGHPF(D0, M, N);
high_gaussianed = F .* H;
high_filtered_picture = ifft2(high_gaussianed);
high_filtered_picture = center(high_filtered_picture);
high_filtered_picture = real(high_filtered_picture);

figure
imshow(inputImage);
title('inputImage')
figure
imshow(high_filtered_picture, []);
title(sprintf('GHPF with D0 = %d', D0))

