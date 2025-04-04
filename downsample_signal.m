function [y_down1, y_down2] = downsample_signal(y_filt_1, y_filt_2, Fs, Fs_orig1, Fs_orig2)
% downsample_signal - Resamples the demodulated signal to their original
% sampling frequency. It also plays the sound of the resampled signals.
% 
% Inputs:
% y_filt_1 - Filtered first audio
% y_filt_2 - Filtered second audio
% Fs - Sampling frequency
% Fs_orig1 - Original sampling frequency of the first audio
% Fs_orig2 - Original sampling frequency of the second audio
% 
% Outputs:
% y_down1 - Resampling the first audio to the original sampling freq
% y_down2 - Resampling the second audio to the original sampling freq
% 
% GROUP 7 - Task 5 of Machine Problem

y_down1 = resample(y_filt_1, Fs_orig1, Fs);
y_down2 = resample(y_filt_2, Fs_orig2, Fs);
end