function Xa=spitX1(X0)

[xrow,xcol]=size(X0);
N=mapping(xrow);

for i=1:xrow
    for j=1:xcol
        Xa(N(i,j))=X0(i,j);
        
    end
end
