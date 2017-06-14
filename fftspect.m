% FFT spectra and compensated spectra

function [Ep,fEp] = fftspect(uh,freq)
    nt = length(uh);
    nf = length(freq);
    Ep = zeros(1,nf); fEp = Ep;
    for ii = 1:nf;
        Ep(ii) = (abs(uh(ii+1))^2+abs(uh(nt-ii+1))^2)/nt/2;%*dt
        fEp(ii) = Ep(ii)*freq(ii);
    end
return