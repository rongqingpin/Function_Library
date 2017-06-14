% morlet energy spectra
function lEl = morspec(znmor,dx)
    [ns,nx] = size(znmor);
    lEl = zeros(1,ns);
    for jj = 1:ns;
        for ii = 1:nx;
            lEl(jj) = lEl(jj)+znmor(jj,ii)^2;
        end
    end
    lEl = lEl/2/nx/dx;
return