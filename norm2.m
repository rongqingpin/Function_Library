% remove mean and normalize by std
function aa = norm2(aa,num)
    [nrow,ncol] = size(aa);
    for irow = 1:nrow;
        aa(irow,:) = aa(irow,:)-mean(aa(irow,:));
        if num == 2;
            aa(irow,:) = aa(irow,:)/std(aa(irow,:));
        end
    end
return