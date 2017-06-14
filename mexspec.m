% mexhat energy spectra
function hEh=mexspec(zmex,dx)
    [ns,nx] = size(zmex);
    hEh=zeros(1,ns);
    for jj=1:ns;
        for ii=1:nx;
            hEh(jj)=hEh(jj)+zmex(jj,ii)^2;
        end
    end
    hEh=hEh*2/nx/dx;
return