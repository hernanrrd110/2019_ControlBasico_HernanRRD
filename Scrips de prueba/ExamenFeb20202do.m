close all; clc; clear all;

s = tf('s');
ts = 20;
sigma = 4/(ts);
g = 10/((10*s+1)^2*(0.1*s+1)^2)
g_mod = 10*s/((10*s+1)^2*(0.1*s+1)^2+10)
figure()
rlocus(g_mod)

T = 2.05;
figure()
h = (1+T*s);

gbc = feedback(g,h)
damp(gbc)
step(gbc)