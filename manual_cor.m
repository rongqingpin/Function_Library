function mcor=manual_cor(p3,p6,lag)
    nx = length(p3);
    nlag = length(lag);
    mcor = zeros(1,nlag);
    for ii=1:nlag;
        ilag = lag(ii);
        if ilag >= 0;
            u = p3(1:nx-ilag);
            v = p6(ilag+1:nx);
            u = norm2(u,2); v = norm2(v,2);
            mcor(ii) = u*v'/(nx-ilag);
        else
            u = p3(-ilag+1:nx);
            v = p6(1:nx+ilag);
            u = norm2(u,2); v = norm2(v,2);
            mcor(ii) = u*v'/(nx+ilag);
        end
    end
return