function ts2 = de_alias(ts,dt)
% dealiasing before downsampling
   n1 = length(ts);
   npad = 2^(ceil(log2(n1)));
   tspad = zeros(1,npad);
   tspad(1:n1) = ts(1:n1);
%    dt = 1;
   t = [0:npad-1]*dt; ff = fftfreq(t);
   nvcs = 8 ;% number of voices per octave (resolution in calculations)
   drf = 2^(1/nvcs); % ratio of frequency 
   frat = 25; % bracket of frequencies
   ns = ceil(log2(frat)*nvcs); ns = 2*ceil(ns/2)+1; %odd number of modes
   kf(ns) = 1/dt/3; % Nyquist 2/3
   for is=ns-1:-1:1; kf(is) = kf(is+1)/drf; end
   %for is=1:ns ; s(is) = 1/(kf(is)*2*pi)^2;  end % 
   %kf
   yh1 = fft(tspad); 
   [~,~,zc] = morlet(yh1,ff,kf);
   ts2 = invmor(zc,ff,kf,drf^2); % filtered inverse
   ts2 = ts2(1:n1);
   figure; plot(t(1:1000),tspad(1:1000),'k',t(1:1000),ts2(1:1000)+0.0003,'g');
%    pause(1)
 return