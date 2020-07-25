%% Guia practica de Analisis frecuencial y estabilidad relativa
% ejercicio 3
clear all; close all; clc;
s = tf('s');
wr = 1.9;
wn = 2;
zita = (1/2*(1-wr^2/wn^2))^(1/2)


g1 = 1/(s^2/wn^2+2*zita/wn*s+1);
g2 = 0.25/s;

g = g1*g2;


vector_w = logspace(-2,2,1000);
figure('Name', 'Bode de g')
bode(g,g1,g2,vector_w)
grid;
figure('Name', 'Bode con margenes de estabilidad')
margin(g)
grid;

%% Ejercicio 4
clear all; close all; clc;
s = tf('s');

K1 = 10;
K2 = 100;

g1 = K1/(s*(s+1)*(s+5))
g2 = K2/(s*(s+1)*(s+5))

figure('Name', 'Bode 1 con margenes de estabilidad')
margin(g1)
figure('Name', 'Bode 2 con margenes de estabilidad')
margin(g2)

%% Ejercicio 5
clear all; close all; clc;
s = tf('s');

g = 10*(s+0.1)/(s*(s+0.5)*(s+1))

figure('Name', 'Bode 1 con margenes de estabilidad')
margin(g)

K = 0.269
figure('Name', 'Bode 2 con Mf = 50')
margin(g*K)

%% Ejercicio 6
clear all; close all; clc;
s = tf('s');

g = 1/(s*(s^2+s+4));

figure('Name', 'Bode 1 con margenes de estabilidad')
vector_w = logspace(-1,1,2000);
[mag,phase,wout] = bode(g,vector_w);
margin(mag,phase,wout)

mag_w = abs(evalfr(g,1i*1.2))

K = 1/mag_w
figure('Name', 'Bode 2 con Mf = 50')
[mag,phase,wout] = bode(g*K,vector_w);
margin(mag,phase,wout)

figure('Name', 'Bode 2 con Mf = 50')
vector_k = linspace(0,10,100);
rlocus(g*K,vector_k)

%% Ejercicio 7
clear all; close all; clc;
s = tf('s');

g = (-1/2*s+1)/((s+1)*(1/2*s+1))

rlocus(g)








