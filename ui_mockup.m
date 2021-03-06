%% Heading
% Author: Jacob Zizmor
% ui_mockup.m

%% Preparation
close all
to_act = -1; % if the socket is going towards or is at the active position
at_pos = -1; % if the socket is at its goal position
det = -1; % if the EMG algorithm has confirmed movement

%% Seupt Serial
COM_PORT = 'COM1';
% s = serial(COM_PORT); % http://www.mathworks.com/help/matlab/matlab_external/getting-started-with-serial-i-o.html?s_tid=gn_loc_drop
% set(s,'BaudRate',9600);
% s.ReadAsyncMode = 'continuous';
% fopen(s);

%% Setup Figure Window
resolution = 20;
figure % http://www.mathworks.com/help/matlab/examples/displaying-multiple-plots-in-a-single-figure.html
set(gcf,'name','DAPS','numbertitle','off')
status = ishandle(1); % check if figure is open

%% Main Loop
while (status)
    %% Serial Analysis
%     [to_act, at_pos, det] = decrypt(s);
    
    %% 3D Model
    subplot(resolution, resolution, [(resolution-(0.6*resolution)) (resolution*resolution)])
    t = 0:pi/50:10*pi;
    st = sin(t);
    ct = cos(t);
    plot3(st,ct,t) % http://www.mathworks.com/help/matlab/ref/plot3.html
    title('Model')
    ax = gca; % http://www.mathworks.com/help/matlab/ref/gca.html
    ax.Box = 'on';
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    set(gca, 'ZTick', []);
    
    %% Boolean Feedback
    subplot(resolution,resolution,[(0.25*resolution) (2+resolution)] )
    E = 0;
    N = 0;
    r=1;
    colorON=[0 1 0];
    colorOFF=[1 0 0];
    t=linspace(0,2*pi);
    fill(E+r*cos(t),N+r*sin(t),colorON); % this creates a filled circle centered at (E,N)
    axis square
    ax = gca; % http://www.mathworks.com/help/matlab/ref/gca.html
    ax.Color = 'none'; % http://www.mathworks.com/help/matlab/ref/axes-properties.html
    ax.XColor = 'none';
    ax.YColor = 'none';
    
    %% Pressure
    subplot(resolution, resolution, [ (1 + 4*resolution) ((resolution*resolution)-(0.7*resolution)) ])
    level = 1;
    passive = 0.25;
    active = 2.5;
    ybuff = passive-0;
    YMIN = [0 0];
    PAS = [passive passive];
    Y = [level level];
    ACT = [active active];
    YMAX = [active+ybuff active+ybuff];
    
    hold on;
    area(YMAX, 'FaceColor', [135/255 206/255 250/255]);
    area(ACT, 'FaceColor', 'w');
    area(Y, 'FaceColor', 'b');
    area(PAS, 'FaceColor', [135/255 206/255 250/255]);
    hold off;
    
    title('Current Pressure')
    ax = gca; % http://www.mathworks.com/help/matlab/ref/gca.html
    ax.XColor = 'none';
    ylim([passive-ybuff active+ybuff])
    
    %% Control Flow
    drawnow; % show plot instead of waiting for while loop to end
    status = ishandle(1); % check if figure is open
end

%% Cleanup
% fclose(s); % http://www.mathworks.com/help/matlab/matlab_external/getting-started-with-serial-i-o.html?s_tid=gn_loc_drop
% delete(s);