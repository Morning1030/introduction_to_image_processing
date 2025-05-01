
%cd C:\Users\imorn\OneDrive\桌面\影像處理\Lab01
originalImage = imread('Project02-03\input.tif');
scalingFactor = input('please enter the scaling factor\n');
resizedImage = resizeImage_replication(originalImage, scalingFactor);
% middleImage = resizeImage_replication(originalImage, scalingFactor);
% imwrite(middleImage, 'middleImage.tif');
% scalingFactor2 = input('please enter the scaling factor2\n');
% resizedImage = resizeImage_replication(middleImage, scalingFactor2);
figure;
imshow(originalImage);
title('originalImage');
% figure;
% imshow(middleImage);
% title('middleImage');
figure;
imshow(resizedImage);
title('resizeImage');


