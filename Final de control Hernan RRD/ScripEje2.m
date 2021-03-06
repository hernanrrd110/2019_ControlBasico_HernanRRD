
clear all; close all; clc;

syms s 

%Lazos encontrados en el sistema
L1 = -3/s;
L2 = -2/s;
L3 = -1/s;
L4 = -1/s^3;

% Determinante del sistema. L1 y L3 son los unicos lazos disjuntos
den = simplify(1-L1-L2-L3-L4+L1*L3)


%Agregamos todos los caminos y los cofactores relacionados, dependiendo de
% si el camino toca el lazo o no a partir del determiannte
P1 = 5/s^4; 
cof1 = 1;
P2 = 5/s^2; 
cof2 = 1+3/s;
P3 = 2/s^2;
cof3 = 1+1/s;
P4 = -4/s;
cof4 = 1;
P5 = -2/s^3;
cof5 = 1;

num = simplify(P1*cof1+P2*cof2+P3*cof3+P4*cof4+P5*cof5)
%%
% La funcion G(s) queda como 
clc;

funcion_transferencia = num/den
clear s; s =  tf('s');
g = (-4*s^3+7*s^2+15*s+5)/(s*(s^3+6*s^2+3*s+1))

%Podemos ver que el sistema resultante es de tipo 1, por lo que agregando
%un PI,el sistema quedar�a de tipo 2 y el error en estado estacionario 
%quedaria nulo

%Resolucion por PI
margin(g)

%Requisito de MF > 35�
% Agregando un intervalo de seguridad de 10�, el margen quedaria de 45�
% Esto se debe a que el ajuste no ser� exacto, y es necesario corregir m�s
% fase
%Buscamos la fase donde es igual a -180 + MF y la ganancia en tal punto
w = 0.529
Mag_w = 10.7;
% La zona de dise�o del PI empieza 10 decadas despues de la frecuancia de
% corte del mismo. EL aporte es de ganancia, y tiene que ser la inversa de
% la ganancia medida en el punto


Kp = 1/10.7;
Ti = 10/w;

gpi = Kp*(1+1/(Ti*s))
figure('Name', 'Bode con regulador PI')
margin(g*gpi)
% El margen de fase queda en los niveles requeridos en la consigna

gbc = feedback(g*gpi,1)

step(gbc/s,1/s)
% Se puede ver que la respuesta tiende a un error en estado estacionario de
% cero







