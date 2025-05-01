function denoisedImage = averageFilter(inputImage)
    inputImage = im2double(inputImage);
    [M, N] = size(inputImage);
    paddedImage = padarray(inputImage, [1, 1], 'replicate');
    denoisedImage = zeros(M, N);
    for i = 1 : M
        for j = 1 : N
            block = paddedImage(i : i + 2, j : j + 2);
            denoisedImage(i, j) = mean(block(:));
        end
    end
    min_val = min(denoisedImage(:));
    max_val = max(denoisedImage(:));
    denoisedImage = (denoisedImage - min_val) / (max_val - min_val);
    denoisedImage = im2uint8(denoisedImage);
end