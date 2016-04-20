%% Heading
% Author: Jacob Zizmor and Meagan Hiatt
% ui_mockup.m

%% Preparation
close all

counter = 0; % counter for file read

to_act = 0; % if the socket is going towards or is at the active position
at_pos = 1; % if the socket is at its goal position
det = 0; % if the EMG algorithm has confirmed movement

%% File Setup
fileName='mbed-meg-rec-3.csv';
data = csvread(fileName);

%% Setup Figure Window
resolution = 20;
figure % http://www.mathworks.com/help/matlab/examples/displaying-multiple-plots-in-a-single-figure.html
set(gcf,'name','DAPS','numbertitle','off')
status = ishandle(1); % check if figure is open
pause(1);


%% Setup for Model


thing = [.2, 1, 0.0; .1, 1, 0.25; 0, 1, 0.4; 0, 1, 0.6; 0, 1, 0.8; 0, 1, 1.0]; %mekes the color mpa
[X,Y,Z] = cylinder(5, 20); %creates the cylinder shape
grid on;
colormap (thing);
hold on;

cyn1 = surfc(X,Y,2*Z)
cyn2 = surfc(X,Y,2*Z+2)
cyn3 = surfc(X,Y,2*Z+4)
cyn4 = surfc(X,Y,2*Z+6)
cyn5 = surfc(X,Y,2*Z+8)

% dome
[x,y,z] = sphere;      % Makes a 21-by-21 point sphere
x = x(11:end,:);       % Keep top 11 x points
y = y(11:end,:);       
z = z(11:end,:);       
r = 5;                 
cyn6 = surf(r.*x,r.*y,r.*-z);  
%sets up view
axis([-20 20 -25 25 -10 20])
az = -153;
el = 28;
view(az,el);

%now is the start of loop updating (the model has been initizalized)
xlabel('X');
ylabel('Z');

origin = [0 0 10];
pause(1);

a1 = 0.0;
a2 = 0.0;
a3 = 0.0;
p1 = 0.0;
pang2 = 0.0;
pang3 = 0.0;
xdir = [1 0 0];
ydir = [0 1 0];
zdir = [0 0 1];
i = 500;


%% Main Loop
while (status)
    %% Serial Analysis
    [to_act, at_pos, det, counter] = decryptFile(data,counter);
    
    if mod(counter,100)==0
        counter
    end
    
    %% 3D Model
    if(inc < 3500)
        
        [a1, a2, a3] = findAngles(i, 10, X1, X2, Y1, Y2, Z1, Z2);
        [p1, p2, p3] = findAngles(i-2, 2, X1, X2, Y1, Y2, Z1, Z2);
        [f1, f2, f3] = findAngles(i+5, 5, X1, X2, Y1, Y2, Z1, Z2);
        xdir = [1 0 0];
        ydir = [0 1 0];
        zdir = [0 0 1];

        rotate(cyn1, xdir, a1, origin);
        rotate(cyn2, xdir, a1, origin);
        rotate(cyn3, xdir, a1, origin);
        rotate(cyn4, xdir, a1, origin);
        rotate(cyn5, xdir, a1, origin);
        rotate(cyn6, xdir, a1, origin);

        rotate(cyn1, ydir, a2, origin);
        rotate(cyn2, ydir, a2, origin);
        rotate(cyn3, ydir, a2, origin);
        rotate(cyn4, ydir, a2, origin);
        rotate(cyn5, ydir, a2, origin);
        rotate(cyn6, ydir, a2, origin);

        rotate(cyn1, zdir, a3, origin);
        rotate(cyn2, zdir, a3, origin);
        rotate(cyn3, zdir, a3, origin);
        rotate(cyn4, zdir, a3, origin);
        rotate(cyn5, zdir, a3, origin);
        rotate(cyn6, zdir, a3, origin);
        %plot3(X1(i)*39, Y1(i)*39, Z1(i)*39, X2(i)*39, Y2(i)*39, Z2(i)*39);
        %pauseTime = time(i+1)- time(i);
        drawnow;
        %pause(pauseTime);

    end
    inc = inc + 1;
        
        
        
        
    %% Boolean Feedback
    subplot(resolution,resolution,[(0.25*resolution) (2+resolution)] )
    E = 0;
    N = 0;
    r=1;
    colorON='g';
    colorOFF='r';
    t=linspace(0,2*pi);
    
    if (det==1) % movement detected
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
    
    if at_pos==0 % http://www.mathworks.com/help/matlab/ref/colorspec.html
        p = fill(0+xp,(-1*spacing)+yp, no_color);
        t = fill(0+xp,0+yp, t_color);
        a = fill(0+xp,spacing+yp, no_color);
        set(t,'EdgeColor','none');
    elseif to_act==1
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
