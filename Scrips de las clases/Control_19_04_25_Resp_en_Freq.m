clear all; close all; clc;
s = tf('s');
g = 75/(s+5);
subplot(1,2,1);
nyquist(g);
subplot(1,2,2);
bode(g);

%%
%%%%% Diagrama de Bode y de Nyquist de un sistema de segundo orden

%%%% Parametros del sistema de segundo orden
k=1;
wn=3;
zi1=0.5; zi2=0.1;
s=tf('s');
%%%%% El zita mas chico presenta un pico de resonancia

g1=k*wn^2/(s^2+2*zi1*wn*s+wn^2);
g2=k*wn^2/(s^2+2*zi2*wn*s+wn^2);
subplot(1,2,1);
nyquist(g1); grid on; hold on;
nyquist(g2);
subplot(1,2,2);
bode(g1); grid on; hold on;
bode(g2);




