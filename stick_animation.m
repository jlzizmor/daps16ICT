%% Heading
% stick_animation.m
% Author: Jacob Zizmor

%% 
function [ ] = stick_animation()
hip = [0; 0; 0];
t = pi:.01:2*pi;
angle = sin(t);
x = 5*cos(angle);
y = 5*sin(angle);
z = sqrt(x.^2 + y.^2);

knee = [x; y; z];

for i = 0:size(angle)
    hold on;
    %plot3(hip(1,:),hip(2,:), hip(3,:) );
    plot3(knee(1,:),knee(2,:), knee(3,:) );
    drawnow;
    pause(.1)
    hold off;
end


end