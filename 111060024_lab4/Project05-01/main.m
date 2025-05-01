inputImage = imread('input.tif');
mu = input('What is mu for Gaussian function?');
sigma = input('What is sigma for Gaussian function?');
GaussianNoised = addGaussianNoise(inputImage, mu, sigma);
GaussianDenoised = averageFilter(GaussianNoised);
Ps = input('What is propability for salt noise?');
Pp = input('What is propability for pepper noise?');
PepperSaltNoised = addImpulseNoise(inputImage, Ps, Pp);
PepperSaltDenoised = medianFilter(PepperSaltNoised);
figure
imshow(inputImage)
title('inputImage')
figure
imshow(GaussianNoised)
title(sprintf('image with Gaussian noise, mu = %f, sigma = %f', mu, sigma))
figure
imshow(GaussianDenoised)
title('Gaussian Denoised by average filter')
psnrgaussian = computePSNR(inputImage, GaussianNoised);
psnrgaussiandenoise = computePSNR(inputImage, GaussianDenoised);
fprintf("psnrgaussian = %f\n", psnrgaussian)
fprintf("psnrgaussiandenoise = %f\n", psnrgaussiandenoise)


figure
imshow(PepperSaltNoised)
title(sprintf('image with pepper-salt noise, Pp = %f, Ps = %f', Pp, Ps))
figure
imshow(PepperSaltDenoised)
title('PepperSalt Denoised by median filter')

psnrpeppersalt = computePSNR(inputImage, PepperSaltNoised);
psnrpeppersaltdenoise = computePSNR(inputImage, PepperSaltDenoised);
fprintf("psnrpeppersalt = %f\n", psnrpeppersalt)
fprintf("psnrpeppersaltdenoise = %f\n", psnrpeppersaltdenoise)



