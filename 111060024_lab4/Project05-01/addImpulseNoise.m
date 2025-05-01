function output_s = addImpulseNoise(input_s, Ps, Pp)
    [M, N] = size(input_s);
    total_pixel = M * N;
    salt_pixel = round(total_pixel * Ps);
    pepper_pixel = round(total_pixel * Pp);
    salt_indices = randperm(total_pixel, salt_pixel);
    pepper_indices = randperm(total_pixel, pepper_pixel);
    output_s = input_s;
    output_s(salt_indices) = 255;
    output_s(pepper_indices) = 0;

end