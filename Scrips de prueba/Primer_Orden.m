%% Guia primer orden
%% Ejercicio 2 a
clc; clear all; close all;
syms s

% Parametros
K = 10;
T = 5;
y0 = 0;

%funcion transferencia

Xs = 1;
Ys = (K*Xs)/(T*s+1)+(T*y0)/(T*s+1)

x=ilaplace(Ys)
figure;
h=fplot(x,[0 30]); grid on;

%% Ejercicio 2 b
clc; clear all; close all;
syms s

% Parametros
K = 10;
T = 2;
y0 = 10;

%funcion transferencia

Xs = 1/s^2;
Ys = (K*Xs)/(T*s+1)+(T*y0)/(T*s+1)

x=ilaplace(Ys)
figure;
h=ezplot(x,[0 10]); grid on;

