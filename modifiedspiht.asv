clc;
close all;
clear all;

image=imread('D:\priya\project-spiht\standard_test_images\lena_gray_512.tif');
figure(1)

createfigure2(image)
%MODIFIED SPIHT
org=double(image);
[m n]=size(org);
ftype='9.7';
X=[];
Y=[];
Z=[];
pt=[];
et=[];
m1=[];
 ld=4;       %..default decomposition level is 9  and default wavelet is "haar"....
for btr=.1:.1:1
trcf=dwt2d(image,ftype,ld);
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
y=espiht(image,ftype,ld);
tkk=toc;
     tk=tk+tkk;
     ttime1=tk;
     et=[et ttime1]
  tn=0;
   tic;
x=dspiht(y,btr,ftype);
tnn=toc;
     tn=tn+tnn;
     ttime2=tn;
     pt=[pt ttime2]
rimage= dwt2d(x,ftype,-ld);
     
    re=rimage;
    

 Q = 255;


    PSNR=psnr(image,uint8(re));
    
%     MSE = sum(sum((image-uint8(re)).^2))/m / n;
%     PSNR = 10*log10((Q^2)/MSE);
%      
xx=uint8(re);
figure(3);

createfigure2(uint8(rimage))
     %imshow(uint8(rimage));
     title({;...
    PSNR,'psnr='})
% transposes final PSNR vector for easy graphing;
   

fprintf('The psnr performance is %.2f dB\n', PSNR);
X=[X PSNR]
Y=[Y btr]
K = [0.05 0.05];
  window = ones(8);
  L = 100;
[mssim, ssim_map] = ssim_index(image,xx , K, window, L);
qlms=mssim
Z=[Z qlms]

end
memUsed
m1=[m1 ans]
figure(4)
%subplot(1,3,1);
axes1 = axes('Parent',figure(4),'FontSize',14);
 xlim(axes1,[.1 1])
plot(Y,X,'MarkerSize',10,'Marker','*','LineWidth',3,'Color',[1 0 0])
xlabel({'BPP'},'FontWeight','bold','FontSize',14);
ylabel({'PSNR'},'FontWeight','bold','FontSize',14);
hold on;

figure(5)
   axes2 = axes('Parent',figure(5),'FontSize',14);
    xlim(axes2,[.1 1])
plot(Y,et,'MarkerSize',10,'Marker','*','LineWidth',3,'Color',[1 0 0])
xlabel({'BPP'},'FontWeight','bold','FontSize',14);
ylabel({'encoding time'},'FontWeight','bold','FontSize',14);
%subplot(1,3,2);
hold on;

figure(6)
axes3 = axes('Parent',figure(6),'FontSize',14);
 xlim(axes3,[.1 1])
plot(Y,pt,'MarkerSize',10,'Marker','*','LineWidth',3,'Color',[1 0 0])
xlabel({'BPP'},'FontWeight','bold','FontSize',14);
ylabel({'decoding time'},'FontWeight','bold','FontSize',14);
%subplot(1,3,3);
hold on;

figure(7)
axes4 = axes('Parent',figure(7),'FontSize',14);
 xlim(axes4,[.1 1])
plot(Y,Z,'MarkerSize',10,'Marker','*','LineWidth',3,'Color',[1 0 0])
xlabel({'BPP'},'FontWeight','bold','FontSize',14);
ylabel({'SSIM'},'FontWeight','bold','FontSize',14);
%subplot(1,3,3);
hold on;
