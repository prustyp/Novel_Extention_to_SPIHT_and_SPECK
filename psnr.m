function c = psnr(org,rctd)
%   
%   y= psnr(org,rctd) ; calculates the Peak signal to noise ratio in 
%   the reconstructed image "rctd" when the original image is "org"
%
%   for example::
%   let "image" be encoded using SPIHT and again let "rimage" be
%   the reconstructed image by decoder then the psnr can be obtain by
%   calling the PSNR function as below
% 
%   >> y=psnr(image,rimage);
c=0;
[m1 n1]= size(org);
[m2 n2]= size(rctd);

org=double(org);
rctd=double(rctd);

if (m1~=m2) || (n1~=n2)
    display('error in input .. dimension mismatch of original and reconstructed  image');
    return;
end 
mse=0;
for i= 1:m1
    for j= 1:n1
      a=org(i,j);
      b=rctd(i,j);
      
      mse= mse+ (a-b)^2;
    end
end
mse= mse/(m1*n1) ;

c= 10* log10 (255^2/mse);
%EOF