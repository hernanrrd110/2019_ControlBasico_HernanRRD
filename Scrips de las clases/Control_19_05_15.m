%% Practica respuesta en frecuencia
close all; clear all; clc;

s = tf('s');
K = 1;
g = K*10*(s+0.1)/(s*(s+0.5)*(s+1));

bode (g);
grid on;
figure();
nyquist(g);
grid on;

%% .................. Ejercicio 2 b

close all; clear all; clc;

s = tf('s');
K_db = 40;
K = 10^(K_db/20);
g = K/((1/100*s+1)*(s+1));


bode (g);
grid on;
figure();
nyquist(g);
grid on;

%% .................. Ejercicio 2 c

close all; clear all; clc;

s = tf('s');
K = 10;
g = K*(s+1)^2/(s*(100*s+1)^2*(0.1*s+1));


bode (g);
margin(g);
grid on;
