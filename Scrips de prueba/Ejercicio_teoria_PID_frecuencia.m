%% Ejercicio teoria Regulador PID metodo frecuencial
clear all; close all; clc;

s = tf('s');

g = 20/(s*(0.1*s+1)^2*(0.05*s+1))

figure('Name', 'Bode sin reg')
margin(g)

Kp = 0.281;
Td = 0.254;
Ti = 8*Td;

g_r = Kp*(1+1/(Ti*s)+Td*s);

figure('Name', 'Bode con PID, Mf = 60, Mg = 9 dB')
margin(g*g_r)
