function outputImage = reduceIntensityLevel(originalImage, intensityLevel)
    originalImage = double(originalImage);
    color = 255 / intensityLevel;
    % decide the color level of pixel must be integer
    outputImage = floor(originalImage / color);
    % decide color of each level
    outputImage = round(outputImage * 255 / (intensityLevel - 1));
    outputImage = uint8(outputImage);
end