inputImage = imread('input.tif');
inputImage = im2single(inputImage);
[M, N] = size(inputImage);
% padding
padded_image = padarray(inputImage, [M, N], 'post');
% inputImage = imresize(inputImage, 256 / 1026);
% center the image by mutiplying -1^(x + y)
centered_input = center(padded_image);
F = fft2(centered_input);
F = log(1 + abs(F));
% F = mat2gray(F);
figure
imshow(inputImage)
title('inputImage')

figure
imshow(F, [])
title('Fourier spectrum')


function centered_image = center(input)
    [x, y] = meshgrid(0:size(input, 2) - 1, 0:size(input, 1) - 1);
    centered_image = input .* (-1).^(x + y);
end