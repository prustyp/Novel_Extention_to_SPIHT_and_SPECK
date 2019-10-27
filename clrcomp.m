clc;
close all;
clear all;
image=imread('D:\priya\project-spiht\standard_test_images\color image\peppers.jpg');
YCBCR = rgb2ycbcr(image);
Y=double(YCBCR(:,:,1));
U=double(YCBCR(:,:,2));
V=double(YCBCR(:,:,3));

figure(1)
imshow(image);
%MODIFIED SPIHT
org=double(image);
[m n]=size(org);
ftype='9.7';
X=[];
y=[];
Z=[];
pt=[];
et=[];
 ld=4;       %..default decomposition level is 9  and default wavelet is "haar"....
for btr=.1:.1:1
trcf=dwt2d(Y,ftype,ld);
dt=uint8(trcf);
figure(2)
imshow(dt);




ftype='9.7';
p = size(org,1);
n_log = log2(p); 
%level = n_log;
%ld=2;


tk=0;
tic ; 
en=espiht(Y,ftype,ld);
tkk=toc;
     tk=tk+tkk;
     ttime1=tk;
     et=[et ttime1]
  tn=0;
   tic;
x=dspiht(en,btr,ftype);
tnn=toc;
     tn=tn+tnn;
     ttime2=tn;
     pt=[pt ttime2]
rimage= dwt2d(x,ftype,-ld);
     
 trcf1=dwt2d(U,ftype,ld);
 en1=espiht(U,ftype,ld);
 x1=dspiht(en1,btr,ftype);
 rimage1= dwt2d(x1,ftype,-ld);
 
 trcf2=dwt2d(V,ftype,ld);
 en2=espiht(V,ftype,ld);
 x2=dspiht(en2,btr,ftype);
 rimage2= dwt2d(x2,ftype,-ld);
     ma(:,:,1)=uint8(rimage);
ma(:,:,2)=uint8(rimage1);
ma(:,:,3)=uint8(rimage2);
figure(9)
imshow(ma);

rgb2 = ycbcr2rgb(ma);
figure(4)
imshow(rgb2);
     

 Q = 255;


    PSNR=psnr(image,rgb2);
    
%     MSE = sum(sum((image-uint8(re)).^2))/m / n;
%     PSNR = 10*log10((Q^2)/MSE);
%      


% transposes final PSNR vector for easy graphing;
   

fprintf('The psnr performance is %.2f dB\n', PSNR);
X=[X PSNR]
y=[y btr]
K = [0.05 0.05];
  window = ones(8);
  L = 100;
% [mssim, ssim_map] = ssim_index(image,rgb2 , K, window, L);
% qlms=mssim
% Z=[Z qlms]

end



% %SPIHT
A=[];
B=[];
y =[];
w=[];
v=[];
z=1;
%

fprintf('-----------   Welcome to SPIHT Matlab Demo!   ----------------\n');

fprintf('-----------   Load Image   ----------------\n');
infilename = imread('D:\priya\project-spiht\standard_test_images\color image\peppers.jpg');
YCBCR = rgb2ycbcr(infilename);
Y=double(YCBCR(:,:,1));
U=double(YCBCR(:,:,2));
V=double(YCBCR(:,:,3));
%outfilename = 'lena512_reconstruct.tif';
figure(1)

imshow(infilename);


Orig_I = double(infilename);


for rate = .1:.1:1

OrigSize = size(Orig_I, 1);
max_bits = floor(rate * OrigSize^2);
OutSize = OrigSize;
image_spiht = zeros(size(Orig_I));
[nRow, nColumn] = size(Orig_I);

fprintf('done!\n');
fprintf('-----------   Wavelet Decomposition   ----------------\n');
n = size(Orig_I,1);
n_log = log2(n); 
level = 4;
% wavelet decomposition level can be defined by users manually.

type = '9.7';
%[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(type);

I_W = dwt2d(Y,type, level);
% dw=uint8(I_W);
% 
% figure(2)
% imshow(dw);


fprintf('done!\n');

fprintf('-----------   Encoding   ----------------\n');
 
     tw=0;
 tic ;    
img_enc = func_SPIHT_Enc(I_W, max_bits, nRow*nColumn, level); 
 tww=toc;
     tw=tw+tww;
ttime=tw;
w=[w ttime]
fprintf('done!\n');
fprintf('-----------   Decoding   ----------------\n');
 
  tx=0;
   tic;
img_dec = func_SPIHT_Dec(img_enc);
txx=toc;
     tx=tx+txx;
     ttime=tx;
     v=[v ttime]
     



fprintf('done!\n');
fprintf('-----------   Wavelet Reconstruction   ----------------\n');
img_spiht = dwt2d(img_dec,type, -level);

I_W1 = dwt2d(U,type, level);
img_enc1 = func_SPIHT_Enc(I_W1, max_bits, nRow*nColumn, level);
img_dec1 = func_SPIHT_Dec(img_enc1);
img_spiht1 = dwt2d(img_dec1,type, -level);

I_W2 = dwt2d(V,type, level);
img_enc2 = func_SPIHT_Enc(I_W2, max_bits, nRow*nColumn, level);
img_dec2 = func_SPIHT_Dec(img_enc2);
img_spiht2 = dwt2d(img_dec2,type, -level);

ma(:,:,1)=uint8(img_spiht);
ma(:,:,2)=uint8(img_spiht1);
ma(:,:,3)=uint8(img_spiht2);
figure(9)
imshow(ma);

rgb2 = ycbcr2rgb(ma);
figure(4)
imshow(rgb2);
%outimage = uint8(img_spiht);

fprintf('done!\n');
fprintf('-----------   PSNR analysis   ----------------\n');

%imwrite(img_spiht, gray(256), outfilename, 'tif');

Q = 255;


    PSNR=psnr(infilename,rgb2);
    
%     MSE = sum(sum((infilename-outimage).^2))/nRow / nColumn;
%     PSNR = 10*log10((Q^2)/MSE);
     figure(3)
% subplot(5,2,z)
%z=z+1;
%imshow(outimage);
%title({;...
    %PSNR,'psnr='})


% transposes final PSNR vector for easy graphing;
   

fprintf('The psnr performance is %.2f dB\n', PSNR);
A=[A PSNR]
y=[y rate]
% [mssim, ssim_map] = ssim_index(infilename,outimage , K, window, L);
% qls=mssim
% B=[B qls]

end


% %modified SPECK
mm1=[];
f1=[];
h1=[];
aa1=[];
bb1=[];
level=4;
%sm=4;
X1=imread('D:\priya\project-spiht\standard_test_images\color image\peppers.jpg ');
figure(1)
imshow(X1);


YCBCR = rgb2ycbcr(X1);
Y=YCBCR(:,:,1);
n_max1 = (abs(max(max(double(Y))')))
nn1=(1/2)*n_max1;
Y1=double(Y)-nn1;
U=double(YCBCR(:,:,2));

V=double(YCBCR(:,:,3));
%[Row,Column]=size(X1);

sm=11;
type = '9.7';
% %[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(type);
% 
%OrigSize = size(Y, 1);
I_W = dwt2d(Y1,type,level);  %incorporate lwt2.........................??????
dw=(I_W);
%figure(2)
%imshow(uint8(I_W));

  tip=0;
  
  tic;
[lineout,T0,Arow,BIT,ll]=speckencode1(dw,level,sm); %specKencode

I_W1 = dwt2d(U,type,level);  %incorporate lwt2.........................??????

dw1=(I_W1);
[lineout1,T01,Arow1,BIT1,ll1]=speckencode1(dw1,level,sm); %specKencode
I_W2 = dwt2d(V ,type,level);  %incorporate lwt2.........................??????

dw2=(I_W2);
[lineout2,T02,Arow2,BIT2,ll2]=speckencode1(dw2,level,sm); %specKencode
tok=toc;
tip=tip+tok;
 
  ttime=tip;
aa1=[aa1 ttime]
for btr=.1:.1:1
  tiq=0;
tic;
X5=speckdecode1(ll,T0,Arow,level,sm,btr);%speckdecode


%figure(3)
%imshow(uint8(X5));
indw = dwt2d(X5,type,-level);
rec=indw+nn1;
% figure(4)
 %Xr=uint8(indw);
% imshow(Xr);
Q = 255;


  PSNR=psnr(Y,rec) ; 
    
%     MSE = sum(sum((Y-Xr).^2))/Row / Column;
%     PSNR = 10*log10((Q^2)/MSE);
    f1=[f1 btr]
h1=[h1 PSNR]
% %end

% figure(5)
% plot(f,g);
% figure(6)
% plot(f,aa);
% figure(7)
% plot(f,bb);
% 
% 
% 
% 
%OrigSize = size(U, 1); 

X51=speckdecode1(ll1,T01,Arow1,level,sm,btr);%speckdecode
indw1 = dwt2d(X51,type,-level);


%OrigSize = size(V, 1);

X52=speckdecode1(ll2,T02,Arow2,level,sm,btr);%speckdecode


indw2 = dwt2d(X52,type,-level);
tok=toc;
tiq=tiq+tok;
ttime=tiq;
bb1=[bb1 ttime]


ma(:,:,1)=uint8(rec);
ma(:,:,2)=uint8(indw1);
ma(:,:,3)=uint8(indw2);
figure(9)
imshow(ma);

rgb2 = ycbcr2rgb(ma);

figure(4)
imshow(rgb2);
PSNR=psnr(X1,rgb2) 
mm1=[mm1 PSNR]
end
% %SPECK
mm=[];
f=[];
h=[];
aa=[];
bb=[];
level=4;
%sm=4;
X1=imread('D:\priya\project-spiht\standard_test_images\color image\peppers.jpg');

YCBCR = rgb2ycbcr(X1);
Y=YCBCR(:,:,1);
U=YCBCR(:,:,2);
V=YCBCR(:,:,3);
[Row,Column]=size(X1);
figure(1)
imshow(X1);
sm=11;
type = '9.7';
% %[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(type);
% 
%OrigSize = size(Y, 1);
I_W = dwt2d(Y,type,level);  %incorporate lwt2.........................??????
dw=(I_W);
figure(2)
%imshow(uint8(I_W));

  tip=0;
  
  tic;
[lineout,T0,Arow,BIT,ll]=speckencode1(dw,level,sm); %specKencode

I_W1 = dwt2d(U,type,level);  %incorporate lwt2.........................??????

dw1=(I_W1);
[lineout1,T01,Arow1,BIT1,ll1]=speckencode1(dw1,level,sm); %specKencode
I_W2 = dwt2d(V,type,level);  %incorporate lwt2.........................??????

dw2=(I_W2);
[lineout2,T02,Arow2,BIT2,ll2]=speckencode1(dw2,level,sm); %specKencode
tok=toc;
tip=tip+tok;
 
  ttime=tip;
aa=[aa ttime]
for btr=.1:.1:1
  tiq=0;
tic;
X5=speckdecode1(ll,T0,Arow,level,sm,btr);%speckdecode


%figure(3)
%imshow(uint8(X5));
indw = dwt2d(X5,type,-level);
% figure(4)
 %Xr=uint8(indw);
% imshow(Xr);
Q = 255;


  PSNR=psnr(Y,indw) ; 
    
%     MSE = sum(sum((Y-Xr).^2))/Row / Column;
%     PSNR = 10*log10((Q^2)/MSE);
    f=[f btr]
h=[h PSNR]
% %end

% figure(5)
% plot(f,g);
% figure(6)
% plot(f,aa);
% figure(7)
% plot(f,bb);
% 
% 
% 
% 
%OrigSize = size(U, 1); 

X51=speckdecode1(ll1,T01,Arow1,level,sm,btr);%speckdecode
indw1 = dwt2d(X51,type,-level);


%OrigSize = size(V, 1);

X52=speckdecode1(ll2,T02,Arow2,level,sm,btr);%speckdecode


indw2 = dwt2d(X52,type,-level);
tok=toc;
tiq=tiq+tok;
ttime=tiq;
bb=[bb ttime]


ma(:,:,1)=uint8(indw);
ma(:,:,2)=uint8(indw1);
ma(:,:,3)=uint8(indw2);
figure(9)
imshow(ma);

rgb2 = ycbcr2rgb(ma);
figure(4)
imshow(rgb2);
PSNR=psnr(X1,rgb2) 
mm=[mm PSNR]
end
% % clc;
% % close all;
% % clear all;
% %K=6;
% 
% 
figure
%subplot(1,3,1);
plot(y,A,'r',y,X,'g',f,mm,'b',f1,mm1,'m')
xlabel('bpp');
ylabel('psnr');
% figure
%    
% %subplot(1,3,2);
% plot(Y,w,'r',Y,et,'g',f1,aa1,'b',f,aa,'m');
% xlabel('bpp');
% ylabel('encoding time');
% 
% figure
% %subplot(1,3,3);
% plot(Y,v,'r',Y,pt,'g',f1,bb1,'b',f,bb,'m');
% xlabel('bpp');
% ylabel('decoding time');
% figure
% %subplot(1,3,3);
% plot(Y,B,'r',Y,Z,'g',f1,h1,'b',f,h2,'m');
% xlabel('bpp');
% ylabel('SSIM');
% 
% 
