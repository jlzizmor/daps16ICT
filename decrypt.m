%% Heading
% decrypt.m
% Author: Jacob Zizmor

%% Helpful Links
% http://radio.feld.cvut.cz/matlab/toolbox/instrument/ch_ser12.html
% http://www.mathworks.com/help/matlab/matlab_external/readasyncmode.html
% http://www.mathworks.com/help/matlab/ref/readasync.html
% http://www.mathworks.com/help/instrument/writing-and-reading-data-1.html#f14-18481

%% Function
% This function is used to analyze the input stream from an asynchronous
% serial object.
% INPUT = asynchronous Serial object
% OUTPUT = [boolean boolean boolean]
% to_active is true when the LA are moving towards active pressure
% at_pos is true when the LA have reached their goal position
% detected is true when the EMG algorithm has confirmed movement

function [ to_active, at_pos, detected ] = decrypt( ~ )

to_active = 1;
at_pos = 2;
detected = 3;

end

