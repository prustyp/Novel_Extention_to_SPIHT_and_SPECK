function Refinement(LSP,LSPflag)
%for each (i,j) in LSP,except those included in the last sorting
%pass,output the nth MSB of abs(c(i,j))
global Xa
global T
global outline
for i=1:LSPflag
    %if i==15
    %    i
    %end
    test=abs(Xa(LSP(i)));
    P=dec2bin(test);
    P=P(end:-1:1);
    outline=[outline,P(log2(T)+1)]; 
end