% POD decomposition - 1C2D data
% and signal reconstruction
% rows as spatial positions and columns as temporal indices

function [phi,a,lam] = pod1C(u)
    [nx,nt] = size(u);
    C = u'*u/nt;
    [a,lam] = eig(C);
    lamda = zeros(1,nt);
    for ii = 1:nt;
        lamda(ii) = lam(ii,ii);
    end
    if issorted(lamda) ~= 1; disp('error!'); end % sorted in ascending?
    lam = rot90(lam,2); a = fliplr(a); % reset in descending order
    for ii = 1:nt; % normalize
        a(:,ii) = a(:,ii)*sqrt(lam(ii,ii)*nt);
    end
    phi = u*a/nt/lam; % base functions
return