clc;
clearvars;
close all;

%% Cepstrum Analysis (fundamental frequency estimation)
%% Reading Audio file 
[xa, fs] = audioread('a.wav');
[xe, fs] = audioread('e.wav');
[xu, fs] = audioread('u.wav');
%% Working with a section of the signal for better result
dt = 1/fs;
I0 = round(0.1/dt);
Iend = round(0.2/dt);

xac = xa(I0:Iend);
subplot(311);
plot(xac);
title('Working with a section of sound signal "a"');
xlabel('Time');
ylabel('Amplitude');

xec = xe(I0:Iend);
subplot(312)
plot(xec);
title('Working with a section of sound signal "e"');
xlabel('Time');
ylabel('Amplitude');

xuc = xu(I0:Iend);
subplot(313)
plot(xuc);
title('Working with a section of sound signal "u"');
xlabel('Time');
ylabel('Amplitude');
%% Determining Real Cepstrum
ca = rceps(xac);
subplot(311)
plot(ca);
title('Cepstrum of sound signal "a"');
xlabel('Quefrency(s)')
ylabel('Amplitude');

ce = rceps(xec);
subplot(312)
plot(ce);
title('Cepstrum of sound signal "e"');
xlabel('Quefrency(s)')
ylabel('Amplitude');

cu = rceps(xuc);
subplot(313)
plot(cu);
title('Cepstrum of sound signal "u"');
xlabel('Quefrency(s)')
ylabel('Amplitude');
%% Fundamental frequency estimation 
% Let's the fundamental frequency is in between f1 = 500Hz and f2 = 50Hz
f1 = 500;
f2 = 50;
t = 0:dt:length(xac)*dt-dt;
trange = t(t>=1/f1 & t<=1/f2);
crange_a = ca(t>=1/f1 & t<=1/f2);
crange_e = ce(t>=1/f1 & t<=1/f2);
crange_u = cu(t>=1/f1 & t<=1/f2);

[~,Ia] = max(crange_a);
figure, plot(trange, crange_a);
hold on;
plot(trange(Ia), crange_a(Ia), 'o');
title('Real Cepstrum F0 Estimation of sound signal "a"');
xlabel('Time');
ylabel('Amplitude');

[~,Ie] = max(crange_e);
figure, plot(trange, crange_e);
hold on;
plot(trange(Ie), crange_e(Ie), 'o');
title('Real Cepstrum F0 Estimation of sound signal "e"');
xlabel('Time');
ylabel('Amplitude');

[~,Iu] = max(crange_u);
figure, plot(trange, crange_u);
hold on;
plot(trange(Iu), crange_u(Iu), 'o');
title('Real Cepstrum F0 Estimation of sound signal "u"');
xlabel('Time');
ylabel('Amplitude');

fprintf('Real cepstrum Fundamental Frequency estimation of sound signal "a" is %3.2f Hz.\n',1/trange(Ia));
fprintf('Real cepstrum Fundamentad Frequency estimation of sound signal "e" is %3.2f Hz.\n',1/trange(Ie));
fprintf('Real cepstrum Fundamentad Frequency estimation of sound signal "u" is %3.2f Hz.\n',1/trange(Iu));