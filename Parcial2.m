clear all; close all; clc;

s = tf('s');
g = 50/(s+1);

K_sensor = 24/(20*pi);
Ti = 0.0177;
Kpi = 1;
g_pi = Kpi*(1+1/(Ti*s));

p = -40+53.6i;
plot(p,'*'); hold on;

rlocus(g*g_pi*K_sensor)

Kpi = 4.14;
g_pi = Kpi*g_pi;

figure;
g_bc = feedback(g*g_pi,K_sensor);
step(g_bc);
pole(g_bc)

rlocus(g*g_pi*K_sensor)
zero(g_bc)

%% Ejercicio 2

clear all; close all; clc;

s = tf('s');
g = 2/((s+1)*(s+2));

K_sensor = 24/(3/2*pi);
Ti = 1;
g_pi = (1+1/(Ti*s));

rlocus(g*g_pi*K_sensor)
K_pi = 1;
g_bc = feedback(K_pi*g*g_pi,K_sensor);
figure;
step(g_bc);

%% Ejercicio 3

clear all; close all; clc;

s = tf('s');
g = 10*(s+6)/(s*(s+4)^2*(s+8)*(s+12));
Kpd = 128;
margin(Kpd*g);

Td = 0.106;
% Td = 0.3;
g_pd = Kpd*(Td*s+1)

figure;
margin(g*g_pd);

%% Ejercicio 4
clear all; close all; clc;

s = tf('s');
g = 20/(s*(0.1*s+1)^2*(0.05*s+1))
Mf = 60; %grados
Mg = 6; % Db

margin(g);
ganancia = 1.78; % ganancia en el pasaje por cero
Kp = cosd(60)/ganancia;

Td = 0.2548;
Ti = 8*Td;

G_PID = (Kp/(Ti*s))*(Ti*Td*s^2+Ti*s+1);

figure;
margin(g*G_PID)
gbc  = feedback(g*G_PID,1);

%%

s = tf('s');
g = 1/(s^2+10*s+16);

Mp = 0.4;
zita = -log(Mp)/sqrt(pi^2+log(Mp)^2)
polos=[-20 -2+6.85i -2-6.85i]
den=poly(polos)

Kp = 114.9;
Td = 0.122;
Ti = 0.113;

G_PID = (Kp/(Ti*s))*(Ti*Td*s^2+Ti*s+1);
gbc  = feedback(g*G_PID,1);

rlocus(g*G_PID)

figure;
step(gbc);
pole(gbc)



