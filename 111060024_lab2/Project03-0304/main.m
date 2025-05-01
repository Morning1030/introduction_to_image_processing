
originalImage = imread('input.tif');
originalImage = single(originalImage) / 255;
scale = input('please enter the scale\n');
mask = single([0 1 0; 1 -4 1; 0 1 0]);
mask2 = single([1 1 1; 1 -8 1; 1 1 1]);
mask3 = single([0 0 -1 0 0; 0 -1 -2 -1 0; -1 -2 16 -2 -1; 0 -1 -2 -1 0; 0 0 -1 0 0]);
mask4 = single([0  0  0 -1  0  0  0;
    0  0 -1 -2 -1  0  0;
    0 -1 -2 -3 -2 -1  0;
   -1 -2 -3 28 -3 -2 -1;
    0 -1 -2 -3 -2 -1  0;
    0  0 -1 -2 -1  0  0;
    0  0  0 -1  0  0  0]);
[output, scaledLaplacian] = laplacianFiltering(originalImage, mask, scale);
[output2, scaledLaplacian2] = laplacianFiltering(originalImage, mask2, scale);
[output3, scaledLaplacian3] = laplacianFiltering(originalImage, mask3, 1 / 16);
[output4, scaledLaplacian4] = laplacianFiltering(originalImage, mask4, 1 / 28);

figure
imshow(originalImage)
title('original image')
%figure
%imshow(scaledLaplacian)
%title('scaledLaplacian')
figure
imshow(output)
title(sprintf('laplatian filtered image, c = %.2f, kernel = fig3.45(a)', scale))

figure
imshow(output2)
title(sprintf('laplatian filtered image, c = %.2f, kernel = fig3.45(b)', scale))

figure
imshow(output3)
title(sprintf('laplatian filtered image, c = 1 / 16, kernel size = 5 * 5'))

figure
imshow(output4)
title(sprintf('laplatian filtered image, c = 1 / 28, kernel = 7 * 7'))
