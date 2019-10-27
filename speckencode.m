function [lineout,threshold,Arow,ratio]=speckencode(X0,level,sm,max_bits)

%speck encode,X0
%X1=[63 -34 49 10 7 13 -12 7 ;
%    -31 23 14 -13 3 4 6 -1 ;
%   15 14 3 -12 5 -7 3 9 ;
%   -9 -7 -14 8 4 -2 3 2 ;
%   -5 9 -1 47 4 6 -2 2 ;
%   3 0 -3 2 3 -2 0 4;
%   2 -3 6 -4 3 6 3 6 ;
%   5 11 5 6 0 3 -4 4 ];
%X0=X1;
global LISi;global LISj;  %LIS
global LSP                %LSP
global Xa                 
global Rest               
global outline            
global T                  
global each                
global n                  
global LISisz             
%initialization
[T,Sorting]=Weight(X0);
threshold=T;

outline=''; %
%--partition image transform X into two sets:S=root,and I=X-S;
Xa=spitX1(X0); %Hn Vn Dn Hn-1 Vn-1 Dn-1 ....
[Arow,Acol]=size(X0);
k=Arow/2^level;
Asize=k*k;
%Asize=4;%A
Rooti=[1];Rootj=[Asize];  %Rooti
Rest=Asize+1;
%add S to LIS and set LSP={}
LISi=Rooti;LISj=Rootj;
LSP=[];
%Sorting Pass
n=1;
bitstotal=0;
outputcount=1;
display(Sorting);
if sm>Sorting
    display('error');    
end
while n<=Sorting & bitstotal<=max_bits & T>=2
    each=1;
    LSPflag=length(LSP);
    LISisz=length(LISi);
    while each<=LISisz
        S=[LISi(each),LISj(each)];
        ProcessS(S);
        each=each+1;       
    end
    ProcessI(Rest);
    %Refinement Pass
    Refinement(LSP,LSPflag);
    [LISj,index]=sort(LISj);
    LISi=LISi(index);  
    %display(n);
    T=T/2;n=n+1;
   % if n==3
   %    each;
   %end
    display(outline); 
    length(outline)
    bitstotal=bitstotal+length(outline) 
    lineout(outputcount)={outline};      
    outputcount=outputcount+1
    outline='';
end
ratio=((bitstotal))/(Arow*Acol)
%ratio=bitstotal

%display(ratio);

