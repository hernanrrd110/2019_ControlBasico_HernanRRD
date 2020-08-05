%% Final 2020 Junio 2do llamado
%% Ejercicio 1
clear all; close all; clc;

Mp = 6;
ts = 3;
zita=(-log(Mp/100))/(sqrt(pi^2+(log(Mp/100))^2));
wn = 4/(zita*ts);
wd = wn*sqrt(1-zita^2);
pd1 = -zita*wn + wd*1i
pd2 = -zita*wn - wd*1i;

s = tf('s'); 

g = 0.056*(0.194*s+1)/((0.33*s+1)^2*(0.1*s+1));
polos_g = pole(g)
ceros_g = zero(g)

