function Refinement_d(LSP,LSPflag)

global Xa
global T
global outline
global n
global count
for i=1:LSPflag
    if outline{n}(count)=='1'
        if Xa(LSP(i))>0
            Xa(LSP(i))=Xa(LSP(i))+T/2;
        else
            Xa(LSP(i))=Xa(LSP(i))-T/2;
        end
    else
        if Xa(LSP(i))>0
            Xa(LSP(i))=Xa(LSP(i))-T/2;
        else
            Xa(LSP(i))=Xa(LSP(i))+T/2;
        end
    end
    count=count+1; 
end