%% Heading
% modeling.m
% Author: Meagan Hiatt

%% 


function [ ] = modeling()
    a = [1, 1 , 5.5];
    b = [1.5, 1.5, 5];
    c = [2.5, 1.5, 5];
    d = [3, 1, 5.5];
    e = [1, 1, 1];
    f = [1.5, 1.5, 1];
    g = [2.5, 1.5, 1];
    h = [3, 1, 1];
    i = [1.5, 1, -.5];
    j = [2.5, 1, -.5];
    
    A = [a', b', f', e'];
    B = [b', f', g', c'];
    C = [c', d', h', g'];
    D = [e', f', i'];
    E = [f', g', j', i'];
    F = [j', g', h'];
    hold on;
    fill3(A(1,:), A(2,:), A(3, :), 'b');
    fill3(B(1,:), B(2,:), B(3, :), 'c');
    fill3(C(1,:), C(2,:), C(3, :), 'g');
    fill3(D(1,:), D(2,:), D(3, :), 'r');
    fill3(E(1,:), E(2,:), E(3, :), 'y');
    fill3(F(1,:), F(2,:), F(3, :), 'm');
   
    grid on;
    drawnow;
    alpha(0.3);
    
end