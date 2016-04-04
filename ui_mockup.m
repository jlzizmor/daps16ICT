figure % http://www.mathworks.com/help/matlab/examples/displaying-multiple-plots-in-a-single-figure.html

subplot(3,3,[2 3 5 6 8 9])
t = 0:pi/50:10*pi;
st = sin(t);
ct = cos(t);
plot3(st,ct,t) % http://www.mathworks.com/help/matlab/ref/plot3.html
title('Model')

subplot(3,3,1) 
theta = linspace(0,2*pi);
x = cos(theta);
y = sin(theta);
a = area(x, y);
a.FaceColor = 'g'; % http://www.mathworks.com/help/matlab/ref/area-properties.html
a.EdgeColor = 'g';
% a.Visible = 'off';
axis square % http://www.cs.cornell.edu/courses/cs100m/2007fa/Graphics/AxisStyle.pdf
title('EMG Detection')