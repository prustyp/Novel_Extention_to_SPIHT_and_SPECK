function op=espiht(image,ftype,ld)
%  y=espiht(image,ftype,ld)
%       this function takes as input a picture("image"), filter type("ftype"), 
%       level of subband decompositions("ld") and then encodes it using SPIHT
%       algorithm and the encoded bitstream is retuned in "y".....
%  
%  an example:   >> y=espiht(lena,'9.7',6);
%  
%  IMAGE:here we always take input "image" of size 512x512..
%       before calling this function please load the standard images in the
%       workspace .. standard images like lena, goodhill,pami etc are saved     
%       in a file called "pctr".. please load this file by using the command
%       >>load pctr; some valid IMAGE are listed below
%       lena
%       pami
%       ghl
%       vegi
%       vidya
%  FTYPE:this indicates the type of wavelet used for decomposition..
%       there are a large number of filter available for decomposition. We 
%       can specify the filter type by providing their name as input
%       argument .. some of the valid FTYPE that can be used in the
%       programme are listed below..
%       'haar'
%       'db1', 'db2', 'db3', 'db4', 'db5', 'db6', 'db7', 'db8'
%       Cohen-Daubechies-Feauveau wavelets:
%       'cdf1.1','cdf1.3','cdf1.5' - 'cdf2.2','cdf2.4','cdf2.6'
%       'cdf3.1','cdf3.3','cdf3.5' - 'cdf4.2','cdf4.4','cdf4.6'
%       'cdf5.1','cdf5.3','cdf5.5' - 'cdf6.2','cdf6.4','cdf6.6'
%       'bs3'  : identical to 'cdf4.2'
%       '9.7'  : identical to 'bior4.4' 
%  LD:  this is the decomposition level....
%       you can enter the level of decomposition by specifying it as an
%       input argument ... the maximum value of decomposition is 9.. it has
%       been observed that best compression results are obtained when we
%       use 6 level of decomposition...

%%                         ERROR CHECK IN INPUT


tic;                          %... time check for initialization part...
error(nargchk(1,3,nargin));
if nargin ==1
     ftype ='9.7'; ld=6;      %..default "btr" is 1 bpp  and default wavelet is haar....
elseif nargin ==2
    ld=6;

end


fprintf('ERROR CHECKING in input ------------------------------------------\ndone !   \n');

%%          SUB BAND DECOMPOSITION OF IMAGE
    
                           % ... level of decomposition  "ld".......

    trcf=dwt2d(image,ftype,ld);


fprintf('\nSUB BAND DECOMPOSITION OF IMAGE-----------------------------------\ndone ! \n');
 
    
%%                                   INITIALIZATION STEP
  %                  ........now starts the main spiht algorithm.......
                          
   fprintf('INITIALIZATION STEP-----------------------------------------------\ndone ! \n');

    % data structures DECLARATION ........COUNTER INITIALISATIONS..... 
    
    sp=zeros(300000,2);    nsp=1;  % List of Significant Pixels .... nsp is the counter for lsp...
    ip=zeros(300000,2);    nip=1; % List of Insignificant Pixels ... nip is the counter for lip..
    is=zeros(300000,3);    nis=1; % List of Insignificant Sets .....nis is the counter for lis...
    op=zeros(1,3000000);   tbit=1; % this data structure stores the generated output stream..
                                   % this is the for counting the number of encoded bits..... 
     
     op(tbit)=ld;  tbit=tbit+1; 
     
%     trcf=2*trcf;
     
     N = floor(log2(max(max(abs(trcf)))));
     BIT=N;    %.... this is the total number of bitplanes required....
     
     op(tbit)=BIT;  tbit=tbit+1; % output N....
     
     
     
     
    
     %...................................................initialization....
     %.....................................................................
     n=2^(9-ld); 
     if n==1
        % insert the four pixel into lip....(list of insignificant pixel)...
        ip(nip,:)=[1,1];  nip=nip+1;
        ip(nip,:)=[1,2];  nip=nip+1;
        ip(nip,:)=[2,1];  nip=nip+1;
        ip(nip,:)=[2,2];  nip=nip+1;
        % insert the three pixel into lis...(list of insignificant set)....
        is(nis,:)=[1,2,1];  nis=nis+1;
        is(nis,:)=[2,1,1];  nis=nis+1;
        is(nis,:)=[2,2,1];  nis=nis+1;
         
     else
         
     for k=1:n
         for l=1:n
             is(nis,:)=[k,l,1]; nis=nis+1;
             ip(nip,:)=[k,l]; nip=nip+1;
         end
     end
     end
     %....................................................................

         
     tok=toc;
     tin=tok;
     
     fprintf('TOTAL BITPLANES=%d \n',BIT+1);
     fprintf('encoding with SPIHT started---------------------------------------\n');
     
     tip=0;
     tis=0;
     tir=0;
     
%%                      SORTING AND REFINEMENT PASS FOR EACH BIT PLANE
     while(N>=0)
      tic ;       %... time check for significance pass of LIP...
      last=0;  %... to count the significant pixel found in present bit plane
      T=2^N;                  ..................... SORTING PASS.............
     %..............                FOR EACH ENTRY IN LIP....... 
     count=1;
     while(count<nip)
                
        k=ip(count,1);  l=ip(count,2);
        
        if(k~=0 && l~=0)  %... if there is some valid cordinate position ... 
            value=trcf(k,l);
            if(abs(value)>=T)
                s=1;
            else
                s=0;
            end
            op(tbit)=s;tbit=tbit+1; %output s.......
            %if found significant then move to LSP... and output the sign... 
            if(s==1)
                % insert (k,l) into lsp 
                sp(nsp,:)=[k,l];  nsp=nsp+1;last=last+1;
                % output the sign of value...
                if(value<0)
                 op(tbit)=1;tbit=tbit+1;% output "1"
                else op(tbit)=0;tbit=tbit+1;% output "0"
                end
                % delete it from lip... 
                ip(count,:)=[0,0];
            end
        end
        count=count+1;
     end
     tok=toc;
     tip=tip+tok;
     
     
    %                       FOR EACH  entry (i,j)in the list... LIS.......
     
     tic;
     count=1;
     while(count<nis)
         
         k=is(count,1);  l=is(count,2); type=is(count,3);                        
                
         %                 .......  FOR ENTRY OF Type "A" 
         if ((type==1)&&(k~=0)&&(l~=0))
         
             %....find the significance of D(k,l) and output it.....
              
           
             if k>2^(9-ld)||l>2^(9-ld)   %... for outside lowest subband...
                a=2*(k-1)+1; b=2*(l-1)+1;
                w=2;
                s=0;
                while a<=512 && b<=512
                    d=trcf(a:a-1+w,b:b-1+w);
                    nmax=max(max(abs(d)));
                    if nmax>=T
                        s=1;break;
                    else
                    a=2*(a-1)+1; b=2*(b-1)+1;w=w*2;
                    end
                end
             else                      %... for lowest subband..........  
                a1=k; b1=l+2^(9-ld); v1=abs(trcf(a1,b1));
                a2=k+2^(9-ld); b2=l; v2=abs(trcf(a2,b2));
                a3=k+2^(9-ld); b3=l+2^(9-ld); v3=abs(trcf(a3,b3));
                s=0;
                w=2;
                nmax= max([v1 v2 v3]);
                if nmax >=2^N
                    s=1;
                end
                a1=2*(a1-1)+1; b1=2*(b1-1)+1;
                a2=2*(a2-1)+1; b2=2*(b2-1)+1;
                a3=2*(a3-1)+1; b3=2*(b3-1)+1;
                while (max([a1 a2 a3])<=512 && max([b1 b2 b3])<=512)&&(s==0)
                    d1=trcf(a1:a1-1+w,b1:b1-1+w);
                    d2=trcf(a2:a2-1+w,b2:b2-1+w);
                    d3=trcf(a3:a3-1+w,b3:b3-1+w);
                    nmax1=max(max(abs(d1)));
                    nmax2=max(max(abs(d2)));
                    nmax3=max(max(abs(d3)));
                    nmax=max([nmax1 nmax2 nmax3]);
                    if nmax>=2^N
                        s=1;break;
                    else
                        a1=2*(a1-1)+1; b1=2*(b1-1)+1;
                        a2=2*(a2-1)+1; b2=2*(b2-1)+1;
                        a3=2*(a3-1)+1; b3=2*(b3-1)+1;
                        w=w*2;
                    end
                           
                end
             end
             
             
            
            
            % output the significance of D(k,l).... that is "s".
             op(tbit)=s;tbit=tbit+1;
             
             %          ...............if D(k,l)is significance.....
             if(s==1)
                 % for each ofspring of (k,l).. do some work...
                 k=is(count,1);  l=is(count,2); 
                 
                 if(2*k-1<=512 && 2*l-1<=512)&& (k>2^(9-ld)||l>2^(9-ld)) %... outside lowest subband..
                     
                     value= trcf(2*k-1,2*l-1);
                     if (abs(value)>=2^N)
                         s=1;
                     else
                         s=0;
                     end
                     op(tbit)=s; tbit=tbit+1;% ... output the sig....
                     if(s==1)%... if significant....
                         sp(nsp,:)= [2*k-1,2*l-1];nsp=nsp+1; last=last+1; %...put 2k-1,2l-1 in lsp...
                         if(value<0)
                             op(tbit)=1; tbit=tbit+1;%out put the sign... i.e... "1".....
                         else
                             op(tbit)=0; tbit=tbit+1;% out put the sign..."0"....
                         end
                     else %.... if insignificant....
                         ip(nip,:)= [2*k-1,2*l-1];  nip=nip+1;%...put 2k-1,2l-1 in lip... 
                     end


                     value= trcf(2*k-1,2*l);
                     if (abs(value)>=2^N)
                         s=1;
                     else
                         s=0;
                     end
                     op(tbit)=s; tbit=tbit+1;% ... output the sig....
                     if(s==1)%... if significant....
                         sp(nsp,:)= [2*k-1,2*l];  nsp=nsp+1; last=last+1;%...put 2k-1,2l in lsp...
                         if(value<0)
                             op(tbit)=1; tbit=tbit+1;%out put the sign... i.e... "1".....
                         else
                              op(tbit)=0; tbit=tbit+1; % out put the sign..."0"....
                         end
                     else %.... if insignificant....
                         ip(nip,:)= [2*k-1,2*l];  nip=nip+1;%...put 2k-1,2l in lip...   
                     end
                  
                     
                     value= trcf(2*k,2*l-1);
                     if (abs(value)>=2^N)
                         s=1;
                     else
                         s=0;
                     end
                     op(tbit)=s; tbit=tbit+1;% ... output the sig....
                     if(s==1)%... if significant....
                         sp(nsp,:)= [2*k,2*l-1]; nsp=nsp+1; last=last+1;%...put 2k,2l-1 in lsp...
                         if(value<0)
                             op(tbit)=1; tbit=tbit+1;%out put the sign... i.e... "1".....
                         else
                             op(tbit)=0; tbit=tbit+1;% out put the sign..."0"....
                         end
                     else %.... if insignificant....
                         ip(nip,:)= [2*k,2*l-1]; nip=nip+1;%...put 2k,2l-1 in lip...   
                     end
                 
                     
                     value= trcf(2*k,2*l);
                     if (abs(value)>=2^N)
                         s=1;
                     else
                         s=0;
                     end
                     op(tbit)=s; tbit=tbit+1;% ... output the sig....
                     if(s==1)%... if significant....
                         sp(nsp,:)= [2*k,2*l]; nsp=nsp+1; last=last+1;%...put 2k,2l in lsp...
                         if(value<0)
                             op(tbit)=1; tbit=tbit+1;
                         else
                             op(tbit)=0; tbit=tbit+1;%.. out put the sign..."0"....
                         end
                     else %.... if insignificant....
                         ip(nip,:)= [2*k,2*l];  nip=nip+1;%...put 2k,2l in lip...   
                     end



                 elseif (2*k-1<=512 && 2*l-1<=512)&& (k<=2^(9-ld)&&l<=2^(9-ld)) %.... for lowest subband..
                     
                     a=k;b=l+2^(9-ld);
                     value= trcf(a,b);
                     if (abs(value)>=2^N)
                         s=1;
                     else
                         s=0;
                     end
                     op(tbit)=s; tbit=tbit+1;% ... output the sig....
                     if(s==1)%... if significant....
                         sp(nsp,:)= [a,b]; nsp=nsp+1; last=last+1;%...put 2k,2l in lsp...
                         if(value<0)
                             op(tbit)=1; tbit=tbit+1;
                         else
                             op(tbit)=0; tbit=tbit+1;%.. out put the sign..."0"....
                         end
                     else %.... if insignificant....
                         ip(nip,:)= [a,b];  nip=nip+1;%...put 2k,2l in lip...   
                     end
                     
                     
                     a=k+2^(9-ld);b=l;
                     value= trcf(a,b);
                     if (abs(value)>=2^N)
                         s=1;
                     else
                         s=0;
                     end
                     op(tbit)=s; tbit=tbit+1;% ... output the sig....
                     if(s==1)%... if significant....
                         sp(nsp,:)= [a,b]; nsp=nsp+1; last=last+1;%...put 2k,2l in lsp...
                         if(value<0)
                             op(tbit)=1; tbit=tbit+1;
                         else
                             op(tbit)=0; tbit=tbit+1;%.. out put the sign..."0"....
                         end
                     else %.... if insignificant....
                         ip(nip,:)= [a,b];  nip=nip+1;%...put 2k,2l in lip...   
                     end
                     
                     
                     a=k+2^(9-ld);b=l+2^(9-ld);
                     value= trcf(a,b);
                     if (abs(value)>=2^N)
                         s=1;
                     else
                         s=0;
                     end
                     op(tbit)=s; tbit=tbit+1;% ... output the sig....
                     if(s==1)%... if significant....
                         sp(nsp,:)= [a,b]; nsp=nsp+1; last=last+1;%...put 2k,2l in lsp...
                         if(value<0)
                             op(tbit)=1; tbit=tbit+1;
                         else
                             op(tbit)=0; tbit=tbit+1;%.. out put the sign..."0"....
                         end
                     else %.... if insignificant....
                         ip(nip,:)= [a,b];  nip=nip+1;%...put 2k,2l in lip...   
                     end
                     
                     
                 end
                 
                 
                 
                 k=is(count,1);  l=is(count,2);
                 if(4*(k-1)+1>512 || 4*(l-1)+1>512) % if the leftover of (k,l) is empty... simply remove it from LIS
                     is(count,:)=[0,0,0];
                 else  % if leftover of (k,l) is non empty ...store it as B type.
                     x=is(count,1);y=is(count,2);
                     is(nis,:)=[x,y,2];nis=nis+1;
                     is(count,:)=[0,0,0];
                 end
             end
         end
        %                 ....... FOR ENTRY OF Type "B".....
        
        %if the entry is of type B.... that is type==2...then do following...
        k=is(count,1);  l=is(count,2); type=is(count,3);
        if((type==2)&&(k~=0 && l~=0))
            
            %find the significance of L(k,l).......
           
            
            
            if k>2^(9-ld)||l>2^(9-ld)               %... for outside lowest subband...
                a=2*(k-1)+1; b=2*(l-1)+1;
                w=2;
                s=0;
                a=2*(a-1)+1; b=2*(b-1)+1;w=w*2;

                while a<=512 && b<=512
                    d=trcf(a:a-1+w,b:b-1+w);
                    nmax=max(max(abs(d)));
                    if nmax>=T
                        s=1;break;
                    else
                        a=2*(a-1)+1; b=2*(b-1)+1;w=w*2;
                    end
                end       
            else                                   %...for lowest subband ........ 
                
                a1=k; b1=l+2^(9-ld); 
                a2=k+2^(9-ld); b2=l; 
                a3=k+2^(9-ld); b3=l+2^(9-ld); 
                s=0;
                w=2;
                
                a1=2*(a1-1)+1; b1=2*(b1-1)+1;
                a2=2*(a2-1)+1; b2=2*(b2-1)+1;
                a3=2*(a3-1)+1; b3=2*(b3-1)+1;
                while (max([a1 a2 a3])<=512 && max([b1 b2 b3])<=512)&&(s==0)
                    d1=trcf(a1:a1-1+w,b1:b1-1+w);
                    d2=trcf(a2:a2-1+w,b2:b2-1+w);
                    d3=trcf(a3:a3-1+w,b3:b3-1+w);
                    nmax1=max(max(abs(d1)));
                    nmax2=max(max(abs(d2)));
                    nmax3=max(max(abs(d3)));
                    nmax=max([nmax1 nmax2 nmax3]);
                    if nmax>=2^N
                        s=1;break;
                    else
                        a1=2*(a1-1)+1; b1=2*(b1-1)+1;
                        a2=2*(a2-1)+1; b2=2*(b2-1)+1;
                        a3=2*(a3-1)+1; b3=2*(b3-1)+1;
                        w=w*2;
                    end
                           
                end
                              
            end   
            
            
            
            %.......output the significance...."sig".....
            op(tbit)=s; tbit=tbit+1;
            
            if(s==1)
                %... add each offspring of..(k,l)...to the end of the LIS as type A entry...
                
                if (k>2^(9-ld))||(l>2^(9-ld))  %... if (k,l) is NOT in the lowest subband.....
                    
                    k=is(count,1);l=is(count,2);
                    if(2*k-1<=512 && 2*l-1<=512)
                      is(nis,:)=[2*k-1,2*l-1,1]; nis=nis+1;
                      is(nis,:)=[2*k-1,2*l,1]; nis=nis+1;
                      is(nis,:)=[2*k,2*l-1,1]; nis=nis+1;
                      is(nis,:)=[2*k,2*l,1]; nis=nis+1;
                    end
                else     %........................ if (k,l) is in the lowest subband........                
                    
                    if(2*k-1<=512 && 2*l-1<=512)
                                                                      
                        is(nis,:)=[k,l+2^(9-ld),1]; nis=nis+1;
                        is(nis,:)=[k+2^(9-ld),l,1]; nis=nis+1;
                        is(nis,:)=[k+2^(9-ld),l+2^(9-ld),1]; nis=nis+1;
                        
                    end
                end
                
                is(count,:)=[0,0,0];        %.... remove (k,l)  .. from LIS.....
            end
        end
        count=count+1;
     end
     tok=toc;
     tis=tis+tok;
     
     
     
     
     %% *******************************REFINEMENT PASS**********************
     %*********************************************************************
     tic;
     count=1;

     while(count<(nsp-last))
              
         x=sp(count,1); y=sp(count,2);
      
         rfbit=bitget(floor(abs(trcf(x,y))),N+1);
                     
         op(tbit)=rfbit; tbit=tbit+1;%output the "rfbit"........
         count=count+1;
     end
     tok=toc;
     tir=tir+tok;
     %*****************************QUANTIXATION STEP UPDATE**************
     %*******************************************************************
     
     
%     fprintf('bitplane=%d      last=%d      tbit=%d \n ',N,last,tbit );
          
     
     N=N-1;

     end
     op=op(1:tbit-1);
           
     fprintf('done !\n\n');
     
%%               ...... CALCULATING THE PERCENTAGE TIME IN SEPERATE PARTS OF PROGRAMS......     
     
     ptin = (tin/(tin+tip+tis+tir))*100;
     ptip = (tip/(tin+tip+tis+tir))*100;
     ptis = (tis/(tin+tip+tis+tir))*100;
     ptir = (tir/(tin+tip+tis+tir))*100;
     
     ttime=tin+tip+tis+tir;
     
     fprintf('the percentage and exact time taken in diff parts of programm are as \nfollow..\n');
     fprintf('                  PERCENTAGE TIME    EXCT TIME  \n');
     fprintf('INITIALIZATION-->>    %2.2f          time:%2.2f \n', ptin,tin );
     fprintf('LIP processing-->>    %2.2f          time:%2.2f \n', ptip,tip );
     fprintf('LIS processing-->>    %2.2f          time:%2.2f \n', ptis,tis );
     fprintf('REFINEMENT PASS->>    %2.2f          time:%2.2f \n', ptir,tir );
     fprintf('----------------------------------------------\n');
     fprintf('TOTAL TIME     ---->>                time:%2.2f  \n', ttime);

end