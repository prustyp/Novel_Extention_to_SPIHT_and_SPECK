function  CodeS(S)

global Xa
global T
global LSP
global LISi;global LISj;
global outline
global each
%Partition S into four equal subsets Sn
%if S(2)==1
%    display(S(1));
%end
%shape(S);  
for i=1:4
    Sn(1)=S(1)+(i-1)*S(2)/4;
    Sn(2)=S(2)/4;
    if max(abs(Xa(Sn(1):Sn(1)+Sn(2)-1)))>=T
        outline=[outline,'1'];
        if Sn(2)==1        
            LSP=[LSP,Sn(1)];
            if Xa(Sn(1))>0
                outline=[outline,'+'];            
            else
                outline=[outline,'-'];
            end
        else
            CodeS(Sn);
        end
    else
        outline=[outline,'0'];
        LISi=[LISi,Sn(1)];  
        LISj=[LISj,Sn(2)];
        %each=each+1;
    end
end
