close all; clc; clear all;

s = tf('s');
T = 0.5;
L = 4;
g = 4/(T*s+1)*(1-L/2*s)/(1+L/2*s)

rlocus(g)

ts = 2.5;
Mp = 0.1;

zita = 1/sqrt((pi/log(Mp))^2+1);
wn = 4/(zita*ts);
pd1 = -zita*wn + 1i*wn*sqrt(1-zita^2) 
pd2 = -zita*wn - 1i*wn*sqrt(1-zita^2); 

polos_g = pole(g)
ceros_g = zero(g)

%Aportes angulares de todos los polos

alpha1 = angle(pd1-polos_g(1))*180/pi
alpha2 = angle(pd1-polos_g(2))*180/pi 
tita = angle(pd1-ceros_g(1))*180/pi

phi = alpha1 + alpha2 - tita

% Con Ti = 4Ti se tiene un cero de multiplicidad 2 en 1/2Td
% Por trigonometria sacamos 

dx = imag(pd1)/tand(phi)
% posición del cero:
z = -dx + real(pd1)
Td = -1/z

%%
%Busqueda de la ganancia por condicion de modulo en lugar de raices
gpi = 1+Td*s;
figure('Name','Lugar de raices con regulador')
rlocus(g*gpi)
hold on
plot(real(pd1),imag(pd1),'rx')
plot(real(pd2),imag(pd2),'rx')
hold off

K = 0.247;

figure('Name','Respuesta al escalon')
step(feedback(K*g*gpi,1))







