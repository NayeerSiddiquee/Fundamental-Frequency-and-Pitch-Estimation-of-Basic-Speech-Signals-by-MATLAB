clc;
clearvars;
close all;
%% Reading Audio file 
[xa, fs] = audioread('a.wav');
[xe, fs] = audioread('e.wav');
[xu, fs] = audioread('u.wav');
%% plotting signals in time domain
xa1 = xa(:, 1); % extracting channel one if needed
figure, plot(xa1);
xlabel('Time');
ylabel('Amplitude');
title('Signal "a" in time domain')

xe1 = xe(:, 1); % extracting channel one if needed
figure, plot(xe1);
xlabel('Time');
ylabel('Amplitude');
title('Signal "a" in time domain')

xu1 = xu(:, 1); % extracting channel one if needed
figure, plot(xu1);
xlabel('Time');
ylabel('Amplitude');
title('Signal "a" in time domain')
%% fast fourier transform
NFFT=65536;
xaF = fftshift(abs(fft(xa1,NFFT)));
f=(-1/2:1/NFFT:1/2-1/NFFT)*fs;
figure, plot(f,xaF(1:end))
hold on;
[pka,lka]=findpeaks(xaF, 'MinPeakHeight', 1000, 'MinPeakDistance', 50); % 50 should be varried if fundamental freqs of signal a,e,u are not same
plot(f(lka), xaF(lka), 'o');
title('Signal "a" in frequency domain')
xlabel('Frequency(Hz)');
ylabel('Amplitude');
ffa=min(abs(f(lka)));
fprintf('fundamental frequency of signal "a" is: %f\n', ffa);

xeF = fftshift(abs(fft(xe1,NFFT)));
f=(-1/2:1/NFFT:1/2-1/NFFT)*fs;
figure, plot(f,xeF(1:end))
hold on;
[pke,lke]=findpeaks(xeF, 'MinPeakHeight', 500, 'MinPeakDistance', 50);% 80 should be varried if fundamental freqs of signal a,e,u are not same
plot(f(lke), xeF(lke), 'o');
title('Signal "e" in frequency domain')
xlabel('Frequency(Hz)');
ylabel('Amplitude');
ffe=min(abs(f(lke)));
fprintf('fundamental frequency of signal "e" is: %f\n', ffe);

xuF = fftshift(abs(fft(xu1,NFFT)));
f=(-1/2:1/NFFT:1/2-1/NFFT)*fs;
figure, plot(f,xuF(1:end))
hold on;
[pku,lku]=findpeaks(xuF, 'MinPeakHeight', 1000, 'MinPeakDistance', 50);% 80 should be varried if fundamental freqs of signal a,e,u are not same
plot(f(lku), xuF(lku), 'o');
title('Signal "u" in frequency domain')
xlabel('Frequency(Hz)');
ylabel('Amplitude');
ffu=min(abs(f(lku)));
fprintf('fundamental frequency of signal "u" is: %f\n', ffu);
%% auto correlation in time domain for reducing noise
NFFT=4096;
ra = xcorr(xa1, xa1);
figure, plot(ra);
title('Auto-correlated Signal "a" in Time Domain');
xlabel('Time');
ylabel('Amplitude');
[aa, ba] = findpeaks(ra, 'MinPeakHeight', 1000);
[a1, b1] = max(aa);
aa(b1) = 0;
[a2, b2] = max(aa);
f0a = fs/(ba(b1)-ba(b2));
fprintf('Fundamental frequency of "a" from Autocorrelation is: %f\n', f0a);

re = xcorr(xe1, xe1);
figure, plot(re);
title('Auto-correlated Signal "e" in Time Domain');
xlabel('Time');
ylabel('Amplitude');
[ae, be] = findpeaks(re, 'MinPeakHeight', 1000);
[a3, b3] = max(ae);
ae(b3) = 0;
[a4, b4] = max(ae);
f0e = fs/(be(b3)-be(b4));
fprintf('Fundamental frequency of "a" from Autocorrelation is: %f\n', f0e);

ru = xcorr(xu1, xu1);
figure, plot(ru)
title('Auto-correlated Signal "e" in Time Domain');
xlabel('Time');
ylabel('Amplitude');
[au, bu] = findpeaks(ru, 'MinPeakHeight', 1000);
[a5, b5] = max(au);
au(b5) = 0;
[a6, b6] = max(au);
f0u = fs/(bu(b5)-bu(b6));
fprintf('Fundamental frequency of "a" from Autocorrelation is: %f\n', f0u);
%% PSD analysis
% Welch
hw = spectrum.welch;

xapsdw = psd(hw, xa1, 'fs', fs );
figure, plot(xapsdw);

xepsdw = psd(hw, xe1, 'fs', fs );
figure, plot(xepsdw);

xupsdw = psd(hw, xu1, 'fs', fs );
figure, plot(xupsdw);
% highest point of psd is the pitch of that signal. It should be marked.
%% Using pwelch() function (recommended by matlab)
[Pxxa,Fxa] = pwelch(xa1,length(xa1),0,NFFT,fs);
figure, plot(Fxa, Pxxa);
hold on;
[~,Ia] = max(Pxxa);
ffreqa = abs(Fxa(Ia));
fprintf('Pitch of signal "a" is: %f\n', ffreqa);
plot(Fxa(Ia), Pxxa(Ia), 'o');
title('PSD of Signal "a"');
xlabel('Frequency(Hz)');
ylabel('Power/Frequency');

[Pxxe,Fxe] = pwelch(xe1,length(xe1),0,NFFT,fs);
figure, plot(Fxe, Pxxe);
hold on;
[~,Ie] = max(Pxxe);
ffreqe = abs(Fxe(Ie));
fprintf('Pitch of signal "e" is: %f\n', ffreqe);
plot(Fxe(Ie), Pxxe(Ie), 'o');
title('PSD of Signal "e"');
xlabel('Frequency(Hz)');
ylabel('Power/Frequency');

[Pxxu,Fxu] = pwelch(xu1,length(xu1),0,NFFT,fs);
figure, plot(Fxu, Pxxu);
hold on;
[~,Iu] = max(Pxxu);
ffrequ = abs(Fxu(Iu));
fprintf('Pitch of signal "u" is: %f\n', ffrequ);
plot(Fxu(Iu), Pxxu(Iu), 'o');
title('PSD of signal "u"');
xlabel('Frequency(Hz)');
ylabel('Power/Frequency');

%% Using periodogram() function (recommended by matlab)
[PPxxa,FFxa] = periodogram(xa1,[],NFFT,fs);
figure, plot(FFxa, PPxxa);
hold on;
[~,IIa] = max(PPxxa);
ffreqa = abs(FFxa(IIa));
fprintf('Pitch of signal "a" is: %f\n', ffreqa);
plot(FFxa(IIa), PPxxa(IIa), 'o');
title('PSD of Signal "a"');
xlabel('Frequency(Hz)');
ylabel('Power/Frequency');

[PPxxe,FFxe] = periodogram(xe1,[],NFFT,fs);
figure, plot(FFxe, PPxxe);
hold on;
[~,IIe] = max(PPxxe);
ffreqe = abs(FFxe(IIe));
fprintf('Pitch of signal "e" is: %f\n', ffreqe);
plot(FFxe(IIe), PPxxe(IIe), 'o');
title('PSD of Signal "e"');
xlabel('Frequency(Hz)');
ylabel('Power/Frequency');

[PPxxu,FFxu] = periodogram(xu1,[],NFFT,fs);
figure, plot(FFxu, PPxxu);
hold on;
[~,IIu] = max(PPxxu);
ffrequ = abs(FFxu(IIu));
fprintf('Pitch of signal "u" is: %f\n', ffrequ);
plot(FFxu(IIu), PPxxu(IIu), 'o');
title('PSD of Signal "u"');
xlabel('Frequency(Hz)');
ylabel('Power/Frequency');

%% cepstrum
% Working with a section of signal
dt = 1/fs;

I0 = round(0.1/dt);
Iend = round(0.2/dt);
xac = xa1(I0:Iend);
figure, plot(xac)
title('Working with a section of sound signal "a"');
xlabel('Time');
ylabel('Amplitude');

xec = xe1(I0:Iend);
figure, plot(xec);
title('Working with a section of sound signal "e"');
xlabel('Time');
ylabel('Amplitude');

xuc = xu1(I0:Iend);
figure, plot(xuc);
title('Working with a section of sound signal "u"');
xlabel('Time');
ylabel('Amplitude');

ca = rceps(xac);
figure, plot(ca);
title('Cepstrum of signal "a"');
xlabel('Quefrency(s)')
ylabel('Amplitude');

ce = rceps(xec);
figure, plot(ce)
title('Cepstrum of signal "e"');
xlabel('Quefrequency(s)')
ylabel('Amplitude');

cu = rceps(xuc);
figure, plot(cu)
title('Cepstrum of signal "u"');
xlabel('Quefrequency(s)')
ylabel('Amplitude');
%% Let's the fundamental frequency is in between f1 = 500Hz and f2 = 50Hz
f1 = 500;
f2 = 50;
t = 0:dt:length(xac)*dt-dt;
trng = t(t>=1/f1 & t<=1/f2);
crng_a = ca(t>=1/f1 & t<=1/f2);
crng_e = ce(t>=1/f1 & t<=1/f2);
crng_u = cu(t>=1/f1 & t<=1/f2);

[~,Ia] = max(crng_a);
figure, plot(trng, crng_a);
hold on;
plot(trng(Ia), crng_a(Ia), 'o');
title('Real Cepstrum F0 Estimation of signal "a"');
xlabel('Time');
ylabel('Amplitude');

[~,Ie] = max(crng_e);
figure, plot(trng, crng_e);
hold on;
plot(trng(Ie), crng_e(Ie), 'o');
title('Real Cepstrum F0 Estimation of signal "e"');
xlabel('Time');
ylabel('Amplitude');

[~,Iu] = max(crng_u);
figure, plot(trng, crng_u);
hold on;
plot(trng(Iu), crng_u(Iu), 'o');
title('Real Cepstrum F0 Estimation of signal "u"');
xlabel('Time');
ylabel('Amplitude');

fprintf('Real cepstrum F0 estimation of sound "aaa..." is %f Hz.\n',1/trng(Ia));
fprintf('Real cepstrum F0 estimation of sound "eee..." is %f Hz.\n',1/trng(Ie));
fprintf('Real cepstrum F0 estimation of sound "uuu..." is %f Hz.\n',1/trng(Iu));