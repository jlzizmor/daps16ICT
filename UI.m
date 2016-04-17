%% Heading
% Author: Jacob Zizmor and Meagan Hiatt
% ui_mockup.m

%% Preparation
close all

counter = 1; % counter for file read

to_act = 0; % if the socket is going towards or is at the active position
at_pos = 1; % if the socket is at its goal position
det = 0; % if the EMG algorithm has confirmed movement

%% File Setup
fileName='mbed.csv';

%% Setup Figure Window
resolution = 20;
figure % http://www.mathworks.com/help/matlab/examples/displaying-multiple-plots-in-a-single-figure.html
set(gcf,'name','DAPS','numbertitle','off')
status = ishandle(1); % check if figure is open

%% Main Loop
while (status)
    %% Serial Analysis
    [to_act, at_pos, det,counter] = decryptFile(fileName,counter);
    
    %% 3D Model
    subplot(resolution, resolution, [(resolution-(0.6*resolution)) (resolution*resolution)])
    t = 0:pi/50:10*pi;
    st = sin(t);
    ct = cos(t);
    plot3(st,ct,t) % http://www.mathworks.com/help/matlab/ref/plot3.html
    % 	view(az,el); % http://www.mathworks.com/matlabcentral/answers/21919-problem-with-view-to-save-the-orientation-of-a-plot-and-then-use-it-for-another
    title('Model')
    ax = gca; % http://www.mathworks.com/help/matlab/ref/gca.html
    ax.Box = 'on';
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    set(gca, 'ZTick', []);
    %     [az,el]=view; % http://www.mathworks.com/matlabcentral/answers/21919-problem-with-view-to-save-the-orientation-of-a-plot-and-then-use-it-for-another
    
    %% Boolean Feedback
    subplot(resolution,resolution,[(0.25*resolution) (2+resolution)] )
    E = 0;
    N = 0;
    r=1;
    colorON='g';
    colorOFF='r';
    t=linspace(0,2*pi);
    
    if (det=='1') % movement detected
        b = fill(E+r*cos(t),N+r*sin(t),colorON); % this creates a filled circle centered at (E,N)
    else % movement not detected
        b = fill(E+r*cos(t),N+r*sin(t),colorOFF); % this creates a filled circle centered at (E,N)
    end
    set(b,'EdgeColor','none');
    axis square
    title('Movement Detection');
    ax = gca; % http://www.mathworks.com/help/matlab/ref/gca.html
    ax.Color = 'none'; % http://www.mathworks.com/help/matlab/ref/axes-properties.html
    ax.XColor = 'none';
    ax.YColor = 'none';
    
    %% Pressure
    spacing = 5;
    subplot(resolution, resolution, [ (1 + 4*resolution) ((resolution*resolution)-(0.7*resolution)) ])
    hold on;
    
    ang=0:0.01:2*pi; % http://www.mathworks.com/matlabcentral/answers/3058-plotting-circles
    xp=r*cos(ang);
    yp=r*sin(ang);
    
    p_color = 'm';
    t_color = 'y';
    a_color = 'b';
    no_color = 'w';
    
    if at_pos=='0' % http://www.mathworks.com/help/matlab/ref/colorspec.html
        p = fill(0+xp,(-1*spacing)+yp, no_color);
        t = fill(0+xp,0+yp, t_color);
        a = fill(0+xp,spacing+yp, no_color);
        set(t,'EdgeColor','none');
    elseif to_act=='1'
        p = fill(0+xp,(-1*spacing)+yp, no_color);
        t = fill(0+xp,0+yp, no_color);
        a = fill(0+xp,spacing+yp, a_color);
        set(a,'EdgeColor','none');
    else
        p = fill(0+xp,(-1*spacing)+yp, p_color);
        t = fill(0+xp,0+yp, no_color);
        a = fill(0+xp,spacing+yp, no_color);
        set(p,'EdgeColor','none');
    end
    
    axis equal
    title('Current Pressure');
    ax = gca; % http://www.mathworks.com/help/matlab/ref/gca.html
    ax.Color = 'none'; % http://www.mathworks.com/help/matlab/ref/axes-properties.html
    ax.XColor = 'none';
    ax.YColor = 'none';
    hold off;
    
    %% Control Flow
    drawnow; % show plot instead of waiting for while loop to end
    status = ishandle(1); % check if figure is open
end

%% Cleanup
