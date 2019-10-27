function CodeI_d1(Rest)

global Xa
global outline
global Rest
%csize=squa(Rest-1);
for i=1:3
    S(1)=Rest+(Rest-1)*(i-1);
    S(2)=Rest-1;
    ProcessS_d1(S);
end
Rest=Rest+(Rest-1)*3;
if Rest<=length(Xa)
    ProcessI_d1(Rest);
end
%display(Rest);