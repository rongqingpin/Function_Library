% mexican hat transform
function zmex=mexhat(xf,ff,s)
%    xf=fft(x);
    nx = length(xf); ns = length(s);
    zmex=zeros(ns,nx);
    for jj=1:ns;
        g2=zeros(1,nx); yf=zeros(1,nx);
        for ii=1:nx;
            z=(2*pi*ff(ii))^2;
            g2(ii)=z*exp(-z*s(jj))+0*j;
            yf(ii)=xf(ii)*g2(ii);
        end
        zmex(jj,:)=real(ifft(yf))*s(jj);
    end
return