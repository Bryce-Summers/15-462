close all; clear all;

%2D FFT Demo

%http://matlabgeeks.com/tips-tutorials/how-to-do-a-2-d-fourier-transform-in-matlab/

% Import Images.
imageA = imread('MetroCenterEscalators','jpg');
%imageB = imread('MetroCenterEscalators','jpg');

%Limits the channels so that the matrix is only 2D.
imageA = imageA(:,:,1);
%imageB = imageB(:,:,1);

% Display images
figure, imshow(imageA)
title('Image A')
%figure, imshow(imageB)
%title('Image B')

%Perform 2D FFTs
fftA = fft2(double(imageA));

% -- Band Limit the FFT.
[rows, columns] = size(fftA);

%for i=0:9

fftB = fftshift(fftA);

%lower = .1*i;
%upper = lower + .1;

upper = 1.0;

for r=1:rows
  for c=1:columns

      dx = r - rows/2;
      dy = c - columns/2;
      
      dist = sqrt(dx*dx + dy*dy);
               
      %if ~(lower*rows/2 <= dist && dist <= upper*rows/2)
      if (dist <= rows/5)
      %if dist > rows/5
          
          fftB(r,c) = 0;
            
      end
  end
end


%Display magnitude and phase of proccessed 2D FFT.
figure, imshow(abs(fftB),[24 100000]), colormap gray
title('Image A FFT2 Magnitude')
figure, imshow(angle(fftB),[-pi pi]), colormap gray
title('Image A FFT2 Phase')

fftB = ifftshift(fftB);


%Switch magnitude and phase of 2D FFTs.

% Magnitude and phase based processing.
%fftC = abs(fftA).*exp(i*angle(fftA));

image_out = ifft2(fftB);

%Calculate limits for plotting.
cmin = min(min(abs(image_out)));
cmax = max(max(abs(image_out)));

%dmin = min(min(abs(imageD)));
%dmax = max(max(abs(imageD)));

%Display the proccessed image in an onscreen window.
figure, imshow(abs(image_out), [cmin cmax]), colormap gray
title('Image Out')


i = 0;
%Save images.
saveas(2 + 3*i,strcat('mag', int2str(i), int2str(i+1), '.png'))
saveas(3 + 3*i,strcat('phase', int2str(i), int2str(i+1), '.png'))
saveas(4 + 3*i,strcat('output', int2str(i), int2str(i+1), '.png'))

%end

