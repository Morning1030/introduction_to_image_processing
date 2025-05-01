function output = spatialFiltering(input, mask)
    % padding zeros at the edge of the input image
    [maskRow, maskCol] = size(mask);
    [inputRow, inputCol] = size(input);
    padRow = floor(maskRow / 2);
    padCol = floor(maskCol / 2);
    paddedImage = padarray(input, [padRow, padCol]);
    paddedImage = double(paddedImage);
    output = zeros(inputRow, inputCol, 'single');
    % convelution
    for i = 1 : inputRow
        for j = 1 : inputCol
            area = paddedImage(i : i + maskRow - 1, j : j + maskCol - 1);
            output(i, j) = sum(sum(area .* mask));
        end
    end
end