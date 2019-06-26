%% Clase de Teoria Control 23-05-19 Estabilidad Relativa
clear all; close all; clc;

s = tf('s');

% Planta del sistema
g = 8/(s+1)^3;
 margin(g); 
% Pide error de posicion menor al 5 porciento y Mf de 40 grados
%Los margenes son casi cero, por loq ue la respuesta va a oscilar y no va a
%cumplir con los margenes de diseño

G_bc = feedback(g,1);
figure();
%step (G_bc);

ki = 10^(-9.09/20)
Ti = 10/0.995

G_PI  = ki/(Ti*s)*(Ti*s+1);

margin(G_PI*g);
G_bc2 = feedback(G_PI*g,1);
step(G_bc2);

%% Parte b del problema
clear all; close all; clc;

s = tf('s');

% Planta del sistema
g = 8/(s+1)^3;
margin(g); 

G_bc = feedback(g,1);
figure();
%step (G_bc);

% Le damos un margen de 2 dB para tener el margen de ganancia de 6 dB
ki = 10^(-8/20);
Ti = 10/1.73;

G_PI  = ki/(Ti*s)*(Ti*s+1);

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

kp = 9;% para cumplir error al 10 porciento
kd = 12% esto da con un kp de 9

% Planta del sistema

margin(kd*g); 

G_bc = feedback(g,1);
figure();
%step (G_bc);

w = 3.65; % Este es el lugar donde la ganancia da cero
Aporte = 42; % Ya se calculo el aporte segundo el margen de fase actual
Td = tand(Aporte)/w; % Sale del Arcotangente

G_PI  = kd*(Td*s+1);

margin(G_PI*g);
G_bc2 = feedback(G_PI*g,1);

figure;
step(G_bc2);




