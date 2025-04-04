function [x1_pad, x2_pad, Fs_orig1, Fs_orig2, Fs_orig, L] = load_input(input1, input2)
% load_input - Loads two audios and pads zeros so the two input audios are
% of equal length. 
% 
% Inputs:
% input 1 - First audio file
% input 2 - Second audio file
% 
% Outputs:
% x1_pad - First audio with padded zeroes
% x2_pad - Second audio with padded zeroes
% Fs_1 - Sampling frequency of the first audio
% Fs_2 - Sampling frequency of the second audio
% Fs - Nyquist Frequency
% Fs_orig - Maximum Frequency
%
% GROUP 7 - TASK 1 of Machine Problem

% Loading the input Files
    [x1, Fs_orig1] = audioread(input1);
    [x2, Fs_orig2] = audioread(input2);
    
    % Transpose the signals (if needed)
    x1 = x1';
    x2 = x2';
    
    % Resample both signals to the highest sampling rate
    if Fs_orig1 ~= Fs_orig2
        % Resample the signals to the highest original sampling rate
        if Fs_orig1 > Fs_orig2
            x2 = resample(x2, Fs_orig1, Fs_orig2);
            Fs_orig2 = Fs_orig1;
        elseif Fs_orig2 > Fs_orig1
            x1 = resample(x1, Fs_orig2, Fs_orig1);
            Fs_orig1 = Fs_orig2;
        end
    end
    
    % Selecting the longer signal and applying zero padding to match lengths
    length_x1 = length(x1);
    length_x2 = length(x2);
    zero_pad = zeros(1, abs(length_x1 - length_x2));
    
    if length_x1 > length_x2
        L = length(x1);
        x2_pad = [x2(1,:), zero_pad];
        x1_pad = x1(1,:);
    elseif length_x2 > length_x1
        L = length(x2);
        x1_pad = [x1(1,:), zero_pad];
        x2_pad = x2(1,:);
    else
        L = length_x2;
        x1_pad = x1(1,:);
        x2_pad = x2(1,:);
    end
    
    % Selecting the final common sampling rate
    Fs_orig = Fs_orig1;  % Now both signals should have the same sampling rate

    %sound(y_1,Fs_1);
    % pause(5);
    %sound(y_2, Fs_2);
end
