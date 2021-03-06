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

function [ to_active, at_pos, detected ] = decrypt( ser )
if ser.BytesAvailable > 0
    alpha = fread(ser);
    alpha = alpha(length(alpha));
    alpha = num2str(dec2bin(alpha));
    if length(alpha) > 0
        detected = alpha(length(alpha));
        if length(alpha) > 1
            at_pos = alpha(length(alpha)-1);
            if length(alpha) > 2
                to_active = alpha(length(alpha)-2);
            end
        else
            to_active = 0;
        end
    else
        detected = 0;
        at_pos = 0;
        to_active = 0;
    end    
else
    to_active = -1;
    at_pos = -1;
    detected = -1;
end

end

