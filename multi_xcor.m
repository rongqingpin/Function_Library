% contributions to multi-correlation
% inorm = 1 --> with normalization
% iphase = 1 --> ignore difference in phase
% all signals ordered by increasing time lag (always ? 0)

function [corrs,Pnew] = multi_xcor(P,lags)
    [nsnr,nt] = size(P);
    Pnew = zeros(nsnr,nt);
    for isnr = 1:nsnr;
        aa = P(isnr,:);
        aa = norm2(aa,1);
        aa = abs(aa);
%         % normalization
        mnt = nthroot(mean(aa.^nsnr),nsnr);
        aa = aa/mnt;
        % save the data
        Pnew(isnr,:) = aa;
        % correlation
        if isnr == 1;
            corrs = aa;
        else
            jlag = lags(isnr)-lags(1);
            if jlag >= 0;
                corrs = corrs(1:nt-jlag).*aa(1+jlag:nt);
            else
                corrs = corrs(-jlag+1:nt).*aa(1:nt+jlag);
            end
        end
    end
return