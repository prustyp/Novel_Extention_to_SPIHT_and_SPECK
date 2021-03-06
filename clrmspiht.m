clc;
close all;
clear all;
image=imread('D:\priya\project-spiht\standard_test_images\color image\lena_color_512.tif');
YCBCR = rgb2ycbcr(image);
Y=double(YCBCR(:,:,1));
U=double(YCBCR(:,:,2));
V=double(YCBCR(:,:,3));

figure(1)
createfigure2(image);
%MODIFIED SPIHT
org=double(image);
[m n]=size(org);
ftype='9.7';
X=[];
y=[];
Z=[];
pt=[];
et=[];
m1=[];
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
createfigure2(ma);

rgb2 = ycbcr2rgb(ma);
figure(3)
createfigure2(rgb2);
     

 Q = 255;


    PSNR=psnr(Y,rimage);
    
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
[mssim, ssim_map] = ssim_index(Y,rimage,K,window,L);
qlms=mssim
Z=[Z qlms]

end
memUsed
m1=[m1 ans]
figure(4)
%subplot(1,3,1);
axes1 = axes('Parent',figure(4),'FontSize',14);
 xlim(axes1,[.1 1])
plot(y,X,'MarkerSize',10,'Marker','*','LineWidth',3,'Color',[1 0 0])
xlabel({'BPP'},'FontWeight','bold','FontSize',14);
ylabel({'PSNR'},'FontWeight','bold','FontSize',14);
hold on;

figure(5)
   axes2 = axes('Parent',figure(5),'FontSize',14);
    xlim(axes2,[.1 1])
plot(y,et,'MarkerSize',10,'Marker','*','LineWidth',3,'Color',[1 0 0])
xlabel({'BPP'},'FontWeight','bold','FontSize',14);
ylabel({'encoding time'},'FontWeight','bold','FontSize',14);
%subplot(1,3,2);
hold on;

figure(6)
axes3 = axes('Parent',figure(6),'FontSize',14);
 xlim(axes3,[.1 1])
plot(y,pt,'MarkerSize',10,'Marker','*','LineWidth',3,'Color',[1 0 0])
xlabel({'BPP'},'FontWeight','bold','FontSize',14);
ylabel({'decoding time'},'FontWeight','bold','FontSize',14);
%subplot(1,3,3);
hold on;

figure(7)
axes4 = axes('Parent',figure(7),'FontSize',14);
 xlim(axes4,[.1 1])
plot(y,Z,'MarkerSize',10,'Marker','*','LineWidth',3,'Color',[1 0 0])
xlabel({'BPP'},'FontWeight','bold','FontSize',14);
ylabel({'SSIM'},'FontWeight','bold','FontSize',14);
%subplot(1,3,3);
hold on;
