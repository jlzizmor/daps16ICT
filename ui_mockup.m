close all

figure % http://www.mathworks.com/help/matlab/examples/displaying-multiple-plots-in-a-single-figure.html

subplot(3,3,[2 3 5 6 8 9])
t = 0:pi/50:10*pi;
st = sin(t);
ct = cos(t);
plot3(st,ct,t) % http://www.mathworks.com/help/matlab/ref/plot3.html
title('Model')

subplot(3,3,1) 
E = 0;
N = 0;
r=1;
color=[0 1 0];
t=linspace(0,2*pi);
fill(E+r*cos(t),N+r*sin(t),color); % this creates a filled circle centered at (E,N)
axis square
ax = gca; % http://www.mathworks.com/help/matlab/ref/gca.html
ax.Color = 'none'; % http://www.mathworks.com/help/matlab/ref/axes-properties.html
ax.XColor = 'none';
ax.YColor = 'none';