function output = myDFT2(input)
    % get the size of the matrix
    [M, N] = size(input);
    % create a dft matrix
    output = zeros(M, N);
    for u = 0 : M - 1
        for v = 0 : N - 1
            sum = 0;
            for x = 0 : M - 1
                for y = 0 : N - 1
                    % F(u, v) = x from 0 to M-1, y from 0 to N-1, f(i, j)
                    % * e^(j2pi * (ux / M + vy / N))
                    sum = sum + input(x+1, y+1)*exp((-1j)*2*(pi)*((u*x/M)+(v*y/N)));
                end
            end
            output(u+1, v+1) = sum;
        end
    end
end