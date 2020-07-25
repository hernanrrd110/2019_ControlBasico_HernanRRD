%% Practica Reguladores por metodo frecuencial
%% Ejercicio 2
clc; clear all; close all

s = tf('s');
g = (s+5)/(s*(s+0.1)*(s^2+10*s+29));

figure('Name','bode sin regular')
margin(g)

Kp = 1/16.2;
Ti = 121;
gpi = Kp*(1+1/(Ti*s));

figure('Name','bode con PI')
margin(g*gpi)

Mf = 44.3; zita = Mf/100
gbc = feedback(g*gpi,1);
Mp = exp(-zita*pi/(1-zita^2))
damp(gbc)
stepinfo(gbc)

figure('Name','Respuesta a la rampa')
step(gbc/s,1/s)

%% Ejercicio 3 a
clc; clear all; close all

s = tf('s');
g = 200*(s+1)/((s+0.1)*(s^2+10*s+29));

figure('Name','bode sin regular')
margin(g)

Kp = 1/3.03;
Ti = 1.532;
gpi = Kp*(1+1/(Ti*s));

figure('Name','bode con PI')
margin(g*gpi)

Mf = 64.4; zita = Mf/100
gbc = feedback(g*gpi,1);
Mp = exp(-zita*pi/(1-zita^2))
damp(gbc)
stepinfo(gbc)

figure('Name','Respuesta al escalon')
step(gbc)

%% Ejercicio 3 b
clc; clear all; close all

s = tf('s');
g = 200*(s+1)/((s+0.1)*(s^2+10*s+29));

Kp = 99*29/2000 %para error de posicion de 0.01

figure('Name','bode sin regular')
margin(Kp*g)


Td = tand(33.6)/16.3
gpd = 1+Td*s;

figure('Name','bode con PD')
margin(Kp*g*gpd)


gbc = feedback(Kp*g*gpd,1);

damp(gbc)
stepinfo(gbc)

figure('Name','Respuesta al escalon')
step(gbc)

%% Ejercicio 4
clc; clear all; close all

s = tf('s');
h = 1;
g = 4/(s*(s+2));

figure('Name','bode sin regular')
margin(g)

Kp = 1/1.19;
Ti = 10/1.38;
gpi = Kp*(1+1/(Ti*s));

figure('Name','bode con PI')
margin(g*gpi)

gbc = feedback(g*gpi,1);

damp(gbc)
stepinfo(gbc)

figure('Name','Respuesta al escalon')
step(gbc)

%% Ejercicio 5
clc; clear all; close all

s = tf('s');
g = 1/(s*(s+10)^2)

Kp = 2000 %para error de posicion de 0.01

figure('Name','bode sin regular')
margin(g)

gbc = feedback(Kp*g,1);

damp(gbc)
stepinfo(gbc)

figure('Name','Respuesta a la rampa')
step(gbc/s,1/s)

%% Ejercicio 6
clc; clear all; close all

s = tf('s');
g = 4/(s*(s/50+1)*(s/100+1))

Kp = 50 %para error de posicion de 0.01

figure('Name','bode sin regular')
margin(Kp*g)

% gbc = feedback(Kp*g,1);
% 
% damp(gbc)
% stepinfo(gbc)
% 
% figure('Name','Respuesta a la rampa')
% step(gbc/s,1/s)


