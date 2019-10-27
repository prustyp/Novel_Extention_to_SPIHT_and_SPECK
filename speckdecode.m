function Xb=speckdecode(linein,threshold,siz,level,sm)
%speck
%line1='11+1-00111+000001010101+00000';
%line2='1-1+00000000000001010';
%line3='1+1+1-00011+1+1-0101-1-1+101+0010001+01101+0011-0000101+000100110';
%line4='0001-01-00001+1+01+1+1+000011+1-1+1+11+1-1+0111+1+0010001+101+00101+1-1+10011101111011000110';
%line5='01-1+1+1+01+1-1+01+1+1+1-1+1-1-1+01+01+1+11011111011001001000100101110010100101100';
%X0=[63 -34 49 10 7 13 -12 7 ;
%    -31 23 14 -13 3 4 6 -1 ;
%   15 14 3 -12 5 -7 3 9 ;
%   -9 -7 -14 8 4 -2 3 2 ;
%   -5 9 -1 47 4 6 -2 2 ;
%   3 0 -3 2 3 -2 0 4;
%   2 -3 6 -4 3 6 3 6 ;
%   5 11 5 6 0 3 -4 4 ];
global LISi;global LISj;global LISk;
global LSP
global Xa
global Rest
global outline
global T
global each
global count
global n
global LISisz
%outline={line1,line2,line3,line4,line5};
outline=linein;
%initialization
%Sorting=5;
%T=32;
T=threshold;
Sorting=log2(T);
%Xsize=8;
Xsize=siz;
%--partition image transform X into two sets:S=root,and I=X-S;
Xa=zeros(1,Xsize^2);
k=siz/2^level;
Asize=k*k;
%Asize=4;
Rooti=[1];Rootj=[Asize];  %Rooti,Asize
Rest=Asize+1;
%add S to LIS and set LSP={}
LISi=Rooti;LISj=Rootj;
LSP=[];
%Sorting Pass
n=1;
if Sorting< sm
    display('error');
end
while n<=Sorting & n<=sm
    each=1;count=1;
    LSPflag=length(LSP);
    LISisz=length(LISi);
    while each<=LISisz
        S=[LISi(each),LISj(each)];
        ProcessS_d(S);
        each=each+1;    
    end
    ProcessI_d(Rest);
    %Refinement Pass
    Refinement_d(LSP,LSPflag);
    [LISj,index]=sort(LISj);
    LISi=LISi(index);  
    n=n+1;T=T/2;
end
Xb=recom(Xa);
%diff=Xb-origin;
%display(diff);
