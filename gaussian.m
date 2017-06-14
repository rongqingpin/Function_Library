% Gaussian filter
function gcor = gaussian(xcor,ff,kf)
    nx = length(ff); ns = length(kf);
    gcor = zeros(ns,nx);
    for is = 1:ns;
        fxcor = fft(xcor(is,:),nx);
        fgauss = exp(-ff.^2/kf(is)^2);
        fgcor = fxcor.*fgauss; %/kf(is)^2
        gcor(is,:) = real(ifft(fgcor));
    end
return