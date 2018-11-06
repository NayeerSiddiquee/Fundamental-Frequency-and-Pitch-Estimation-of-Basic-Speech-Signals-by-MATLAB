clc;
clearvars;
close all;
%% Reading Audio file 
[xa, fs] = audioread('a.wav');
[xe, fs] = audioread('e.wav');
[xu, fs] = audioread('u.wav');
%% Auto-correlation for reducing noise effect
NFFT=8192;
ra = xcorr(xa, xa);
figure, plot(ra);
title('Auto-correlation function of Signal "a"');
xlabel('Time');
ylabel('Amplitude');
[aa, ba] = findpeaks(ra, 'MinPeakHeight', 1000);
[a1, b1] = max(aa);
aa(b1) = 0;
[a2, b2] = max(aa);
f0a = abs(fs/(ba(b1)-ba(b2)));
fprintf('Fundamental frequency of sound signal "a" from Autocorrelation is: %3.2f Hz\n', f0a);

re = xcorr(xe, xe);
figure, plot(re);
title('Auto-correlation function of Signal "e"');
xlabel('Time');
ylabel('Amplitude');
[ae, be] = findpeaks(re, 'MinPeakHeight', 1000);
[a3, b3] = max(ae);
ae(b3) = 0;
[a4, b4] = max(ae);
f0e = abs(fs/(be(b3)-be(b4)));
fprintf('Fundamental frequency of sound signal "e" from Autocorrelation is: %3.2f Hz\n', f0e);

ru = xcorr(xu, xu);
figure, plot(ru)
title('Auto-correlation function of Signal "u"');
xlabel('Time');
ylabel('Amplitude');
[au, bu] = findpeaks(ru, 'MinPeakHeight', 1000);
[a5, b5] = max(au);
au(b5) = 0;
[a6, b6] = max(au);
f0u = abs(fs/(bu(b5)-bu(b6)));
fprintf('Fundamental frequency of sound signal "u" from Autocorrelation is: %3.2f Hz\n', f0u);