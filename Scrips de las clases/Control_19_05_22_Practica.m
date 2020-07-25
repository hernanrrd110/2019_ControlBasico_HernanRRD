%% Reguladores PID

close all; clear all; clc;

g = 0.5/(s*(s+7));
Td = 0.02
g_PD = 1 + Td*s;

%% Ejercicio 3
close all; clear all; clc;

s = tf('s');
g = 1/((s+1)*(5*s+1));
H=2;
Ti = 4.8;
g_PI = (1 + Ti*s)/(Ti*s) ;

rlocus(H*g*g_PI); grid on
Kp = 0.98;
step(minreal(feedback(Kp*g*g_PI,H)));

%%% Intentamos cancelar el polo con el cero
%%

Ti = 5;
g_PI = (1 + Ti*s)/(Ti*s) ;
rlocus(H*g*g_PI); grid on;
polo = -5 + 0.375i;
Kp = 1;
figure();
step(minreal(feedback(Kp*g*g_PI,H)));

%% Ejercicio 3c
clear all; close all; clc;

s = tf('s');
zero(5*s^2+5*s+2)

Mp = 0.075;
zita = -log(Mp)/sqrt(pi^2+log(Mp)^2)
ts = 5;
sigma = 4/ts
wn = sigma/zita
wd = wn*sqrt(1-zita^2)







