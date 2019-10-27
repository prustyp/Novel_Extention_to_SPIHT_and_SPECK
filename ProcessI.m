function ProcessI(Rest)

global Xa
global Rest
global T
global outline
if Rest<=length(Xa)
    if max(abs(Xa(Rest:end)))>=T
        outline=[outline,'1'];
        CodeI(Rest);
    else
        outline=[outline,'0'];
    end
end
