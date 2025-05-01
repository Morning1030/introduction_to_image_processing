
function outputImage = resizeImage_bilinear(originalImage, scalingFactor)
    [rows, columns] = size(originalImage);
    new_row = floor(rows * scalingFactor);
    new_col = floor(columns * scalingFactor);
    % fprintf("row = %d, col = %d\n", rows, columns);
    % fprintf("new_row = %d, new_col = %d\n", new_row, new_col);

    % create the resize matrix
    [new_x, new_y] = meshgrid(1:new_col, 1:new_row);

    % find the neighbor of the pixel
    original_x = (new_x - 1) / scalingFactor + 1;
    original_y = (new_y - 1) / scalingFactor + 1;
    X1 = max(1, floor(original_x));
    Y1 = max(1, floor(original_y));
    X2 = min(X1 + 1, columns - 1);
    Y2 = min(Y1 + 1, rows - 1);

    Q11 = double(originalImage(Y1 + (X1 - 1) * rows));
    Q12 = double(originalImage(Y2 + (X1 - 1) * rows));
    Q21 = double(originalImage(Y1 + (X2 - 1) * rows));
    Q22 = double(originalImage(Y2 + (X2 - 1) * rows));


    % Q11 = double(originalImage(sub2ind([rows, columns], Y1, X1)));
    % Q12 = double(originalImage(sub2ind([rows, columns], Y2, X1)));
    % Q21 = double(originalImage(sub2ind([rows, columns], Y1, X2)));
    % Q22 = double(originalImage(sub2ind([rows, columns], Y2, X2)));


    delta_x = original_x - X1;
    delta_y = original_y - Y1;

    C1 = (1 - delta_x) .* (1 - delta_y);
    C2 = (1 - delta_x) .* delta_y;
    C3 = delta_x .* (1 - delta_y);
    C4 = delta_x .* delta_y;
    outputImage = C1 .* Q11 + C2 .* Q12 + C3 .* Q21 + C4 .* Q22;
    outputImage = uint8(outputImage);
end