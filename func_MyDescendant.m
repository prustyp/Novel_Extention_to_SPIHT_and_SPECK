function value = func_MyDescendant(i, j, type, m)
% Matlab implementation of SPIHT (without Arithmatic coding stage)
%
% Find the descendant with largest absolute value of pixel (i,j)
%
% input:    i : row coordinate
%           j : column coordinate
%           type : type of descendant
%           m : whole image
%
% output:   value : largest absolute value
%

s = size(m,1);

S = [];

index = 0; a = 0; b = 0;

while ((2*i-1)<s & (2*j-1)<s)
    a = i-1; b = j-1;

    mind = [2*(a+1)-1:2*(a+2^index)];
    nind = [2*(b+1)-1:2*(b+2^index)];
    
    
    chk = mind <= s;
    len = sum(chk);
    if len < length(mind)
        mind(len+1:length(mind)) = [];
    end
    
    
    chk = nind <= s;
    len = sum(chk);
    if len < length(nind)
        nind(len+1:length(nind)) = [];
    end
    
    S = [S reshape(m(mind,nind),1,[])];
    
    index = index + 1;
    i = 2*a+1; j = 2*b+1;
end

if type == 1
    S(:,1:4) = [];; 
end

value = max(abs(S));