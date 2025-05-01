function output = myGLPF(D0, M, N)
    % H(u, v) = e^-D^2(u, v) / 2D0^2
    output = zeros(M, N);
    center_u = M / 2;
    center_v = N / 2;
    for u = 1 : M
        for v = 1 : N
            output(u, v) = exp(-((u-center_u)^2 + (v-center_v)^2)/(2*D0^2));
        end
    end
end