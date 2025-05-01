
function outputImage = resizeImage_replication(originalImage, scalingFactor)
    % get the size of the image
    [rows, columns] = size(originalImage);
    new_row = floor(rows * scalingFactor); new_col = floor(columns * scalingFactor);
    % fprintf("row = %d, col = %d\n", rows, columns);
    % fprintf("new_row = %d, new_col = %d\n", new_row, new_col);
    % generate the image
    % outputImage = zeros(new_row, new_col, 'like', originalImage);

    %for i = 1 : new_row
    %   for j = 1 : new_col
    %        sample_i = ceil(i / scalingFactor); sample_j = ceil(j / scalingFactor);
            
    %        outputImage(i, j) = originalImage(sample_i, sample_j);
    %    end
    %end
    row_indices = ceil((1:new_row) / scalingFactor);
    col_indices = ceil((1:new_col) / scalingFactor);
    outputImage = originalImage(row_indices, col_indices);
end