% EJERCICIO 1 - POR LUGAR DE RAICES
clear all;close all;
s=tf('s');
g=1/((s^2+10*s+16))
pole(g)

% Especificaciones de dise?o
MP=40; ts=2;
zita=(-log(MP/100))/(sqrt(pi^2+log(MP/100)^2))
sigma=(4/ts)
wn=(sigma/zita)
wd=wn*(sqrt(1-zita^2))
pd=-sigma + wd*j % Polo deseado en -2+/-6.85j

% Aporte angular
angp0=180*angle(pd)/pi
angp2=180*angle(pd-(-2))/pi
angp8=180*angle(pd-(-8))/pi
phi = -180 + angp0 + angp2 + angp8 
% Aporte total considerando el polo al origen es de 65.074
% Si consideramos 2 ceros iguales, entonces cada uno debera aportar 
% 32.54 grados, siendo ti=4td

kp=1; % Fijo kp=1 para realizar el LR y despues saco el valor real del mismo
td=0.0392
ti=0.1568
gpid=minreal(kp*(1+1/(ti*s)+td*s))
zero(gpid) % Verifico la ubicacion de los ceros en -12.75
rlocus(g*gpid)% donde verifico que pase por el polo deseado y obtengo kp
kp=70.6
gpid=minreal(kp*(1+1/(ti*s)+td*s))
gbc=minreal((gpid*g)/(1+gpid*g));
step(gbc)

% POR ASIGNACION DE POLOS - Defino todos lo spolos a BC
polos=[-20 -2+6.85i -2-6.85i]
den=poly(polos)
gbc2=tf(1,den)
% El Regulador PID queda:
kp=114.9;
ti=0.113;
td=0.1218;
gpid=minreal(kp*(1+1/(ti*s)+td*s))
zero(gpid)
%Funcion de transferencia a BC:
gbc_ap=minreal(g*gpid/(1+g*gpid));
step(gbc_ap)
pole(gbc_ap)
zero(gbc_ap)
% No verifica debido a que existen dos ceros a BC cercanos a los polos de
% BC que afectan la respuesta - el metodo no es bueno


%Ejercicio 2 - POR Ziegler y Nichols
clear ll; close all
s=tf('s')    

% Ingreso funcion de tranferencia
g=(20*s+120)/(s^3+10*s^2+29*s+20)

% Especificaciones de disenio
MP=10; ts=1;
zita=(-log(MP/100))/(sqrt(pi^2+log(MP/100)^2))
sigma=(4/ts)
wn=(sigma/zita)
wd=wn*(sqrt(1-zita^2))
p=[-sigma wd] % polo deseado en -4+/- 5.457i
rlocus(g)

%Haciendo por Ziegler y Nichols y midiendo de la grafica:
step(g)  
L=0.24 % medido de la grafica
T=1.8  % medido de la grafica
kp=(1.2*T/L)
ti=2*L
td=0.5*L
gpid=minreal(kp*(1+1/(ti*s)+td*s))
zero(gpid)
gbc=minreal((gpid*g)/(1+gpid*g));
step(gbc)
