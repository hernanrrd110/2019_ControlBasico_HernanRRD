


%%
% Debemos sacar los valores de zita, wn.
% Para sacar zita se saca el máximo sobreimpulso:
clear all; close all; clc;
Mp = 0.0391/0.332

zita = 1/sqrt((pi/log(Mp))^2+1) 

% para sacar wn, se obtiene a apartir de ts

ts = 0.05;
wn = 4/(zita*ts)

C = 100e-9;
R = 1/(wn*C)

% En este caos, zita ya queda determiando por R y C
s = tf('s')
g = -s/(R*C)/(s^2+2/(R*C)*s+(1/R^2*C^2))


step(g)

