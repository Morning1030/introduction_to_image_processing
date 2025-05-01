function output = myGHPF(D0, M, N)
    % H(u, v) = e^-D^2(u, v) / 2D0^2
    output = zeros(M, N);
    center_u = M / 2;
    center_v = N / 2;
    for u = 1 : M
        for v = 1 : N
            D_square = (u-center_u)^2 + (v-center_v)^2;
            output(u, v) = 1-exp((-1) * D_square/(2*D0^2));
        end
    end
    output = output / max(output(:));
end