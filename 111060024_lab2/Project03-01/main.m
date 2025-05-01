
originalImage = imread('input.tif');
originalImage = single(originalImage) / 255;
c_log = input('Please input c parameter for logTransform');
logTransformedImage = logTransform(originalImage, c_log);
% r_powerlaw = input('Please input r for power transformation\n');
% powerTransformedImage = powerlawTransform(originalImage, 1, r_powerlaw);
figure
imshow(originalImage)
title('original image')
figure
imshow(logTransformedImage)
title(sprintf('log transformation with c = %.2f', c_log))
%figure
%imshow(powerTransformedImage)
%title(sprintf('power-law transformation with r = %.2f', r_powerlaw))

