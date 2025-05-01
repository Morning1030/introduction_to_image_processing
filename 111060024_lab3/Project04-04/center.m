function centered_image = center(input)
    [x, y] = meshgrid(0:size(input, 2) - 1, 0:size(input, 1) - 1);
    centered_image = input .* (-1).^(x + y);
end