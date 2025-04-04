%% Task 1: Input Signal
% Load input signals
input1 = '3ECEA_Group No.7_Salanio, Sean_INPUT.m4a';
input2 = '3ECEA_Group No.7_Gomez, Xyruz_INPUT.m4a';

% Input Loading and Reading Function
[x1_pad,x2_pad,Fs_orig1, Fs_orig2, Fs_orig,L] = load_input(input1,input2);

% Maximum values
x1_pad_max = max(abs(x1_pad));
x2_pad_max = max(abs(x2_pad));

% Period and time
T = 1/Fs_orig; % period
t = 0:T:T*(L-1); % time index

% Frequency
delta_f = Fs_orig/(L-1);
f_delta = -Fs_orig/2:delta_f:Fs_orig/2;
f_s = 0:delta_f:Fs_orig/2;

% Figures
% Time Domain
figure(1);
subplot(2,1,1);
plot(t,x1_pad);
title('Audio Input#1 in the Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(t, x2_pad);
title('Audio Input#2 in the Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

% Frequency Domain
X1_freq = fftshift(fft(x1_pad))/length(x1_pad);
X2_freq = fftshift(fft(x2_pad))/length(x2_pad);
figure(2);
subplot(2,1,1);
plot(f_delta/(1e3),abs(X1_freq));
title('Audio Input#1 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Magnitude')


subplot(2,1,2);
plot(f_delta/(1e3),abs(X2_freq));
title('Audio Input#2 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Magnitude')


%% Task 2: Resampling the Input Signals
% Set new Fmax
Fmax = 500e3;
Fs = 2 * Fmax; % Define new sampling frequency

% Up-Sampling the Signals
[x1_new, x2_new] = resample_signal(x1_pad, x2_pad, Fs, Fs_orig);

% Redefine period and time
L = length(x1_new);
T = 1/Fs;
t = 0:T:T*(L-1);

% Redefine frequency
fmax = Fs/2;
delta_f = Fs/(L-1);
f_delta = -Fs/2:delta_f:Fs/2;

% Figures
% Time Domain
figure(3);
subplot(2,1,1);
plot(t,x1_new);
title('Resampled Audio Input#1 in the Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(t, x2_new);
title('Resampled Audio Input#2 in the Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

% Frequency Domain
X1_resampled = fftshift(fft(x1_new))/length(x1_new);
X2_resampled = fftshift(fft(x2_new))/length(x2_new);

figure(4);
subplot(2,1,1);
plot(f_delta/(1e3),abs(X1_resampled));
title('Resampled Audio Input#1 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

subplot(2,1,2);
plot(f_delta/(1e3),abs(X2_resampled));
title('Resampled Audio Input#2 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

%% Task 3: Modulation
set_fc = 200e3; % Set carrier frequency

% Quadrature Amplitude Modulation
[x_AM] = qam_modulation(x1_new, x2_new, set_fc, t);

% Figures
% Time Domain
figure(5);
plot(t, x_AM,'LineWidth',0.5);
title('Quadrature-Carrier Multiplexed Signal in the Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

% Freq
figure(6);
X_AM_d = fftshift(fft(x_AM))/length(x_AM);
plot(f_delta/(1e3),2.25*20*log10(X_AM_d));
title('Quadrature-Carrier Multiplexed Signal in the Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

%% Task 4: Demodulate
f_cutoff = 20e3; % LPF cut-off frequency

% Quadrature Amplitude Demodulation
[y_1, y_2, y_filt_1, y_filt_2] = qam_demodulation(x_AM, set_fc, f_cutoff, Fs, t);

% Filtered Version:
% Double-sided frequency spectrum
Y_filt_d1 = fftshift(fft(y_filt_1))/length(y_filt_1);
Y_filt_d2 = fftshift(fft(y_filt_2))/length(y_filt_2);

% Single-sided frequency spectrum
Y_filt_s1 = 2 * Y_filt_d1((L-1)/2 + 1:end);
Y_filt_s2 = 2 * Y_filt_d2((L-1)/2 + 1:end);

% Figures
% In-Phase
figure(7);
subplot(2,1,1);
plot(t, y_filt_1);
title('Demodulated Signal (In-Phase) in Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(t, y_filt_2);
title('Demodulated Signal (Quadrature) in Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

% Freq
figure(8);
subplot(2,1,1);
plot(f_delta/(1e3), abs(Y_filt_d1), 'LineWidth', 1.5);
title('Demodulated Signal (In-Phase) in Frequency Domain');
xlabel('Frequency (kHz)');
ylabel('Magnitude');

subplot(2,1,2);
plot(f_delta/(1e3), abs(Y_filt_d2), 'LineWidth', 1.5);
title('Demodulated Signal (Quadrature) in Frequency Domain');
xlabel('Frequency (kHz)');
ylabel('Magnitude');

%% Task 5: Downsample
% Down-Sampling the Signals
[y_down1, y_down2] = downsample_signal(y_filt_1, y_filt_2, Fs, Fs_orig1, Fs_orig2);

% Period and time
L = length(y_down1);
T = 1/Fs_orig; % period
t = 0:T:T*(L-1); % time indices

% Figures
% Time Domain
figure(9);
subplot(2,1,1);
plot(t,y_down1);
title('Audio Output#1 in the Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(t, y_down2);
title('Audio Output#2 in the Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

% Play the downsampled sounds
sound(y_down1, Fs_orig1)
pause(7)
sound(y_down2, Fs_orig2)
