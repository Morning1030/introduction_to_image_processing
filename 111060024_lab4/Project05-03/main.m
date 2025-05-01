inputImage = imread('input.tif');
inputImage = im2single(inputImage);
A = input('What is A of the sin noise?');
u0 = input('What is u0 of the sin noise?');
v0 = input('What is v0 of the sin noise?');
sinNoiseImage = addSinNoise(inputImage, A, u0, v0);
sinNoisepsnr = computePSNR(inputImage, sinNoiseImage);
fprintf("sinNoisepsnr is %d\n", sinNoisepsnr)
% original image
figure
imshow(inputImage, [])
title('inputImage')
% spatial domain add noise
figure
imshow(sinNoiseImage, [])
title(sprintf('sinNoiseImage on spatial domain with A = %f, u0 = %d, v0 = %d', A, u0, v0))
sinNoiseImageFreq = fft2(sinNoiseImage);
sinNoiseImageFreq = fftshift(sinNoiseImageFreq);
%sinNoiseImageFreq = real(sinNoiseImageFreq);
D0 = input('What is D0 of the notch filter?');
[notchFiltered, Notch] = notchFiltering(sinNoiseImageFreq, D0, u0, v0);
notchFiltered = ifftshift(notchFiltered);
notchFiltered_image = ifft2(notchFiltered);

notchFiltered_image = real(notchFiltered_image);
notchedFilterpsnr = computePSNR(inputImage, notchFiltered_image);
fprintf("notchFilteredpsnr is %d\n", notchedFilterpsnr)
% turn to frequency domain
figure
imshow(real(sinNoiseImageFreq))
title('sinNoiseImage on frequency domain')
% Notch filter
figure
imshow(Notch)
title(sprintf('Notch filter with D0 = %d', D0))
% Notch filtered frequency
figure
imshow(real(notchFiltered))
title('notchFilteredImage on frequency domain')
% Notch filtered spatial
figure
imshow(notchFiltered_image)
title('notchFilteredImage on spatial domain')



