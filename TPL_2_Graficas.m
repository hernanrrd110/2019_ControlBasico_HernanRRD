clc; clear all; close all

%%%%% PARA TP 2

%USANDO LOS DATOS DE LA GRAFICA DADA

K=0.1;
wn=561;
zi=0.5;

s=tf('s');


%Comparacion de la respuesta al escalon y la delta para un mismo sistema
%con zita=0.4

g=K*wn^2/(s^2+2*zi*wn*s+wn^2);


%polos=pole(g)

step(100*g)

%%
clc; clear all; close all;

%%%%% PARA TP 2

%USANDO LOS DATOS DEL PROBLEMA 

k = 10;
m = 31.8 * 10^(-6); % Calculada desde Wn y k
B = 0.01783; % el del problema seria 0.47

s=tf('s');

a = m;
b = B;
c = k;
K = 1;

g= K/(a*s^2+b*s+c);
polos=pole(g)

M = 100; %Escalon de Area 100
step(M*g)