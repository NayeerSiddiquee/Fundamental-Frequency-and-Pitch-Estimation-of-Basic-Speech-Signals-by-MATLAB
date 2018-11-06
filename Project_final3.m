clc;
clearvars;
close all;
%% Estimation of Pitch using PDD
%% Reading Audio file 
[xa, fs] = audioread('a.wav');
[xe, fs] = audioread('e.wav');
[xu, fs] = audioread('u.wav');
%% Power Spectral Density (PSD) analysis using psd() function 
hw = spectrum.welch;

xapsdw = psd(hw, xa, 'fs', fs );
figure, plot(xapsdw);
xepsdw = psd(hw, xe, 'fs', fs );
figure, plot(xepsdw);
xupsdw = psd(hw, xu, 'fs', fs );
figure, plot(xupsdw);
% highest point of psd is the pitch of that signal.
%% Welch's Periodogram Using pwelch() function (recommended by matlab)
NFFT = 8192;
[Pxxa,Fxa] = pwelch(xa,length(xa),0,NFFT,fs);
figure, plot(Fxa, Pxxa);
hold on;
[~,Ia] = max(Pxxa);
ffreqa = abs(Fxa(Ia));
fprintf('Welch Estimate of the Pitch of signal "a" is: %3.2f Hz\n', ffreqa);
plot(Fxa(Ia), Pxxa(Ia), 'o');
title('Welch Periodogram of Signal "a"');
xlabel('Frequency(Hz)');
ylabel('Power/Frequency');

[Pxxe,Fxe] = pwelch(xe,length(xe),0,NFFT,fs);
figure, plot(Fxe, Pxxe);
hold on;
[~,Ie] = max(Pxxe);
ffreqe = abs(Fxe(Ie));
fprintf('Welch Estimate of the Pitch of signal "e" is: %3.2f Hz\n', ffreqe);
plot(Fxe(Ie), Pxxe(Ie), 'o');
title('Welch Periodogram of Signal "e"');
xlabel('Frequency(Hz)');
ylabel('Power/Frequency');

[Pxxu,Fxu] = pwelch(xu,length(xu),0,NFFT,fs);
figure, plot(Fxu, Pxxu);
hold on;
[~,Iu] = max(Pxxu);
ffrequ = abs(Fxu(Iu));
fprintf('Welch Estimate of the Pitch of signal "u" is: %3.2f Hz\n', ffrequ);
plot(Fxu(Iu), Pxxu(Iu), 'o');
title('Welch Periodogram of signal "u"');
xlabel('Frequency(Hz)');
ylabel('Power/Frequency');
%% Periodogram Using periodogram() function (recommended by matlab)
[PPxxa,FFxa] = periodogram(xa,[],NFFT,fs);
figure, plot(FFxa, PPxxa);
hold on;
[~,IIa] = max(PPxxa);
ffreqa = abs(FFxa(IIa));
fprintf('Periodogram estimation the Pitch of signal "a" is: %3.2f Hz\n', ffreqa);
plot(FFxa(IIa), PPxxa(IIa), 'o');
title('Periodogram of Signal "a"');
xlabel('Frequency(Hz)');
ylabel('Power/Frequency');

[PPxxe,FFxe] = periodogram(xe,[],NFFT,fs);
figure, plot(FFxe, PPxxe);
hold on;
[~,IIe] = max(PPxxe);
ffreqe = abs(FFxe(IIe));
fprintf('Periodogram estimation the Pitch of signal "e" is: %3.2f Hz\n', ffreqe);
plot(FFxe(IIe), PPxxe(IIe), 'o');
title('Periodogram of Signal "e"');
xlabel('Frequency(Hz)');
ylabel('Power/Frequency');

[PPxxu,FFxu] = periodogram(xu,[],NFFT,fs);
figure, plot(FFxu, PPxxu);
hold on;
[~,IIu] = max(PPxxu);
ffrequ = abs(FFxu(IIu));
fprintf('Periodogram estimation the Pitch of signal "u" is: %3.2f Hz\n', ffrequ);
plot(FFxu(IIu), PPxxu(IIu), 'o');
title('Periodogram of Signal "u"');
xlabel('Frequency(Hz)');
ylabel('Power/Frequency');