% 2D histogram: Strouhal vs magnitude

function z = myhist2D(sgn,binx,biny)
    nbins1 = length(biny); nbins2 = length(binx);
    db1 = biny(2)-biny(1); db2 = binx(2)/binx(1);
    [nn,~] = size(sgn);
    z = zeros(nbins1,nbins2);
    for ii = 1:nn;
        ix = sgn(ii,1);
        iy = sgn(ii,2);
        for j = 1:nbins2-1;
            jbin = binx(j);
            if max(jbin,ix)/min(jbin,ix) <= sqrt(db2);
                for i = 1:nbins1-1;
                    if abs(iy-biny(i)) <= db1/2;
                        z(i,j) = z(i,j)+1;
                        break;
                    end
                end
            end
        end
    end
return