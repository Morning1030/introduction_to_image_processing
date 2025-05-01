
% pwd
% cd C:\Users\imorn\OneDrive\桌面\影像處理\Lab01\Project02_02
originalImage = imread('Project02-02\input.tif');
% printPixel(originalImage);
intensityLevel = input('please enter the intensity level from 2 to 256\n');
quantizedImage = reduceIntensityLevel(originalImage, intensityLevel);
imshow(quantizedImage);