clc;
clearvars;
close all;
%% Reading Audio file 
[xa, fs] = audioread('a.wav');
[xe, fs] = audioread('e.wav');
[xu, fs] = audioread('u.wav');
%% plotting signals in time domain
subplot(311);
plot(xa);
xlabel('Time');
ylabel('Amplitude');
title('Signal "a" in time domain')
subplot(312);
plot(xe);
xlabel('Time');
ylabel('Amplitude');
title('Signal "e" in time domain')
subplot(313);
plot(xu);
xlabel('Time');
ylabel('Amplitude');
title('Signal "u" in time domain')
%% fast fourier transform
NFFT=8192;
xaF = fftshift(abs(fft(xa,NFFT)));
f=(-1/2:1/NFFT:1/2-1/NFFT)*fs;
figure, plot(f,xaF(1:end))
hold on;
[pka,lka]=findpeaks(xaF, 'MinPeakHeight', 200);
plot(f(lka), xaF(lka), 'o');
title('Signal "a" in frequency domain')
xlabel('Frequency (Hz)');
ylabel('Amplitude');
ffa=min(abs(f(lka)));
fprintf('fundamental frequency of sound signal "a" is: %3.2f Hz\n', ffa);

xeF = fftshift(abs(fft(xe,NFFT)));
f=(-1/2:1/NFFT:1/2-1/NFFT)*fs;
figure, plot(f,xeF(1:end))
hold on;
[pke,lke]=findpeaks(xeF, 'MinPeakHeight', 100);
plot(f(lke), xeF(lke), 'o');
title('Signal "e" in frequency domain')
xlabel('Frequency (Hz)');
ylabel('Amplitude');
ffe=min(abs(f(lke)));
fprintf('fundamental frequency of sound signal "e" is: %3.2f Hz\n', ffe);

xuF = fftshift(abs(fft(xu,NFFT)));
f=(-1/2:1/NFFT:1/2-1/NFFT)*fs;
figure, plot(f,xuF(1:end))
hold on;
[pku,lku]=findpeaks(xuF, 'MinPeakHeight', 300);
plot(f(lku), xuF(lku), 'o');
title('Signal "u" in frequency domain')
xlabel('Frequency (Hz)');
ylabel('Amplitude');
ffu=min(abs(f(lku)));
fprintf('fundamental frequency of sound signal "u" is: %3.2f Hz\n', ffu);