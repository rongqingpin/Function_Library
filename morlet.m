% morlet transform
% xf is the fft of x
% already zero-padded to the next power of 2
function [zabs,zphs,zmor]=morlet(xf,ff,kf)
%     nx = length(xf);
%     z0=5;
%     cps=1.4406;
%     ns = length(kf);
%     zz = zeros(ns,nx)+0*i;
%     for jj=1:ns;
%         c1=kf(jj)/sqrt(cps);
%         c2=z0/kf(jj)/sqrt(2*pi);
%         yf=zeros(1,nx);
%         for ii=1:nx;
%             z=ff(ii)/kf(jj);
%             mor=c1*(c2*(exp(-z0^2*(1-z)^2/2)-exp(-z0^2*(1+z^2)/2))+0*i);
%             yf(ii)=xf(ii)*mor;
%         end
%         zz(jj,:)=ifft(yf);
%     end
%     zmor=abs(zz);
%     zphs=angle(zz);
    nx = length(xf); ns = length(kf);
    z0=5;
    cps=1.4406;
    for jj=1:ns;
        c1=kf(jj)/sqrt(cps);
        c2=z0/kf(jj)/sqrt(2*pi);
        z=ff/kf(jj);
        mor=c1*( c2*( exp(-z0^2*(1-z).^2/2)-exp(-z0^2*(1+z.^2)/2) )+...
            zeros(1,nx)*i );
        yf=xf.*mor;
        zmor(jj,:)=ifft(yf);
    end
    zabs=abs(zmor);
    zphs=angle(zmor);
return