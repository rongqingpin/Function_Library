function ynew = de_alias_fft(y,dt)
   % dealiasing before downsampling
   n1 = length(y);
   npad = 2^(ceil(log2(n1)));
   t = [0:npad-1]*dt; ff = fftfreq(t);
   % 2/3 rule, truncating (refe: pseudo-spectral_2.pdf)
   ftr = max(ff)*2/3;
   yh = fft(y,npad);
   for ii = 1:npad;
       if abs(ff(ii)) >= ftr; yh(ii) = 0; end
   end
   ynew = ifft(yh,npad);
   ynew = ynew(1:n1);
%    % check the signals
%    plot(y); hold on;
%    plot(ynew,'r');
 return