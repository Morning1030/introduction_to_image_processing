function output_s = addGaussianNoise(input_s, mu, sigma)
    input_s = double(input_s);
    GaussianNoise = mu + sigma * randn(size(input_s));
    output_s = input_s + GaussianNoise;
    % Normalize
    min_val = min(output_s(:));
    max_val = max(output_s(:));
    output_s = 255 * (output_s - min_val) / (max_val - min_val);
    output_s = uint8(output_s);
end