function yml = invmor(zmor,ff,kf,drs)
% inverse Morlet transform
% zmor: complex wavelet coefficients
% ff: vector of frequencies (linear)
% kf: vecotr of frequencies (logarithmic)
% drs: ratio of successive scales
% y0: reconstructed signal
%   [ns,n] = size(zmor); dls = log(drs);
%   sq2pi = sqrt(2*pi); z0 = 5; cps= 1.4406;
%   for is=1:ns;  ymor = zmor(is,:); xh = fft(ymor);
%     for ii=1:n ; z=ff(ii)/kf(is);
%       morh = z0/kf(is)/sq2pi * (exp(-(z0^2*(1-z)^2)/2) ...
%        - exp(-z0^2*(1+z^2)/2) ) +0*i;
%       morh = morh * kf(is)/sqrt(cps);
%       yh(ii) = xh(ii)*morh;
%     end
%     yinv(is,:) = real(ifft(yh));
%   end
% % Simpson integration over all scales
%   for ix=1:n; y0(ix) = 0. ; 
%     for is=2:2:ns-1 ;      
%       y0(ix) = y0(ix) + (yinv(is-1,ix)+4*yinv(is,ix)+yinv(is+1,ix)) ;
%     end
%     y0(ix) = y0(ix)*dls/3; 
%   end
    z0=5;
    cps=1.4406;
    [ns,nx] = size(zmor);
    for jj=1:ns;
        ymf=fft(zmor(jj,:));
        c1=kf(jj)/sqrt(cps);
        c2=z0/kf(jj)/sqrt(2*pi);
        for ii=1:nx;
            z=ff(ii)/kf(jj);
            mor(ii)=c1*(c2*(exp(-z0^2*(1-z)^2/2)-exp(-z0^2*(1+z^2)/2))+0*i);
            yml(ii)=ymf(ii)*mor(ii);
        end
        yinv(jj,:)=real(ifft(yml));
    end
    for ii=1:nx;
        yml(ii)=0;
        for jj=2:2:ns-1;
            yml(ii)=yml(ii)+(yinv(jj-1,ii)+4*yinv(jj,ii)+yinv(jj+1,ii));
        end
        yml(ii)=yml(ii)*log(drs)/3;
    end
return