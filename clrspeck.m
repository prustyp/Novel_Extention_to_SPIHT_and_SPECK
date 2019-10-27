% %SPECK
mm=[];
f=[];
g=[];
h=[];
aa=[];
bb=[];
m4=[];
level=4;
%sm=4;
X1=imread('D:\priya\project-spiht\standard_test_images\color image\lena_color_512.tif');

YCBCR = rgb2ycbcr(X1);
Y=YCBCR(:,:,1);
U=YCBCR(:,:,2);
V=YCBCR(:,:,3);
[Row,Column]=size(X1);
figure(1)
createfigure2(X1);
sm=11;
type = '9.7';
% %[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(type);
% 
%OrigSize = size(Y, 1);
for btr=.1:.1:1
    OrigSize = size(X1, 1);
max_bits = floor(btr * OrigSize^2);

I_W = dwt2d(Y,type,level);  %incorporate lwt2.........................??????
dw=(I_W);
figure(2)
%imshow(uint8(I_W));

  tip=0;
  
  tic;
[lineout,T0,Arow,BIT,ll]=speckencode1(dw,level,sm,max_bits); %specKencode
tok=toc;
tip=tip+tok;
 
  ttime=tip;
aa=[aa ttime]

  tiq=0;
tic;
X5=speckdecode1(ll,T0,Arow,level,sm,btr);%speckdecode
tok=toc;
tiq=tiq+tok;
ttime=tiq;
bb=[bb ttime]

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
g=[g PSNR]
[mssim, ssim_map] = ssim_index(Y,indw,K,window,L);
qlms=mssim
h=[h qlms]
I_W1 = dwt2d(U,type,level);  %incorporate lwt2.........................??????

dw1=(I_W1);
[lineout1,T01,Arow1,BIT1,ll1]=speckencode1(dw1,level,sm,max_bits); %specKencode
X51=speckdecode1(ll1,T01,Arow1,level,sm,btr);%speckdecode
indw1 = dwt2d(X51,type,-level);

I_W2 = dwt2d(V,type,level);  %incorporate lwt2.........................??????

dw2=(I_W2);
[lineout2,T02,Arow2,BIT2,ll2]=speckencode1(dw2,level,sm,max_bits); %specKencode
X52=speckdecode1(ll2,T02,Arow2,level,sm,btr);%speckdecode


indw2 = dwt2d(X52,type,-level);


ma(:,:,1)=uint8(indw);
ma(:,:,2)=uint8(indw1);
ma(:,:,3)=uint8(indw2);
figure(9)
createfigure2(ma);

rgb2 = ycbcr2rgb(ma);
figure(3)
createfigure2(rgb2);
PSNR=psnr(X1,rgb2) 
mm=[mm PSNR]
end
memUsed
m4=[m4 ans]
figure(4)
%subplot(1,3,1);
xlim(axes1,[.1 1])
plot(f,g,'MarkerSize',10,'Marker','+','LineWidth',3,'Color',[0 0 1])
hold on;
figure(5)
   
%subplot(1,3,2);
xlim(axes2,[.1 1])
plot(f,aa,'MarkerSize',10,'Marker','+','LineWidth',3,'Color',[0 0 1])
hold on;
figure(6)
%subplot(1,3,3);
xlim(axes3,[.1 1])
plot(f,bb,'MarkerSize',10,'Marker','+','LineWidth',3,'Color',[0 0 1])
hold on;
figure(7)
%subplot(1,3,3);
xlim(axes4,[.1 1])
plot(f,h,'MarkerSize',10,'Marker','+','LineWidth',3,'Color',[0 0 1])
hold on;