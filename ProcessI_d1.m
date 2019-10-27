function ProcessI_d1(Rest)

global Xa
global Rest
global T
global outline
global n
global count
if Rest<=length(Xa)
    if outline(1,count)=='1'
        count=count+1;
        CodeI_d1(Rest);
    else
        count=count+1;
    end
end
