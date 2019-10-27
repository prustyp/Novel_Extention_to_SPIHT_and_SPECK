% %modified SPECK
% clc;
% close all;
% clear all;
mm1=[];
f1=[];
g1=[];
h1=[];
aa1=[];
bb1=[];
m3=[];
level=4;
%sm=4;
X1=imread('D:\priya\project-spiht\standard_test_images\color image\lena_color_512.tif ');
figure(1)
createfigure2(X1);


YCBCR = rgb2ycbcr(X1);
Y=YCBCR(:,:,1);
n_max1 = (abs(max(max(double(Y))')))
nn1=(1/2)*n_max1;
Y1=double(Y)-nn1;
U=double(YCBCR(:,:,2));

V=double(YCBCR(:,:,3));
%[Row,Column]=size(X1);

sm=10;
type = '9.7';
% %[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(type);
% 
%OrigSize = size(Y, 1);
for btr=.1:.1:1
    OrigSize = size(X1, 1);
max_bits = floor(btr * OrigSize^2);
I_W = dwt2d(Y1,type,level);  %incorporate lwt2.........................??????
dw=(I_W);
%figure(2)
%imshow(uint8(I_W));

  tip=0;
  
  tic;
[lineout,T0,Arow,BIT,ll]=speckencode1(dw,level,sm,max_bits); %specKencode
tok=toc;
tip=tip+tok;
 
  ttime=tip;
aa1=[aa1 ttime]
tiq=0;
tic;
X5=speckdecode1(ll,T0,Arow,level,sm,btr);%speckdecode
tok=toc;
tiq=tiq+tok;
ttime=tiq;
bb1=[bb1 ttime]
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
g1=[g1 PSNR]
K = [0.05 0.05];
  window = ones(8);
  L = 100;
[mssim, ssim_map] = ssim_index(Y,rec,K,window,L);
qlms=mssim
h1=[h1 qlms]
I_W1 = dwt2d(U,type,level);  %incorporate lwt2.........................??????

dw1=(I_W1);
[lineout1,T01,Arow1,BIT1,ll1]=speckencode1(dw1,level,sm,max_bits); %specKencode

X51=speckdecode1(ll1,T01,Arow1,level,sm,btr);%speckdecode
indw1 = dwt2d(X51,type,-level);

I_W2 = dwt2d(V ,type,level);  %incorporate lwt2.........................??????

dw2=(I_W2);
[lineout2,T02,Arow2,BIT2,ll2]=speckencode1(dw2,level,sm,max_bits); %specKencode
X52=speckdecode1(ll2,T02,Arow2,level,sm,btr);%speckdecode


indw2 = dwt2d(X52,type,-level);
  

ma(:,:,1)=uint8(rec);
ma(:,:,2)=uint8(indw1);
ma(:,:,3)=uint8(indw2);
figure(9)
createfigure2(ma);

rgb2 = ycbcr2rgb(ma);

figure(3)
createfigure2(rgb2);
PSNR=psnr(X1,rgb2) 
mm1=[mm1 PSNR]
end
memUsed
m3=[m3 ans]
figure(4)
%subplot(1,3,1);
%axes1 = axes('Parent',figure(4),'FontSize',14);
 xlim(axes1,[.1 1])
plot(f1,g1,'MarkerSize',10,'Marker','*','LineWidth',3,'Color','m')
% xlabel({'BPP'},'FontWeight','bold','FontSize',14);
% ylabel({'PSNR'},'FontWeight','bold','FontSize',14);
hold on;
figure(5)
   
%subplot(1,3,2);
% axes2 = axes('Parent',figure(5),'FontSize',14);
xlim(axes2,[.1 1])
plot(f1,aa1,'MarkerSize',10,'Marker','*','LineWidth',3,'Color','m')
% xlabel({'BPP'},'FontWeight','bold','FontSize',14);
% ylabel({'encoding time'},'FontWeight','bold','FontSize',14);
hold on;
figure(6)
%subplot(1,3,3);
%axes3 = axes('Parent',figure(6),'FontSize',14);
xlim(axes3,[.1 1])
plot(f1,bb1,'MarkerSize',10,'Marker','*','LineWidth',3,'Color','m')
% xlabel({'BPP'},'FontWeight','bold','FontSize',14);
% ylabel({'decoding time'},'FontWeight','bold','FontSize',14);
hold on;
figure(7)
%subplot(1,3,3);
%axes4 = axes('Parent',figure(7),'FontSize',14);
xlim(axes4,[.1 1])
plot(f1,h1,'MarkerSize',10,'Marker','*','LineWidth',3,'Color','m')
% xlabel({'BPP'},'FontWeight','bold','FontSize',14);
% ylabel({'SSIM'},'FontWeight','bold','FontSize',14);
hold on;
