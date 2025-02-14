load('HW8_timber')
time = timber.t;
offset = time(1);
for k = 1:length(time)
 time(k) = time(k)- offset;
end
fs = 100; %hz
ang = timber.aileron;
u = lowpass(ang,.001);
rollrate = lowpass(timber.rollrate,.001);
figure(1)
plot(time, u)
title('Measured aileron angle')
xlabel('Time [sec]')
ylabel('angle [rad]')
figure(2)
plot(time, rollrate)
title('measured rollrate')
xlabel('Time [sec]')
ylabel('angle [rad/s]')
input = u;
output = rollrate;
Tfinal = time(end); %seconds
% Doesn't work currently.
Y = fft(output); % FFT of OUTPUT data
X = fft(input); % FFT of INPUT data
Y = Y(1:round(end/2)); % Only 1st half is unique per Nyquist sampling
X = X(1:round(end/2));
f = fs*(1:length(time))/length(time); % Frequency vector, Hz
f = f(1:round(end/2)); % Grabs only the first half, as this is all that is valid
Gyy = 1/(fs*length(input))*abs(Y).^2; % output PSD estimate
Gyy(2:end-1) = Gyy(2:end-1)*2;
Gxx = 1/(fs*length(input))*abs(X).^2; % input PSD estimate
Gxx(2:end-1) = Gxx(2:end-1)*2;
Gxy = 1/(fs*length(input))*conj(X).*Y; % Cross PSD
Gxy(2:end-1) = Gxy(2:end-1)*2;
%
% coherence = abs(Gxy).^2./((Gxx).*(Gyy)); % Coherence estimate
[matlab_coherence, ff] = mscohere(input,output,[],[],[],fs);
gxx = pwelch(input);
gyy = pwelch(output);
gxy = cpsd(input, output);
H2 = gxy./gxx;
H2db = 20*log10(H2);
phase2 = angle(H2)*180/3.14;
H = Gxy./Gxx; % Transfer Function estimate
HdB = 20*log10(H); % Converting to dB format
phase = angle(H)*180/3.14; % Phase lag in Degrees
figure(3)
ax1 = subplot(3,1,1);
semilogx(ff, real(H2db))
xlabel('Freq [Hz]')
ylabel('Magnitude [dB]')
ax2 = subplot(3,1,2);
semilogx(ff, phase2)
xlabel('Freq [Hz]')
ylabel('Phase [Deg]')
ax3 = subplot(3,1,3);
semilogx(ff,matlab_coherence)
xlabel('Freq [Hz]')
ylabel('Coherence')
linkaxes([ax1, ax2, ax3], 'x')
%% Combined Bode Plotter %%
ffRAD = ff*2*3.14; % Convert to rad/s

K = 10; % Use System Identification Toolbox to get the transfer function
tau = 0.1; % This is just a filler so the script will run
tf5 = tf(K, [tau 1]); 

[mag, ph, w] = bode(tf5, ffRAD);
mag = squeeze(mag(1,1,:));
ph = squeeze(ph(1,1,:));
magDB = 20*log10(mag);
%wHZ = w*180/3.14;
figure(4)
ax1 = subplot(3,1,1);
semilogx(ff, real(H2db), ff, magDB)
xlabel('Freq [Hz]')
ylabel('Magnitude [dB]')
ax2 = subplot(3,1,2);
semilogx(ff, -phase2, ff, ph)%-360)
xlabel('Freq [Hz]')
ylabel('Phase [Deg]')
ax3 = subplot(3,1,3);
semilogx(ff,matlab_coherence)
xlabel('Freq [Hz]')
ylabel('Coherence')
linkaxes([ax1, ax2, ax3], 'x')