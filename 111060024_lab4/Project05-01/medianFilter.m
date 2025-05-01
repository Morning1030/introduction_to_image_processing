function denoisedImage = medianFilter(inputImage)
    [M, N] = size(inputImage);
    denoisedImage = zeros(M, N, 'like', inputImage);
    for i = 2 : M - 1
        for j = 2 : N - 1
            block = inputImage(i - 1 : i + 1, j - 1 : j + 1);
            denoisedImage(i, j) = median(block(:));
        end
    end
    denoisedImage(1, :) = inputImage(1, :);
    denoisedImage(M, :) = inputImage(M, :);
    denoisedImage(:, 1) = inputImage(:, 1);
    denoisedImage(:, N) = inputImage(:, N);
end