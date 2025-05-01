% original image, original image's Histogram
% output image, output image's Histogram
% the transformation function
% pwd
% cd '111060024_lab2\Project03-02'

originalImage = imread('input.tif');
[output, T] = histEqualization(originalImage);
figure
imshow(originalImage)
title('originalImage')


figure
subplot(2, 1, 1)
histVector_original = imageHist(originalImage);
plot(0:255, histVector_original, 'LineWidth', 2)
xlim([0 255])
xlabel('Pixel Intensity')
ylabel('Frequency')
title('Histogram of the Original Image')

subplot(2, 1, 2)
histVector_output = imageHist(output);
plot(0:255, histVector_output, 'LineWidth', 2)
xlim([0 255])
xlabel('Pixel Intensity')
ylabel('Frequency')
title('Histogram of the Output Image')