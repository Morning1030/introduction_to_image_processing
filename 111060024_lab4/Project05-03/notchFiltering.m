function [output_f, Notch] = notchFiltering(input_f, D0, u0, v0)
    [M, N] = size(input_f);
    [u, v] = meshgrid(1 : M, 1 : N);
    % compute the distance D1 and D2
    D1_sqr = (u - M / 2 - u0).^2 + (v - N / 2 - v0).^2;
    D2_sqr = (u - M / 2 + u0).^2 + (v - N / 2 + v0).^2;
    Notch = ones(M, N);
    Notch(D1_sqr <= D0^2 | D2_sqr <= D0^2) = 0;
    output_f = input_f .* Notch;
end