clc;

image=imread('D:\priya\project-spiht\standard_test_images\7.gif');
 %image1=rgb2gray(im);
% image=image1(:);
figure(1)
imshow(image);

createfigure2(image)

org=double(image);
[r c]=size(org);
mm=mean(org);
totmean=sum(org(:))/(r*c)
% totmeansq=((sum(org(:)))^2)/(r*c);
% va=totmeansq-(totmean^2)
cc=var(org);
totdiff=(org-totmean).^2;
totsum=sum(totdiff(:));
nele=(r*c)-1;
totvar=totsum/nele

