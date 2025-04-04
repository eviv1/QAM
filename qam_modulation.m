function [x_AM] = qam_modulation(x1_new, x2_new, set_fc, t)
% qam_modulation - Two signals will go through the in-phase branch and quadrature branch. Output of this block must be a single QAM signal that will pass through the channel. 
%
% Inputs:
% x1_new - Resampled first audio signal (from Task 2: Resample)
% x2_new - Resampled second audio signal (from Task 2: Resample)
% set_fc - Carrier frequency for modulation
% t - Time vector for the signals
%
% Outputs:
% x_AM - Modulated QAM signal of I and Q channels by Linear Summer

% The in-phase modulated signal
InPhase_Carrier = cos(2*pi*set_fc*t);
x1_InPhase = x1_new .* InPhase_Carrier;

% The in-quadrature modulated signal
InQuadrature_Carrier = -sin(2*pi*set_fc*t);
x2_InQuadrature = x2_new .* InQuadrature_Carrier;

% QAM signal from the sum of the signals in quadrature
x_AM = x1_InPhase + x2_InQuadrature;

end