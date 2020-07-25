%USANDO LOS DATOS DE LA GRAFICA DADA
clear all; close all; clc;
Mp = 0.5;
K = 9*(pi^2+log(Mp)^2)/(16*log(Mp)^2) -1/2;
K = 11;
M = 10*0.0001;
syms s t;
g = 2*K/(2*s^2+3*s+(1+2*K));
y_t = ilaplace(g)
% y_t = (6540092057171247*2^(1/2)*6504907685082415^(1/2)*exp(-(3*t)/4)*sin((2^(1/2)*6504907685082415^(1/2)*t)/33554432))/218268482585375308513280;

y_max = simplify(subs(y_t,t,0.4621))
pretty(y_max)
clear s;
s = tf('s');
g = 2*K/(2*s^2+3*s+(1+2*K));

wn = sqrt((1+2*K)/2);
zita = 3/sqrt(8*(1+2*K));
wd = wn*sqrt(1-zita^2);

Kg = K/wn^2;

Valor = Kg*M*wn/sqrt(1-zita^2);

tp = pi/wd;

% impulse(M*g);
% hold on;
% step(M*g);




%%
K=0.1;
wn=561;
zi=0.5;


s=tf('s');


%Comparacion de la respuesta al escalon y la delta para un mismo sistema
%con zita=0.4

g=K*wn^2/(s^2+2*zi*wn*s+wn^2);


%polos=pole(g)

step(100*g)
