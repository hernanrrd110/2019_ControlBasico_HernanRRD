%% Clase de Teoria Control 23-05-19 Estabilidad Relativa
clear all; close all; clc;

s = tf('s');

% Planta del sistema
g = 8/(s+1)^3;
figure('Name', 'Bode sin regulador');
margin(g); 
% Pide error de posicion menor al 5 porciento y Mf de 40 grados
%Los margenes son casi cero, por lo que la respuesta va a oscilar y no va a
%cumplir con los margenes de dise�o

G_bc = feedback(g,1);

%step (G_bc);

Ki = 10^(-9.09/20)
Ti = 10/0.995

G_PI  = Ki/(Ti*s)*(Ti*s+1);

figure('Name', 'Bode con regulador, Mf = 40');
margin(G_PI*g);
G_bc2 = feedback(G_PI*g,1);
figure('Name', 'Respuesta al escalon');
step(G_bc2);

%% Parte b del problema
clear all; close all; clc;

s = tf('s');

% Planta del sistema
g = 8/(s+1)^3;

figure('Name', 'Bode sin regulador');
margin(g); 

% Le damos un margen de 2 dB para tener el margen de ganancia de 6 dB
Ki = 10^(-8/20)
Ti = 10/1.73

G_PI  = Ki/(Ti*s)*(Ti*s+1);

figure('Name', 'Bode con regulador, Mg = 6');
margin(G_PI*g);
G_bc2 = feedback(G_PI*g,1);

% figure;
% step(G_bc2);

%% Regulador PD Parte b del problema
clear all; close all; clc;

% Los requisitos son que hay que tener un error de posicion de
% aproximadamente un 10 porciento y margen de fase de 30 grados, 
% que ya que no hay polos al origen,
% tenemos que tener en cuenta este error

s = tf('s');
g = 6/(s+2)^3;

e = 0.10; % error del 10 porciento
kp = 1/e-1;
kd = kp * evalfr(1/g,0) 

% Planta del sistema
figure('Name', 'Bode solo con kd');
margin(kd*g); 

G_bc = feedback(g,1);
figure('Name', 'Respuesta al escalon sin reg');
step (G_bc);

w = 3.65; % Este es el lugar donde la ganancia da cero
Aporte = 42; % Ya se calculo el aporte segundo el margen de fase actual
Td = tand(Aporte)/w % Sale del Arcotangente

G_PI  = kd*(Td*s+1);

figure('Name', 'Bode con regulador, Mg = 6');
margin(G_PI*g);
G_bc2 = feedback(G_PI*g,1);

figure('Name', 'Respuesta al escalon con PD');
step(G_bc2,1/s^0);




