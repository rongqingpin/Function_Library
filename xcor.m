function corr = xcor(p3,p6,lag)
    nx = length(p3); nlag = length(lag);
    na = 2^nextpow2(nx);
    p3 = p3-mean(p3);
    p6 = p6-mean(p6);
    p3 = p3/std(p3); p6 = p6/std(p6);
    p3h = fft(p3,na); p6h = fft(p6,na);
    corr = zeros(1,nlag);
    c1 = find(lag < 0); c2 = find(lag == 0);
    if numel(c1) ~= 0;
        c1 = c1(1); nt = c2-c1+1;
        cor = real(ifft(conj(p6h).*p3h))/nx;
        for i = 1:nt; corr(i) = cor(nt-i+1); end
    end
    cor = real(ifft(conj(p3h).*p6h))/nx;
    if numel(c2) == 0;
        corr(1:nlag) = cor(lag(1)+1:lag(nlag)+1);
    else
        corr(c2:nlag) = cor(1:nlag-c2+1);
    end
return