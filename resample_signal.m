function [x1_new, x2_new] = resample_signal(x1_pad, x2_pad, Fs, Fs_orig)
% resample_signal - Resamples the signal with two input signals with a new
% sampling frequency Fs.
%
% Inputs:
% x1_pad - First audio with padded zeroes
% x2_pad - Second audio with padded zeroes
% Fs - Desired sampling frequency
% Fs_orig - Original Sampling Frequency
%
% 
% Outputs:
% x1_new - Resampled first audio with the new sampling freq
% x2_new - Resampled second audio with the new sampling freq
% 
% GROUP 7 - Task 2 of Machine Problem

x1_new = resample(x1_pad, Fs, Fs_orig);
x2_new = resample(x2_pad, Fs, Fs_orig);

end