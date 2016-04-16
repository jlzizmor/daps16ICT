%% Heading
% Author: Jacob Zizmor
% ui_mockup.m

%% Preparation
close all

toActiveTime = 1.377; % time it takes the motors to move from passive to active pressure
toPassiveTime = 1.262; % time it takes the motors to move from active to passive pressure
actuatordelay = ((-187) + (-220))/2; % delay after EMG detection to actuator movement
started = 0; % whether or not the stopwatch has been started

to_act = 0; % if the socket is going towards or is at the active position
at_pos = 1; % if the socket is at its goal position
det = 0; % if the EMG algorithm has confirmed movement

to_actT = -1; % temporary variable for Serial read
at_posT = -1;
detT = -1;

az = -37.5; % http://www.mathworks.com/help/matlab/visualize/setting-the-viewpoint-with-azimuth-and-elevation.html
el = 30;

%% Seupt Serial
COM_PORT = 'COM1';
s = serial(COM_PORT); % http://www.mathworks.com/help/matlab/matlab_external/getting-started-with-serial-i-o.html?s_tid=gn_loc_drop
set(s,'BaudRate',9600);
s.ReadAsyncMode = 'continuous';
try
    fopen(s);
catch
    errordlg(strcat('Serial port ',strcat(strcat(' ',COM_PORT),' could not be opened.')));
end

%% Setup Figure Window
resolution = 20;
figure % http://www.mathworks.com/help/matlab/examples/displaying-multiple-plots-in-a-single-figure.html
set(gcf,'name','DAPS','numbertitle','off')
status = ishandle(1); % check if figure is open

%% Main Loop
while (status)
    %% Serial Analysis
    [to_actT, at_posT, detT] = decrypt(s);
    if to_actT ~= -1
        to_act = to_actT;
        at_pos = at_posT;
        det = detT;
        
        if det == 1
            if started == 0
                started = 1;
                tic;
            end
        else
            if started == 1
                started = 0;
            end
        end
    end
    
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
    colorON=[0 1 0];
    colorOFF=[1 0 0];
    t=linspace(0,2*pi);
    
    if (det=='1') % movement detected
        fill(E+r*cos(t),N+r*sin(t),colorON); % this creates a filled circle centered at (E,N)
        disp('green');
    else % movement not detected
        fill(E+r*cos(t),N+r*sin(t),colorOFF); % this creates a filled circle centered at (E,N)
        disp('red');
    end
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
    PAS = [passive passive];
    ACT = [active active];
    YMAX = [active+ybuff active+ybuff];
    
    if at_pos==1
        if to_act==1
            level = ACT(1);
        else
            level = PAS(1);
        end
    end
    
    if det==1
        if to_act==1
            change = (toc/toActiveTime);
        else
            change = (toc/toPassiveTime);
        end
        level = 0.5+(change*(ACT(1)-PAS(1)));
    end
    
    Y = [level level];
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
if s.status(1) ~= 'c'
    fclose(s); % http://www.mathworks.com/help/matlab/matlab_external/getting-started-with-serial-i-o.html?s_tid=gn_loc_drop
    delete(s);
end