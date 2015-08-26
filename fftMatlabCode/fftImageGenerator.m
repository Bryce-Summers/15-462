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
%fftB = fft2(double(imageB));


% -- Band Limit the FFT.
[rows, columns] = size(fftA);
 
lower = .9;
upper = 1.0;

bound_lower_c = columns*lower;
bound_lower_r = rows*lower;

bound_higher_c = columns*upper;
bound_higher_r = rows*upper;
 

for r=1:rows
  for c=1:columns
      %if ~((r < bound_higher_r && c < bound_higher_c) && (r > bound_lower_r || c > bound_lower_c))
         
       if r > rows*99/100 || c > columns*99/100   
          
          fftA(r,c) = 0;%(fftA(r,c) .* .05);
            
      end
  end
end


%Display magnitude and phase of proccessed 2D FFT.
figure, imshow(abs(fftshift(fftA)),[24 100000]), colormap gray
title('Image A FFT2 Magnitude')
figure, imshow(angle(fftshift(fftA)),[-pi pi]), colormap gray
title('Image A FFT2 Phase')



%Switch magnitude and phase of 2D FFTs.

fftC = abs(fftA).*exp(i*angle(fftA));
%fftD = abs(fftB).*exp(i*angle(fftA));


%Perform inverse 2D FFTs on switched images.
imageC = ifft2(fftC);
%imageD = ifft2(fftD);

%Calculate limits for plotting.
cmin = min(min(abs(imageC)));
cmax = max(max(abs(imageC)));

%dmin = min(min(abs(imageD)));
%dmax = max(max(abs(imageD)));

%Display switched images.
figure, imshow(abs(imageC), [cmin cmax]), colormap gray
title('Image C  Magnitude')
%figure, imshow(abs(imageD), [dmin dmax]), colormap gray
%title('Image D  Magnitude')

%Save images.
%saveas(1,'imageA.jpg')
saveas(2,'magnitude.png')
saveas(3,'phase.png')
saveas(4,'final.png')
%saveas(5,'imageBfftmag.png')
%saveas(6,'imageBfftpha.png')
%saveas(7,'imageC.png')
%saveas(8,'imageD.png')


