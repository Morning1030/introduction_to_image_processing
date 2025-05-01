inputImage = imread('input.tif');
inputImage = im2single(inputImage);
inputImage = imresize(inputImage, 256 / 1026);
figure
imshow(inputImage)
title('inputImage')
% padding 
[M, N] = size(inputImage);
padded_image = zeros(2 * M, 2 * N, 'single');
padded_image(1:M, 1:N) = inputImage;
figure
imshow(padded_image)
title('padded image')
% center the image by mutiplying -1^(x + y)
centered_input = center(padded_image);
centered_nonpad = center(inputImage);
figure
imshow(centered_input)
title('centered image')
% DFT2
F = myDFT2(centered_nonpad);
% F2 = fft2(centered_input);
% take log
spectrum_log = log(1 + abs(F));
% spectrum2_log = log(1 + abs(F2));
% normalized
spectrum_norm = mat2gray(spectrum_log);
% spectrum2_norm = mat2gray(spectrum2_log);
figure
imshow(spectrum_norm)
title('spectrum of F')
% figure
% imshow(spectrum2_norm)
% title('spectrum of F2')
% Gaussian filter
GLPF = myGLPF(10, M, N);
figure
imshow(GLPF)
title('Gaussian filter')
low_gaussianed = real(F) .* GLPF;
figure
imshow(low_gaussianed)
title('F * Gaussian filter')
low_gaussianed_picture = myIDFT2(low_gaussianed);
low_gaussianed_picture = real(low_gaussianed_picture);
low_gaussianed_picture = center(low_gaussianed_picture);
figure
imshow(low_gaussianed_picture)
title('low_gaussianed_picture')
% low_gaussianed_picture = myIDFT2(low_gaussianed);
% low_gaussianed_picture = real(low_gaussianed_picture);
% low_gaussianed_picture = center(low_gaussianed_picture);
% take away the padding
no_padding = low_gaussianed_picture(1:M, 1:N);
figure
imshow(no_padding)
title('no_padding')


