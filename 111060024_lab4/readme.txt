Digital Image Processing Lab04
Introduction
    Before starting the following program, user should download MATLAB and open the main.m file via it. The input image is already
inside the same file as main.m. Press down the "Run" button at right top to start running the program.

Project05-01
	This program prompts for four parameter that will be needed to generate the noise that will be added to the image. The first
and second one is mu and sigma, meaning the means and standard deviation of the Gaussian function. A mean of zero is recommanded.
Next, it prompts for the density of pepper and salt noises, Pp stands for probability of pepper, and Ps stands for probability of salt.
Please enter floating point number that is between 0 to 1. Then the program gives the result image plus the denoised result image. It
also outputs the pSNR of each denoise model compared with the pSNR of each noise applied image.

Project05-03
    This program prompts for four parameter that will be used in the sin noise and the Notch filter. A is the amplitude of the noise,
a floating point at 0.2 to 0.5 is recommanded. Please enter integer for u0 and v0, the upper bound is about 300. The input image and
image with noise shows up. Then it prompt for D0, it is for the parameter of the Notch filter, to denoise the sinNoise, you can enter
 a integer that is as same as u0 and v0, are close to them. The pSNR of the noised image and denoised image will be printed out at
the terminal, you can check whether its relationship make sense.

Project05-04
    In this project, the programe prompt for T, a, and b parameter of the motion blur at first, you can decide how your motion blur
at this stage(direction, amplitude). Then it prompts for the constant K, which will be included into the calculation of Wiener filter.
It gives out five images including the input image, the degradation image caused by motion blur, the image with Gaussian noise added
onto it, and the frequency spectrum of such image. After you input K, it gives out the restoration result image, and pSNR of the
restoration image compared with the input image.