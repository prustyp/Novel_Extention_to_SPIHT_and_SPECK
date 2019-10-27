function [threshold,laststeplevel]=Weight(A)

X=A;
Y0=max(abs(X));
     Y1=max(Y0); 
     for i=0:20;
        if 2^i<=Y1 & 2^(i+1)>Y1;
           threshold=2^i;   % get initial threshold T0;
           %initialthreshold=threshold; % get initial threshold T0;
           laststeplevel=i;% last step level
           break;
        end;
     end;