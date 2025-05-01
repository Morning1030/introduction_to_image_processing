function psnr = computePSNR(input1_s, input2_s)
    MSE = immse(input1_s, input2_s);
    psnr = 20 * log10(1 / sqrt(MSE));
end