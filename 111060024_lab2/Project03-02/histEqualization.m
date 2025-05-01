function [output, T] = histEqualization(originalImage)
    histVector = imageHist(originalImage);
    % get the size of the image m * n
    total_pixel = numel(originalImage);
    % print(total_pixel)
    % pdf of the image
    pdf = histVector / total_pixel;
    % print(pdf)
    T = round(255 * cumsum(pdf));
    T = min(T, 255);
    output = T(double(originalImage) + 1);
    figure
    imshow(uint8(output))
    title('hisEqualization')

    figure
    stairs(0:255, T, 'r-', 'LineWidth', 2)
    xlabel('Pixel Intensity')
    ylabel('Transformed Intensity')
    title('Transformation Function')
    grid on;

end