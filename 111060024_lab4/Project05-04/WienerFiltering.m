function output_f = WienerFiltering(input_f, H, K)
    % % [u, v] = meshgrid(-M/2:M/2-1, -N/2:N/2-1);
    threshold = 0.003;
    abs_H_square = abs(H) .^ 2;
    wienerFilter = abs_H_square ./ (H .* (abs_H_square + K));
    wienerFilter(abs(H) < threshold) = 0;
    output_f = input_f .* wienerFilter;
end