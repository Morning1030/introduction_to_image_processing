function output_s = addSinNoise(input_s, A, u0, v0)
    [M, N] = size(input_s);
    [x, y] = meshgrid(1 : M, 1 : N);
    sin_noise = A * sin(2 * pi * (u0 * x / M + v0 * y / N));
    output_s = input_s + sin_noise;
end