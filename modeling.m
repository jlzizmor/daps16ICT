%% Heading
% modeling.m
% Author: Meagan Hiatt

%% 


function [ ] = modeling()
        
    thing = [.2, 1, 0.0; .1, 1, 0.25; 0, 1, 0.4; 0, 1, 0.6; 0, 1, 0.8; 0, 1, 1.0];
    [X,Y,Z] = cylinder(5, 20);
    grid on;
    colormap (thing)
    Qz = Q*r;
    Qz(Qz > 0) = 0;
    hold on;
    surfc(X,Y,2*Z)
    surfc(X,Y,2*Z+2)
    surfc(X,Y,2*Z+4)
    surfc(X,Y,2*Z+6)
    surfc(X,Y,2*Z+8)
    
    
    % dome
    [x,y,z] = sphere;      % Makes a 21-by-21 point sphere
    x = x(11:end,:);       % Keep top 11 x points
    y = y(11:end,:);       
    z = z(11:end,:);       
    r = 5;                 
    surf(r.*x,r.*y,r.*-z);  
    
    axis([-10 10 -15 15 -5 15])
    az = -95;
    el = 20;
    view(az,el)
    %view(3)
    %a = [1, 1 , 5.5];
    %b = [1.5, 1.5, 5];
    %c = [2.5, 1.5, 5];
    %d = [3, 1, 5.5];
    %e = [1, 1, 1];
    %f = [1.5, 1.5, 1];
    %g = [2.5, 1.5, 1];
    %h = [3, 1, 1];
    %i = [1.5, 1, -.5];
    %j = [2.5, 1, -.5];
    
    %A = [a', b', f', e'];
    %B = [b', f', g', c'];
    %C = [c', d', h', g'];
    %D = [e', f', i'];
    %E = [f', g', j', i'];
    %F = [j', g', h'];
    %hold on;
    %fill3(A(1,:), A(2,:), A(3, :), 'b');
    %fill3(B(1,:), B(2,:), B(3, :), 'c');
    %fill3(C(1,:), C(2,:), C(3, :), 'g');
    %fill3(D(1,:), D(2,:), D(3, :), 'r');
    %fill3(E(1,:), E(2,:), E(3, :), 'y');
    %fill3(F(1,:), F(2,:), F(3, :), 'm');
   
    %grid on;
    %drawnow;
    %alpha(0.3);
    
end
