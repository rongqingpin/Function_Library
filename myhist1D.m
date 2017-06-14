% 1D histogram

function z = myhist1D(sgn,bins,lnr)
    nbins = length(bins);
    z = zeros(1,nbins);
    nn = length(sgn);
    for ii = 1:nn;
        isgn = sgn(ii);
        if lnr == 1;
            dbin = bins(2)-bins(1);
            for ibin = 1:nbins-1;
                if abs(isgn-bins(ibin)) <= dbin/2;
                    z(ibin) = z(ibin)+1;
                    break;
                end
            end
        else
            dbin = sqrt(bins(2)/bins(1));
            for ibin = 1:nbins-1;
                i1 = max(isgn,bins(ibin));
                i2 = min(isgn,bins(ibin));
                if i1/i2 <= dbin;
                    z(ibin) = z(ibin)+1;
                    break;
                end
            end
        end
    end
return