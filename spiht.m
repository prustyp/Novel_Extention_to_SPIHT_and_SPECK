%SPIHT
A=[];
B=[];
Y =[];
w=[];
v=[];
z=1;
m2=[];
%

fprintf('-----------   Welcome to SPIHT Matlab Demo!   ----------------\n');

fprintf('-----------   Load Image   ----------------\n');
infilename = imread('D:\priya\project-spiht\standard_test_images\lena_gray_512.tif');
%outfilename = 'lena512_reconstruct.tif';
figure(1)
createfigure2(infilename)



Orig_I = double(infilename);


for rate = .1:.1:1;

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

I_W = dwt2d(Orig_I,type, level);
dw=uint8(I_W);

figure(2)
imshow(dw);


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
outimage = uint8(img_spiht);

fprintf('done!\n');
fprintf('-----------   PSNR analysis   ----------------\n');

%imwrite(img_spiht, gray(256), outfilename, 'tif');

Q = 255;


    PSNR=psnr(infilename,outimage);
    
%     MSE = sum(sum((infilename-outimage).^2))/nRow / nColumn;
%     PSNR = 10*log10((Q^2)/MSE);
     figure(8)
% subplot(5,2,z)
z=z+1;
createfigure2(outimage)

title({;...
    PSNR,'psnr='})


% transposes final PSNR vector for easy graphing;
   

fprintf('The psnr performance is %.2f dB\n', PSNR);
A=[A PSNR]
Y=[Y rate]
K = [0.05 0.05];
  window = ones(8);
  L = 100;
[mssim, ssim_map] = ssim_index(infilename,outimage , K, window, L);
qls=mssim
B=[B qls]

end
memUsed
m2=[m2 ans]
figure(4)
%subplot(1,3,1);
% axes1 = axes('Parent',figure(4),'FontSize',14);
  xlim(axes1,[.1 1])
plot(Y,A,'MarkerSize',10,'Marker','+','LineWidth',3,'Color','b')
% xlabel({'BPP'},'FontWeight','bold','FontSize',14);
% ylabel({'PSNR'},'FontWeight','bold','FontSize',14);
hold on;

figure(5)
%    axes2 = axes('Parent',figure(5),'FontSize',14);
     xlim(axes2,[.1 1])
plot(Y,w,'MarkerSize',10,'Marker','+','LineWidth',3,'Color','b')
% xlabel({'BPP'},'FontWeight','bold','FontSize',14);
% ylabel({'encoding time'},'FontWeight','bold','FontSize',14);
% %subplot(1,3,2);
hold on;

figure(6)
% axes3 = axes('Parent',figure(6),'FontSize',14);
  xlim(axes3,[.1 1])
plot(Y,v,'MarkerSize',10,'Marker','+','LineWidth',3,'Color','b')
% xlabel({'BPP'},'FontWeight','bold','FontSize',14);
% ylabel({'decoding time'},'FontWeight','bold','FontSize',14);
% %subplot(1,3,3);
hold on;

figure(7)
% axes4 = axes('Parent',figure(7),'FontSize',14);
  xlim(axes4,[.1 1])
plot(Y,B,'MarkerSize',10,'Marker','+','LineWidth',3,'Color','b')
% xlabel({'BPP'},'FontWeight','bold','FontSize',14);
% ylabel({'SSIM'},'FontWeight','bold','FontSize',14);
% %subplot(1,3,3);
hold on;