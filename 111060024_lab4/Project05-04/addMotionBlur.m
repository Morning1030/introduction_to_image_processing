function [output_f, H] = addMotionBlur(input_f, T, a, b)
    [M, N] = size(input_f);
    % center at center of spectrum
    [u, v] = meshgrid(-M/2:M/2-1, -N/2:N/2-1);
    term = u * a + v * b;
    % H = T * sin(pi * term) * exp(-1j * pi * term) / (pi * term);
    H = zeros(M, N);

    idx_nonzero = term ~= 0;
    H(idx_nonzero) = T * sin(pi * term(idx_nonzero)) .* exp(-1j * pi * term(idx_nonzero)) ./ (pi * term(idx_nonzero));
    H(~idx_nonzero) = T;

    output_f = H .* input_f;
end