function X0=recom(Xa)

len=length(Xa);
k=sqrt(len);
N=mapping(k);
X0=zeros(k);
for i=1:k
    for j=1:k
       
        X0(i,j)=Xa(N(i,j));
    end
end