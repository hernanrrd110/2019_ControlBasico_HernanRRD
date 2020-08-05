clear all;close all;clc;

s = tf('s');
g = 1/((s+0.5)*(s+1)*(s+10));

vector_k = linspace(150,180,100000);
figure('Name', 'lugar de raices de g')
rlocus(g,vector_k)

figure('Name', 'Respuesta al escalon para K critico')
K_critico = 173.25;
gbc=feedback(g*K_critico,1);
step(gbc)

Pc = 1.64;
Ti = Pc/2;
Td = Pc/8;
Kp = 0.6*K_critico;
%Kp = 5;
gpid = Kp*(1+1/(Ti*s)+Td*s);

figure('Name', 'Respuesta al escalon Mp 50')
gbc2=feedback(g*gpid,1);
step(gbc2)


