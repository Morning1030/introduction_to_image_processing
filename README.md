## Introduction to Image Processing

I learned classical methods to process image in this course, and have completed 6 labs in total.
The labs are written in Matlab, to take a quick look of the image result and discussion, you can refer to the report. To dig in implementation details, check out Matlab source files.
In Matlab implementation, one of the biggest difficulty is actually making sure is what precision the pixel is represented. To correctly show the image, convertion of integer and float type is often necessary.


### Lab 1: scale of intensity level and image size
This is a basic work of reducing the number of intensity level to smaller size, for example, from 256 to 16 levels.
Secondly, I've also implemented two ways of enlarging image size: neighbor pixel replication and bilinear interpolation.

### Lab 2: Image intensity enhancement, Histogram equalization, and spatial filtering (Laplacian Filter)
This lab includes three tasks about the intensity processing of image on its spatial domain.
We could adjust the image's representation to a version which shows the detail clearer by log transformation or histogram analysis of the image.

Another method we could apply on the image is edge detection, extracting the edge feature and it. This could be a useful way of preprocessing to image for further tasks.
Laplacian filter calculates the second order gradient by applying the kernel locally. Another famous operator similar to this is the Sobel operation, which extract the edge by first order gradient on single direction.

### Lab 3: Processing filter on image's frequency domain
This lab inspects the image from its frequency domain
First, I implement the discrete Fourier transform function to the image(there are classic version and fast-Fourier transform)
Then, the lowpass filter and highpass filter is applied to the frequency domain of the image. Lowpass filter extracted the blurry feature, while highpass filter extracted the sharp feature.

### Lab 4: Noise type and filtering
This lab introduces some kind of noise seen in image, and the filter applied to denoise.

First, I implemented two noise generators in this lab: the Gaussian noise and impluse noise(also known as salt-and-pepper). Then, a local-mean filter / local-min-max filter is applied to denoise the image.

Second, I simulated the situation which the image is polluted by a sin wave noise, then tried to denoise by applying Notch filter. The performance of the filter is evaluted by PSNR of the image.

Last, I polluted the image with motion-blur, then applied Wiener filter to denoise. The performace is compared by the PSNR of the image.
