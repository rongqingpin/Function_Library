% generate synthetic signals to test the algorithms
% wave packet as the source
% WGN as background noise
% a: magnitude; z0: envelope amplitude, No. of oscillations
% Lag: lag between NF and FF
% acoef: relative max magnitude - wgn/source

function [lst0,snrs,sources,noises] = synthetic(nsnr,t,kf,ff,lag0,sgn00,acoef)

a = 1; % amplitude
z0 = 5; % envelope amplitude, indicator of number of oscillations
% acoef = 3; % ratio of magnitude wgn/source

nt = length(t); dt = t(2)-t(1);
ns = length(kf);

dTmax = round(1/min(kf)/dt);
kfmax = 44;%round((ns-1)/2+1); % most loud around St 0.2

cnt = 0;
snrs = zeros(nsnr,nt);
lst0 = zeros(ns-2,nsnr+1);
sources = snrs; noises = snrs;
for is = 2:1:ns-1;
    cnt = cnt+1;
    kf0 = kf(is); % frequency
    it0 = round(rand(1)*(nt-2*dTmax))+dTmax; % center of time appearance
    its = it0+lag0;
    A = a/2*(1-abs(is-kfmax)/(ns-1)*2)+a/2; % a/2~a
    
    % sources
    lst0(cnt,:) = [is,its];
    snrs0 = zeros(nsnr,nt);
    for isnr = 1:nsnr;
        src1 = sgn00(isnr)*A*cos(2*pi*(t-t(its(isnr)))*kf0).*...
            exp(-2*pi^2*kf0^2*(t-t(its(isnr))).^2/z0^2);
        snrs0(isnr,:) = norm2(src1,1);
    end
    sources = sources + snrs0;
    
    % noise
    [~,tmp0] = min(abs(kf-kf0)); % +-1 scales
    tmp = max(tmp0-1,1); freq1 = kf(tmp);
    tmp = min(tmp0+1,ns); freq2 = kf(tmp);
    noise = zeros(nsnr,nt);
    for isnr = 1:nsnr;
        wgn1 = wgn(1,nt,1);
        wgn1 = wgn1/max(wgn1)*max(snrs0(isnr,:))*acoef;
        % frequency filter: keep only +-1 scales
        wgn1 = norm2(wgn1,1); wgn1h = fft(wgn1,nt);
        for ifreq = 1:length(ff);
            if ff(ifreq) < freq1 || ff(ifreq) > freq2;
                wgn1h(ifreq) = 0+0i;
            end
        end
        wgn1 = ifft(wgn1h);
        wgn1 = real(wgn1); wgn1 = norm2(wgn1,1);
        noise(isnr,:) = wgn1;
    end
    noises = noises + noise;
    
    % noise + sources
    snrs = snrs + snrs0 + noise;
%     figure;
%     for isnr = 1:nsnr; plot(t,snrs(isnr,:)); hold on; end
    
%     % plot the signals
%     if is == 5 || is == 60;
%     h = figure;
%     for isnr = 3;%1:nsnr;
%         y = snrs0(isnr,:); fy = fft(y,nt);
%         [ey,fey] = fftspect(fy,freq);
%         z = noise(isnr,:); fz = fft(z,nt);
%         [ez,fez] = fftspect(fz,freq);
%         subplot(3,1,1);
%         plot(t,y); hold on; plot(t,z); hold off;
%         subplot(3,1,2);
% %         semilogx(freq,fey);
%         semilogx(freq,ey);
%         subplot(3,1,3);
% %         semilogx(freq,fez);
%         semilogx(freq,ez);
%     end
%     end
%     pause(1);
%     close(h);
end
[~,idc] = sort(lst0(:,2));
lst0 = lst0(idc,:);
% figure;
% for isnr = 1:nsnr; plot(t,snrs(isnr,:)); pause; end
% plot the signals
isnr = 3;
y = sources(isnr,:); fy = fft(y,nt);
[ey,fey] = fftspect(fy,freq);
z = noises(isnr,:); fz = fft(z,nt);
[ez,fez] = fftspect(fz,freq);
figure;
% subplot(2,1,1);
plot(t*1e3,snrs(isnr,:));
axis([t(1)*1e3 t(nt)*1e3 -2 2]);
set(gca,'FontSize',17);
title('Simulated Signal','FontSize',21);
% subplot(2,1,2);
% plot(t*1e3,snrs(isnr+2,:));
% axis([t(1)*1e3 t(nt)*1e3 -2 2]);
% set(gca,'FontSize',17);
xlabel('Time (ms)','FontSize',21);
SNR = std(sources(isnr,:))/std(noises(isnr,:));
text(30,1.5,['S-N Ratio = ',sprintf('%.2f',SNR)],'FontSize',17);
figure;
loglog(freq*D/c/Ma,fey); hold on; loglog(freq*D/c/Ma,fez);
% semilogx(freq*D/c/Ma,ey); hold on; semilogx(freq*D/c/Ma,ez);
axis([5e-3 1 1e-3 5e3]);
set(gca,'FontSize',17,'XTick',[.1 .2 .3 .5 .9]);
ylabel('Strouhal','FontSize',21);
title('Compensated Fourier Spectra','FontSize',21);
hlgd = legend('Sources','WGN');
set(hlgd,'FontSize',17,'Location','SouthWest');
%     s = snrs(isnr,:); fs = fft(s,nt);
%     [~,fes] = fftspect(fs,freq);

return