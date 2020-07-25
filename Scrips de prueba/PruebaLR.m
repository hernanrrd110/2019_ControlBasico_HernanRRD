%% Practica Lugar de raices
%% Ejercicio 1

close all; clc; clear all;

s = tf('s');
K = 45;
h = 1;
g = 1/(s*(s^2+6*s+25));
Mp = 0.253;
zita = -log(Mp)/(pi^2+(log(Mp))^2)^(1/2);
fprintf('Con un Mp de 25.3, se obtiene un zita de:\n zita = %.4f\n',zita)

% Vector de ganancias para graficar el lugar de raices
vector_K = linspace(0,160,1000);
rlocusplot(g*h,vector_K);
grid;

g_bc = feedback(K*g,h)
polos_bucle_cerrrado = pole(g_bc)
ceros_bucle_cerrado = zero(g_bc)

damp(g_bc)
stepResponse = stepinfo(g_bc)

% No se logra la respuesta requerida por la existencia del polo al origen

%% Ejercicio 4
close all; clc; clear all;
s = tf('s');
g = (s+1)/(s^2*(s+3.6));
vector_K = linspace(0,30,500);
rlocus(g,vector_K)

%% Ejercicio 5 a
close all; clc; clear all;
s = tf('s');
g = (s+2)/(s^2+2*s+3);
T = 0.2;
h = 1/(T*s+1);
gh_mod = s*(s^2+2*s+3)/(s^2+3*s+5);
% vector_K = linspace(0,30,500);
% rlocus(g,vector_K)

rlocus(gh_mod)


g_bc = feedback(g,h)
pole(g_bc)

%% Ejercicio 5 b

close all; clc; clear all;

%%%%Puntos de ruptura ejemplo 2
syms s;
K = (-s^3-3*s^2-5*s-3)/(-s^2-s+2);

fprintf('.......... Derivada de K');
K_derivada = diff(K,s)
pretty(K_derivada)

fprintf('.......... Puntos de infleccion');
solve(K_derivada==0,s)
vpa(solve(K_derivada==0,s),5)

clear s;
s = tf('s');
g = (s+2)*(1-s)/((s^2+2*s+3)*(s+1));

zero(s^4+s^3-9*s^2-16*s+7)
rlocus(g)












