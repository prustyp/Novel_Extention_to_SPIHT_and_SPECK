%SPIHT
A=[];
B=[];
y =[];
w=[];
v=[];
m2=[];
z=1;
%

fprintf('-----------   Welcome to SPIHT Matlab Demo!   ----------------\n');

fprintf('-----------   Load Image   ----------------\n');
infilename = imread('D:\priya\project-spiht\standard_test_images\color image\lena_color_512.tif');
YCBCR = rgb2ycbcr(infilename);
Y=double(YCBCR(:,:,1));
U=double(YCBCR(:,:,2));
V=double(YCBCR(:,:,3));
%outfilename = 'lena512_reconstruct.tif';
figure(1)

createfigure2(infilename);


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
createfigure2(ma);

rgb2 = ycbcr2rgb(ma);
figure(3)
createfigure2(rgb2);
%outimage = uint8(img_spiht);

fprintf('done!\n');
fprintf('-----------   PSNR analysis   ----------------\n');

%imwrite(img_spiht, gray(256), outfilename, 'tif');

Q = 255;


    PSNR=psnr(Y,img_spiht);
    
%     MSE = sum(sum((infilename-outimage).^2))/nRow / nColumn;
%     PSNR = 10*log10((Q^2)/MSE);
     %figure(3)
% subplot(5,2,z)
%z=z+1;
%imshow(outimage);
%title({;...
    %PSNR,'psnr='})


% transposes final PSNR vector for easy graphing;
   

fprintf('The psnr performance is %.2f dB\n', PSNR);
A=[A PSNR]
y=[y rate]
[mssim, ssim_map] = ssim_index(Y,img_spiht , K, window, L);
qls=mssim
B=[B qls]

end
memUsed
m2=[m2 ans]
figure(4)
%subplot(1,3,1);
% axes1 = axes('Parent',figure(4),'FontSize',14);
  xlim(axes1,[.1 1])
plot(y,A,'MarkerSize',10,'Marker','+','LineWidth',3,'Color',[0 1 0])
% xlabel({'BPP'},'FontWeight','bold','FontSize',14);
% ylabel({'PSNR'},'FontWeight','bold','FontSize',14);
hold on;

figure(5)
%    axes2 = axes('Parent',figure(5),'FontSize',14);
    xlim(axes2,[.1 1])
plot(y,w,'MarkerSize',10,'Marker','+','LineWidth',3,'Color',[0 1 0])
% xlabel({'BPP'},'FontWeight','bold','FontSize',14);
% ylabel({'encoding time'},'FontWeight','bold','FontSize',14);
% %subplot(1,3,2);
hold on;

figure(6)
% axes3 = axes('Parent',figure(6),'FontSize',14);
  xlim(axes3,[.1 1])
plot(y,v,'MarkerSize',10,'Marker','+','LineWidth',3,'Color',[0 1 0])
% xlabel({'BPP'},'FontWeight','bold','FontSize',14);
% ylabel({'decoding time'},'FontWeight','bold','FontSize',14);
% %subplot(1,3,3);
hold on;

figure(7)
% axes4 = axes('Parent',figure(7),'FontSize',14);
  xlim(axes4,[.1 1])
plot(y,B,'MarkerSize',10,'Marker','+','LineWidth',3,'Color',[0 1 0])
% xlabel({'BPP'},'FontWeight','bold','FontSize',14);
% ylabel({'SSIM'},'FontWeight','bold','FontSize',14);
% %subplot(1,3,3);
hold on;