clear all;close all;clc;

%%%% Primero queremos sacar la función de transferencia con el toolbox
%%%% simbolico
% syms s K;
% g = 1/((s+1)*(s+2));
% h = 1/((s+8)*(s+10));
% g_bc = simplify(K*g/(1+K*g*h));
% pretty(g_bc);

%%%% Usamos el toolbox de control para calcular los polos
%%%% Lo vemos para diferentes valores de K

%%
s = tf('s');

fprintf('........Para K = 10/r/n');
K = 10;
g_bc = (K*(s^2 + 18*s + 80))/(s^4 + 21*s^3 + 136*s^2 + 276*s + K + 160);
fprintf('polos/r/n');
pole(g_bc)
fprintf('ceros/r/n');
zero(g_bc)

fprintf('........Para K = 14/r/n');
K = 14;
g_bc = (K*(s^2 + 18*s + 80))/(s^4 + 21*s^3 + 136*s^2 + 276*s + K + 160);
fprintf('ceros/r/n');
pole(g_bc)
fprintf('polos/r/n');
zero(g_bc)

fprintf('........Para K = 2000/r/n');
K = 2000;
g_bc = (K*(s^2 + 18*s + 80))/(s^4 + 21*s^3 + 136*s^2 + 276*s + K + 160);
fprintf('ceros/r/n');
pole(g_bc)
fprintf('polos/r/n');
zero(g_bc)

%%
clc;

s = tf('s');
K = 1;
h = 1;
g = 1/((s+0.2)*(s^2+0.8*s+1));
g_bc = K*g/(1+K*g*h);
fprintf('polos/r/n');
pole(g_bc)
pole(g) 

%%
%calculos de puntos de ruptura (derivada de k=0)
%%%%Puntos de ruptura ejemplo 1

clc;
s = tf('s');
K = 3*s^2+2*s+2.6;
zero(K)

%%%%Puntos de ruptura ejemplo 2
syms s;
K = (s+1)*s/(s+2);
fprintf('.......... Derivada de K');
K_derivada = diff(K,s)
pretty(K_derivada)
fprintf('.......... Puntos de infleccion');
solve(K_derivada==0,s)
vpa(solve(K_derivada==0,s),5)

%%
%%%%%%%%%% HERRAMIENTA PARA CALCULAR RAMA
clc;
s = tf('s');
K = 0.96; % K critico
h = 1;
g = 1/((s+0.2)*(s^2+0.8*s+1));
%%% Lo podemos calcular de dos maneras
% g_bc = (K*g/(1+K*g*h))
g_bc = feedback(0.96*g,h)
pole(g_bc)
rlocus(g)

















