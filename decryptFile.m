%% Heading
% decrypt.m
% Author: Jacob Zizmor

%% Helpful Links
% http://radio.feld.cvut.cz/matlab/toolbox/instrument/ch_ser12.html
% http://www.mathworks.com/help/matlab/matlab_external/readasyncmode.html
% http://www.mathworks.com/help/matlab/ref/readasync.html
% http://www.mathworks.com/help/instrument/writing-and-reading-data-1.html#f14-18481
% http://www.mathworks.com/help/matlab/ref/serial.fread.html
% http://www.mathworks.com/help/matlab/ref/fread.html#outputarg_A
% http://www.mathworks.com/help/matlab/ref/serial.fscanf.html

%% Function
% This function is used to analyze the input stream from an asynchronous
% serial object.
% Single byte (8 bits) are read from the Serial object
% byte is analyzed as such:
%     [7]-[3] = ignored
%     [2] = to_active
%     [1] = at_pos
%     [0] = detected
% Function only runs when new data is read in Serial buffer
% INPUT = asynchronous Serial object
% OUTPUT = [int int int]
% to_active is 1 when the LA are moving towards active pressure, 0
% if not
% at_pos is 1 when the LA have reached their goal position, 0
% if not
% detected is 1 when the EMG algorithm has confirmed movement, 0
% if not
% all variables returned will be -1 if no information is in Serial buffer

function [ to_active, at_pos, detected, counter ] = decryptFile( data, counter )
alpha = data;
if (counter > length(alpha)) || (counter < 1)
    counter = 1;
end

alpha = alpha(counter);
counter = counter + 1;
alpha = num2str(alpha);

if length(alpha) == 1
    to_active = 0;
    at_pos = 0;
    detected = str2num(alpha);
elseif length(alpha) == 2
    to_active = 0;
    at_pos = str2num(alpha(1));
    detected = str2num(alpha(2));
else
    to_active = str2num(alpha(1));
    at_pos = str2num(alpha(2));
    detected = str2num(alpha(3));
end
end
