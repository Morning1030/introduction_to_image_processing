function histVector = imageHist(originalImage)
    flatten_image = originalImage(:);
    histVector = accumarray(flatten_image + 1, 1, [256, 1]);
end