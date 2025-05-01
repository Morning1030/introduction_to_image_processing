function [output, scaledLaplacian] = laplacianFiltering(input, ...
    laplacianMask, scale)
    scaledLaplacian = scale * laplacianMask;
    scaledDifference = spatialFiltering(input, scaledLaplacian);
    figure
    imshow(scaledDifference)
    title('scaledDifference')
    output = input + scaledDifference;

end