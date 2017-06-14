function ts2 = downsmpl(ts,r)
% Downsamples a vector to a smaller support
% here, the ratio r is assumed to be larger than 2
n1 = length(ts);
n2 = floor(n1/r);
ts2 = zeros(1,n2);
for i2 = 1:n2;
    i1 = round((i2-1)*r);
    intrvl = max([i1-1,1]):min([i1+1,n1]);
    ts2(i2) = mean(ts(intrvl)); % box averaging of 3 nearest points
    if i1 == 1; ts2(i2) = ts(i2); end
end
return