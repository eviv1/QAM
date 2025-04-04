function [y_1, y_2, y_filt_1, y_filt_2] = qam_demodulation(rx, fc, fcut, Fs, t)
% qam_demodulation - QAM Demodulation Function
%
% Inputs:
% rx     - Received QAM signal to be demodulated
% set_fc - Carrier frequency used for modulation and demodulation
% fcut   - Cutoff frequency for the low-pass filter
% Fs     - Sampling frequency
% t      - Time vector for the signal
%
% Outputs:
% y_1    - Demodulated in-phase (I) signal before filtering
% y_2    - Demodulated quadrature (Q) signal before filtering
% y_filt_1 - Filtered in-phase (I) signal
% y_filt_2 - Filtered quadrature (Q) signal
%
% GROUP 7 - Task 4 Machine Problem

% Low-Pass Filter
order = 6;
[b, a] = butter(order, fcut/(Fs/2), 'low');

% Retrieving the in-phase message signal
carrier_sin = cos(2 * pi * fc * t);
y_1 = rx .* carrier_sin;
y_filt_1 = filtfilt(b, a, y_1);

% Retrieving the in-quadrature message signal
carrier_cos = sin(2 * pi * fc * t);
y_2 = rx .* carrier_cos;
y_filt_2 = filtfilt(b, a, y_2);
end