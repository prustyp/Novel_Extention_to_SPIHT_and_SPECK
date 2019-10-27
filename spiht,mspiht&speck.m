clc;
% 
% image=imread('D:\priya\project-spiht\standard_test_images\lena_gray_512.tif');
% figure(1)
% imshow(image);
% 
% org=double(image);
% [m n]=size(org);
% ftype='9.7';
% X=[];
% Y=[];
% pt=[];
% et=[];
%  ld=4;       %..default decomposition level is 9  and default wavelet is "haar"....
% for btr=.1:.1:.9
% trcf=dwt2d(image,ftype,ld);
% dt=uint8(trcf);
% figure(2)
% imshow(dt);
% 
% 
% 
% 
% ftype='9.7';
% p = size(org,1);
% n_log = log2(p); 
% %level = n_log;
% %ld=2;
% 
% 
% tk=0;
% tic ; 
% y=espiht(image,ftype,ld);
% tkk=toc;
%      tk=tk+tkk;
%      ttime1=tk;
%      et=[et ttime1]
%   tn=0;
%    tic;
% x=dspiht(y,btr,ftype);
% tnn=toc;
%      tn=tn+tnn;
%      ttime2=tn;
%      pt=[pt ttime2]
% rimage= dwt2d(x,ftype,-ld);
%      
%     re=rimage;
%     figure(3);
%      imshow(uint8(rimage));
%      
% 
%  Q = 255;
% 
% 
%     PSNR=psnr(image,uint8(re));
%     
% %     MSE = sum(sum((image-uint8(re)).^2))/m / n;
% %     PSNR = 10*log10((Q^2)/MSE);
% %      
% xx=uint8(re);
% 
% % transposes final PSNR vector for easy graphing;
%    
% 
% fprintf('The psnr performance is %.2f dB\n', PSNR);
% X=[X PSNR]
% Y=[Y btr]
% 
% 
% end
% K = [0.05 0.05];
%   window = ones(8);
%   L = 100;
% [mssim, ssim_map] = ssim_index(image,xx , K, window, L);
% qlms=mssim
% mnms=mean(re(:))
% vams=var(re(:))
% 
% %SPIHT
% A=[];
% Y =[];
% w=[];
% v=[];
% z=1;
% %
% 
% fprintf('-----------   Welcome to SPIHT Matlab Demo!   ----------------\n');
% 
% fprintf('-----------   Load Image   ----------------\n');
% infilename = imread('D:\priya\project-spiht\standard_test_images\lena_gray_512.tif');
% %outfilename = 'lena512_reconstruct.tif';
% figure(1)
% 
% imshow(infilename);
% 
% 
% Orig_I = double(infilename);
% 
% 
% for rate = .1:.1:.9;
% 
% OrigSize = size(Orig_I, 1);
% max_bits = floor(rate * OrigSize^2);
% OutSize = OrigSize;
% image_spiht = zeros(size(Orig_I));
% [nRow, nColumn] = size(Orig_I);
% 
% fprintf('done!\n');
% fprintf('-----------   Wavelet Decomposition   ----------------\n');
% n = size(Orig_I,1);
% n_log = log2(n); 
% level = 4;
% % wavelet decomposition level can be defined by users manually.
% 
% type = '9.7';
% %[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(type);
% 
% I_W = dwt2d(Orig_I,type, level);
% dw=uint8(I_W);
% 
% figure(2)
% imshow(dw);
% 
% 
% fprintf('done!\n');
% 
% fprintf('-----------   Encoding   ----------------\n');
%  
%      tw=0;
%  tic ;    
% img_enc = func_SPIHT_Enc(I_W, max_bits, nRow*nColumn, level); 
%  tww=toc;
%      tw=tw+tww;
% ttime=tw;
% w=[w ttime]
% fprintf('done!\n');
% fprintf('-----------   Decoding   ----------------\n');
%  
%   tx=0;
%    tic;
% img_dec = func_SPIHT_Dec(img_enc);
% txx=toc;
%      tx=tx+txx;
%      ttime=tx;
%      v=[v ttime]
%      
% 
% 
% 
% fprintf('done!\n');
% fprintf('-----------   Wavelet Reconstruction   ----------------\n');
% img_spiht = dwt2d(img_dec,type, -level);
% outimage = uint8(img_spiht);
% 
% fprintf('done!\n');
% fprintf('-----------   PSNR analysis   ----------------\n');
% 
% %imwrite(img_spiht, gray(256), outfilename, 'tif');
% 
% Q = 255;
% 
% 
%     PSNR=psnr(infilename,outimage);
%     
% %     MSE = sum(sum((infilename-outimage).^2))/nRow / nColumn;
% %     PSNR = 10*log10((Q^2)/MSE);
%      figure(3)
% % subplot(5,2,z)
% z=z+1;
% imshow(outimage);
% title({;...
%     PSNR,'psnr='})
% 
% 
% % transposes final PSNR vector for easy graphing;
%    
% 
% fprintf('The psnr performance is %.2f dB\n', PSNR);
% A=[A PSNR]
% Y=[Y rate]
% 
% 
% end
% [mssim, ssim_map] = ssim_index(infilename,outimage , K, window, L);
% qls=mssim
% % mns=mean(img_spiht(:))
% % vas=var(img_spiht(:))
f1=[];
g1=[];
aa1=[];
bb1=[];
level=4;

X1=imread('D:\priya\project-spiht\standard_test_images\crowd.tif');
X11=double(X1);
%info = imfinfo('D:\priya\project-spiht\standard_test_images\7.gif')
%X1=abs(X2);
%sx1=size(X1);
% figure(1)
% imshow(X1);
[Row,Column]=size(X11);
ww=Row*Column;
www=256*1024*8;
bpp=www/ww


%bpp=bitget(X1,5)
type = '9.7';
%[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(type);
sm=12;
OrigSize = size(X11, 1);

I_W = dwt2d(X11,type,level);  %incorporate lwt2.........................??????
dw=(I_W);
% figure(2)
% imshow(uint8(I_W));


  tip=0;
  
  tic;
[lineout,T0,Arow,BIT,ll]=speckencode1(dw,level,sm); %specKencode


tok=toc;
tip=tip+tok;
 
  ttime=tip;
aa1=[aa1 ttime]
for btr=.1:.1:1
  tiq=0;
tic;
X5=speckdecode1(ll,T0,Arow,level,sm,btr);%speckdecode

tok=toc;
tiq=tiq+tok;
ttime=tiq;
bb1=[bb1 ttime]


% figure(3)
% imshow(uint8(X5));
indw = dwt2d(X5,type,-level);
 figure(4)
 Xr=uint8(indw);
%IMWRITE(A,FILENAME,FMT)
% imwrite(Xr,X1,'tiff');
% info = imfinfo('X1.tif')
imshow(Xr);
Q = 255;


    PSNR=psnr(X1,Xr)
    
%     MSE = sum(sum((X1-indw).^2))/Row / Column;
%     PSNR = 10*log10((Q^2)/MSE);
    f1=[f1 btr]
g1=[g1 PSNR]
end


[mssim, ssim_map] = ssim_index(X1,Xr , K, window, L);
qls=mssim
figure
%subplot(1,3,1);
plot(Y,X,'r',Y,A,'b',f1,g1,'g')
xlabel('bpp');
ylabel('psnr');
figure
   
%subplot(1,3,2);
plot(Y,et,'r',Y,w,'b',f1,aa1,'g');
xlabel('bpp');
ylabel('encoding time');

figure
%subplot(1,3,3);
plot(Y,pt,'r',Y,v,'b',f1,bb1,'g');
xlabel('bpp');
ylabel('decoding time');

