function  [snr,mse] = psnr1 (A,B)


diff = A - B;	
diff_sq = diff .^ 2;		% difference squared
mse_clmn = mean(diff_sq);	% means square diff. of the columns;
mse = mean(mse_clmn);

if (mse == 0)
    snr=Inf;
else
    snr = 10*log10(255^2/mse);          % PSNR
end