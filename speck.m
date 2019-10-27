%SPECK
f1=[];
g1=[];
h1=[];
aa1=[];
bb1=[];
m4=[];
level=4;

X1=imread('D:\priya\project-spiht\standard_test_images\13.gif');
X11=double(X1);
%info = imfinfo('D:\priya\project-spiht\standard_test_images\7.gif')_
%X1=abs(X2);
%sx1=size(X1);
figure(1)
createfigure2(X1);
% [Row,Column]=size(X11);
% ww=Row*Column;
% www=256*1024*8;
% bpp=www/ww


%bpp=bitget(X1,5)
type = '9.7';
%[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(type);
sm=11;
for btr=.1:.1:1

OrigSize = size(X11, 1);
max_bits = floor(btr * OrigSize^2);


I_W = dwt2d(X11,type,level);  %incorporate lwt2.........................??????
dw=(I_W);
figure(2)
imshow(uint8(I_W));


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


% figure(3)
% imshow(uint8(X5));
indw = dwt2d(X5,type,-level);
 figure(3)
 Xr=uint8(indw);
%IMWRITE(A,FILENAME,FMT)
% imwrite(Xr,X1,'tiff');
% info = imfinfo('X1.tif')
createfigure2(Xr)

title({;...
    PSNR,'psnr='})
Q = 255;


    PSNR=psnr(X1,Xr)
    
%     MSE = sum(sum((X1-indw).^2))/Row / Column;
%     PSNR = 10*log10((Q^2)/MSE);
    f1=[f1 btr]
g1=[g1 PSNR]
[mssim, ssim_map] = ssim_index(X1,Xr , K, window, L);
 qlsp=mssim

h1=[h1 qlsp];
end
memUsed
m4=[m4 ans]
figure(4)
%subplot(1,3,1);
 xlim(axes1,[.1 1])
plot(f1,g1,'MarkerSize',10,'Marker','+','LineWidth',3,'Color',[0 0 1])
hold on;
figure(5)
   
%subplot(1,3,2);
xlim(axes2,[.1 1])
plot(f1,aa1,'MarkerSize',10,'Marker','+','LineWidth',3,'Color',[0 0 1])
hold on;
figure(6)
%subplot(1,3,3);
xlim(axes3,[.1 1])
plot(f1,bb1,'MarkerSize',10,'Marker','+','LineWidth',3,'Color',[0 0 1])
hold on;
figure(7)
%subplot(1,3,3);
xlim(axes4,[.1 1])
plot(f1,h1,'MarkerSize',10,'Marker','+','LineWidth',3,'Color',[0 0 1])
hold on;