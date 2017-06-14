function ff = fftfreq(x)
    % 2-sided f scale
    nx = length(x); dx = x(2)-x(1);
    ff=zeros(1,nx);
    for ii=1:nx/2;
        ff(ii)=(ii-1)/nx/dx;
    end
    for ii=(1+nx/2):nx;
        ff(ii)=(ii-nx-1)/nx/dx;
    end