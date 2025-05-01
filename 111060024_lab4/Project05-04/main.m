inputImage = imread('input.tif');
inputImage = im2single(inputImage);
T = input('What is T of the motion blur?');
a = input('What is a of the motion blur?');
b = input('What is b of the motion blur?');
inputImageFreq = fft2(inputImage);
inputImageFreq = fftshift(inputImageFreq);
[MotionBlurredFreq, H] = addMotionBlur(inputImageFreq, T, a, b);
MotionBlurredImage = ifft2(MotionBlurredFreq);
MotionBlurredImage = real(MotionBlurredImage);
MotionBlurGaussianImage = addGaussianNoise(MotionBlurredImage, 0, 0);

% show inputImage
figure
imshow(inputImage, [])
title('inputImage')
% show image with motion blur
figure
imshow(MotionBlurredImage)
title('MotionBlurredImage')
% show image with Gaussian noise
figure
imshow(MotionBlurGaussianImage)
title('Motion blurred image with Gaussian noise of mu = 0, sigma = 0');


K = input('What is K parameter of the Wiener filter?');
MotionBlurGaussianFreq = fft2(MotionBlurGaussianImage);
WienerFilteredFreq = WienerFiltering(MotionBlurGaussianFreq, H, K);
WienerFiltered_image = ifft2(WienerFilteredFreq);
WienerFiltered_image = abs(WienerFiltered_image);
    % Normalize
    min_val = min(WienerFiltered_image(:));
    max_val = max(WienerFiltered_image(:));
    WienerFiltered_image = (WienerFiltered_image - min_val) / (max_val - min_val);

figure
imshow(real(MotionBlurGaussianFreq))
title('MotionBlurGaussianFreq')
% show image filtered by wiener
figure
imshow(WienerFiltered_image)
title(sprintf('WienerFiltered_image is K = %d', K));

psnr = computePSNR(inputImage, WienerFiltered_image);
fprintf("psnr = %f\n", psnr);

