function trcf = dwt2d(image,ftype,ld)
%   x= dwt2d(image,ftype,ld) 
%   computes the 2Dwavelet decomposition/reconstruction..
%   
%   IMAGE:here we always take input "image" of size 2^N ..
%         some valid IMAGE are listed below
%         lena
%         pami
%         ghl
%         vegi
%         vidya
%
%
%   FTYPE:this indicates the type of wavelet used for decomposition..
%         there are a large number of filter available for decomposition.  
%         specify the filter type by providing their name as input
%         argument .. some of the valid FTYPE that can be used in the
%         programme are listed below..
%         'haar'
%         'db1', 'db2', 'db3', 'db4', 'db5', 'db6', 'db7', 'db8'
%         Cohen-Daubechies-Feauveau wavelets:
%         'cdf1.1','cdf1.3','cdf1.5' - 'cdf2.2','cdf2.4','cdf2.6'
%         'cdf3.1','cdf3.3','cdf3.5' - 'cdf4.2','cdf4.4','cdf4.6'
%         'cdf5.1','cdf5.3','cdf5.5' - 'cdf6.2','cdf6.4','cdf6.6'
%         'bs3'  : identical to 'cdf4.2'
%         '9.7'  : identical to 'bior4.4' 
%
%
%   LD:  this is the decomposition level....
%        when "ld" is positive forward transfor is calculated when "ld" 
%        is negative inverse transform (reconstruction) is calculated
%        one can enter the level of decomposition by specifying it  
%        input argument ...

%%                                ERROR CHECK AND DEFINING LIFTER

s=size(image);
s=s(1);
s=log2(s);
error(nargchk(1,3,nargin));
if nargin ==1
    ld=s; ftype ='haar';       %..default decomposition level is 9  and default wavelet is "haar"....
else
    if nargin ==2
        ld=s;
    end
end

%... printing the ftype and level of decompositions...



ls =liftwave(ftype);     % .. lifted wavelet name .....
image =double(image);
%%                                      NO CHANGE  
if ld==0
    trcf=image;
    fprintf('WAVELET TYPE: %s   DECOMPOSITION LEVEL: %d \n',ftype,ld);
end

%%                                      FORWARD TRANSFORM... decomposition..
if ld >0
n=s;
trcf=zeros(512,512);

    while(n>s-ld)
         [ca,ch,cv,cd]=lwt2(image,ls);
         
         trcf(1:2^(n-1),2^(n-1)+1:2^n)=ch;
         trcf(2^(n-1)+1:2^n,1:2^(n-1))=cv;
         trcf(2^(n-1)+1:2^n,2^(n-1)+1:2^n)=cd;
         
         image=ca;
         
         
         n=n-1;
         
    end
    
    trcf(1:2^(s-ld),1:2^(s-ld))=ca;
  %... imshow(uint8(trcf));
fprintf('WAVELET TYPE: %s   DECOMPOSITION LEVEL: %d \n',ftype,ld);    
end
%%                                 REVERSE TRANSFORM.. reconstruction...
if ld <0
    n=s+ld;
    trcf=image;
    
    while(n<s)
        ca=trcf(1:2^n,1:2^n);
        ch=trcf(1:2^n,2^n+1:2^(n+1));
        cv=trcf(2^n+1:2^(n+1),1:2^n);
        cd=trcf(2^n+1:2^(n+1),2^n+1:2^(n+1));
        
        trcf(1:2^(n+1),1:2^(n+1))= ilwt2(ca,ch,cv,cd,ls);
        
        n=n+1;
    end
    
    %...imshow(uint8(trcf));
 fprintf('WAVELET TYPE: %s   RECONSTRUCTION LEVEL: %d \n',ftype,ld);
end
 
end