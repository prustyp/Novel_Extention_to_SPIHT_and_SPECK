clc;
close all;
clear all;
%modified SPECK
f=[];
g=[];
aa=[];
bb=[];
h2=[];
m3=[];
level=4;
sm=10;
X0=imread('D:\priya\project-spiht\standard_test_images\13.gif');
%X0=rgb2gray(X);

X00=double(X0);
%info = imfinfo('D:\priya\project-spiht\standard_test_images\1.gif')
%X1=abs(X2);
%sx1=size(X1);
figure(1)
createfigure2(X0);
% [Row,Column]=size(X0);
% ww=Row*Column;
% www=256*1024*8;
% bpp=www/ww
n_max = (abs(max(max(X00)')))
nn=(1/2)*n_max;
X1=X00-nn;

%bpp=bitget(X1,5)
type = '9.7';
%[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(type);
%sm=10;
for btr=.1:.1:1
OrigSize = size(X1, 1);
max_bits = floor(btr * OrigSize^2);
I_W = dwt2d(X1,type,level);  %incorporate lwt2.........................??????
dw=(I_W);
figure(2)
imshow(uint8(I_W));


  tip=0;
  
  tic;
[lineout1,T01,Arow1,BIT1,ll1]=speckencode1(dw,level,sm,max_bits); %specKencode


tok=toc;
tip=tip+tok;
 
  ttime=tip;
aa=[aa ttime]
%for btr=.1:.1:1
  tiq=0;
tic;
X5=speckdecode1(ll1,T01,Arow1,level,sm,btr);%speckdecode

tok=toc;
tiq=tiq+tok;
ttime=tiq;
bb=[bb ttime]


% figure(3)
% imshow(uint8(X5));
indw = dwt2d(X5,type,-level);
indw1=indw+nn;
 
 Xr=uint8(indw1);
 
 %Xr=Xr1+nn;
%IMWRITE(A,FILENAME,FMT)
% imwrite(Xr,X1,'tiff');
% info = imfinfo('X1.tif')
figure(3)
createfigure2(Xr);
Q = 255;


    PSNR=psnr(X0,Xr)
    
%     MSE = sum(sum((X1-indw).^2))/Row / Column;
%     PSNR = 10*log10((Q^2)/MSE);
    f=[f btr]
g=[g PSNR]
K = [0.05 0.05];
  window = ones(8);
  L = 100;
[mssim, ssim_map] = ssim_index(X0,Xr , K, window, L);
qlmsp=mssim

h2=[h2 qlmsp];
end
 memUsed
 m3=[m3 ans]
 figure(4)
%subplot(1,3,1);
axes1 = axes('Parent',figure(4),'FontSize',14);
 xlim(axes1,[.1 1])
plot(f,g,'MarkerSize',10,'Marker','*','LineWidth',3,'Color','m')
xlabel({'BPP'},'FontWeight','bold','FontSize',14);
 ylabel({'PSNR'},'FontWeight','bold','FontSize',14);
hold on;
figure(5)
   
%subplot(1,3,2);
 axes2 = axes('Parent',figure(5),'FontSize',14);
xlim(axes2,[.1 1])
plot(f,aa,'MarkerSize',10,'Marker','*','LineWidth',3,'Color','m')
xlabel({'BPP'},'FontWeight','bold','FontSize',14);
ylabel({'encoding time'},'FontWeight','bold','FontSize',14);
hold on;
figure(6)
%subplot(1,3,3);
axes3 = axes('Parent',figure(6),'FontSize',14);
xlim(axes3,[.1 1])
plot(f,bb,'MarkerSize',10,'Marker','*','LineWidth',3,'Color','m')
xlabel({'BPP'},'FontWeight','bold','FontSize',14);
ylabel({'decoding time'},'FontWeight','bold','FontSize',14);
hold on;
figure(7)
%subplot(1,3,3);
 axes4 = axes('Parent',figure(7),'FontSize',14);
xlim(axes4,[.1 1])
plot(f,h2,'MarkerSize',10,'Marker','*','LineWidth',3,'Color','m')
xlabel({'BPP'},'FontWeight','bold','FontSize',14);
ylabel({'SSIM'},'FontWeight','bold','FontSize',14);
hold on;