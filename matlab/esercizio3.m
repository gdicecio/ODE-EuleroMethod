clear all, clc, close all;

%% Filtro Passa Banda
R = 8;
L = 0.5;
C = 6*10^(-6);
w = 50;
z0 = [0,20];

f = @(t,z) [z(2); (1/(L*C)+R/L)*z(1) + w*sin(w*t)];

[z,t] = eulero64(f,z0,0,10,10^-5);

plot(t,z(2,:));