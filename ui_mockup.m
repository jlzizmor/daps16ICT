close all
num_rows = 20;

figure % http://www.mathworks.com/help/matlab/examples/displaying-multiple-plots-in-a-single-figure.html

subplot(num_rows, num_rows, [(num_rows-(0.6*num_rows)) (num_rows*num_rows)])
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

subplot(num_rows,num_rows,[(0.25*num_rows) (2+num_rows)] )
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

subplot(num_rows, num_rows, [ (1 + 4*num_rows) ((num_rows*num_rows)-(0.7*num_rows)) ])
x = 0:pi/100:2*pi;
y = sin(x);
plot(x,y)
title('Current Pressure')
ax = gca; % http://www.mathworks.com/help/matlab/ref/gca.html
ax.XColor = 'none';
ylim([0 2.5])