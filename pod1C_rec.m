% POD signal reconstruction
% rows as spatial positions and columns as temporal indices

function [urec] = pod1C_rec(a,phi,nmode)
    [nx,nt] = size(phi);
    urec = zeros(nx,nt); % reconstruction
    for ii = 1:nt
        for jj = 1:nmode
            urec(:,ii) = urec(:,ii) + a(ii,jj) * phi(:,jj);
        end
    end
return