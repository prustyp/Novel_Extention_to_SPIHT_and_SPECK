function X = mapping(n)
%n=4;
if n == 2

   X = [1 2; 3 4];

else

   B = mapping(n/2);                         

   X = [B B+(n/2)^2; B+(n/2)^2*2 B+(n/2)^2*3];

end

