
originalImage = imread('Project02-04\input.tif');
scalingFactor = input('please input the scaling factor\n');
resizedImage = resizeImage_bilinear(originalImage, scalingFactor);
% middleImage = resizeImage_bilinear(originalImage, scalingFactor);
% imwrite(middleImage, 'middleImage.tif');
% scalingFactor2 = input('please enter the scaling factor2\n');
% resizedImage = resizeImage_bilinear(middleImage, scalingFactor2);
figure;
imshow(originalImage);
title('originalImage');
% figure;
% imshow(middleImage);
% title('middleImage');
figure;
imshow(resizedImage);
title('resizeImage');