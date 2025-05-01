function output = myIDFT2(input)
    [M, N] = size(input);
    output = zeros(M, N);
    for x = 0 : M - 1
        for y = 0 : N - 1
            sum = 0;
            for u = 0 : M - 1
                for v = 0 : N - 1
                    % f(x, y) = u from 0 to M-1, v from 0 to N-1, f(i, j)
                    % * e^(-j2pi * (ux / M + vy / N))
                    sum = sum + input(u+1, v+1)*exp((1j)*2*(pi)*((u*x/M)+(v*y/N)));
                end
            end
            output(x+1, y+1) = sum / (M * N);
        end
    end
end