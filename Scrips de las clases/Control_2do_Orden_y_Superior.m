%% 
%SISTEMAS DE SEGUNDO ORDEN
syms wn M zi t wd s K

%PARA 0<ZITA<1 
%RESPUESTA TEMPORAL AL ESCAL?N DEDUCIDA EN EL PIZARR?N
wd=wn*(1-zi^2)^(1/2);
y=K*M*(1-exp(-zi*wn*t)*(cos(wd*t)+(zi/(1-zi^2)^(1/2))*sin(wd*t))); 
%% 

%Para deducir la respuesta de un segundo orden con zita=1 y entrada
%escal?n se trabaja de la siguiente forma:
zi=1;
g1=K*wn^2/(s^2+2*zi*wn*s+wn^2)

x1=M/s
y1=ilaplace(g1*x1);
y1=simplify(y1)
pretty(y1)

%%
%Para deducir la respuesta de un segundo orden con zita=0 y entrada
%escal?n se trabaja de la siguiente forma:
zi=0;
g11=K*wn^2/(s^2+wn^2)

x11=M/s
y11=ilaplace(g11*x11)

%%
%La respuesta a un escal?n en un sistema de segundo orden para zita>1 es y4
% y tambi?n puede verse en la transparencia de teor?a:

clear zi;  %Para que no tome zi=0 como se le asign? la ?ltima vez
syms zi
p1=-wn*(zi+sqrt(zi^2-1));
p2=-wn*(zi-sqrt(zi^2-1));
y4=simplify(K*M*(1-(wn/(2*sqrt(zi^2-1)))*(exp(p1*t)/p1-exp(p2*t)/p2)))

%Para obtener la respuesta al impulso derivo la expresi?n anterior: 
y5=simplify(diff(y4,t))

%%
%Funciones de segundo orden con zita mayor a 1, zita=1 y 0<zita<1 para
%entradas impulso y escal?n.


clc; clear all; close all

k=2;
wn=5;
s=tf('s');

%Comparaci?n de la respuesta al escal?n y la delta para un mismo sistema
%con zita=0.4
zi=0.4
g=k*wn^2/(s^2+2*zi*wn*s+wn^2)
pause
polos=pole(g)
pause

step(g)
hold on
impulse(g)
pause


%Lo mismo pero para zita=1
close;
clc;
zi=1
pause
g1=k*wn^2/(s^2+2*zi*wn*s+wn^2)
pause
polos=pole(g1)
pause
step(g1)
hold on
impulse(g1)
pause

%Lo mismo para zita=2
clc;
close;
zi=2
pause
g2=k*wn^2/(s^2+2*zi*wn*s+wn^2)
pause
polos=pole(g2)
pause
step(g2)
hold on
impulse(g2)
pause

%En el caso de zita=0
close
clc;
zi=0
g3=k*wn^2/(s^2+2*zi*wn*s+wn^2)
pause
polos=pole(g3)
pause
step(g3,10)
hold on
impulse(g3,10)

%% SISTEMAS DE ORDEN SUPERIOR

%Agrado de un polo real a un sistema de segundo orden con zita=0,6

clc; clear all; close all;
k=3;
zi=0.6;
wn=3;
M=1;
s=tf('s');
g=k*M/(s^2+2*zi*wn*s+wn^2)
pause;


pole(g)
pause
close;
step(g)
figure(1)
pause
hold on
for n=1:4
b=input('Ingrese el valor del polo adicional: ');
g1=1/(-s/b+1)
pause
g2=g*g1
pause
hold on
step(g2)
figure(1)
pause
end

%% SISTEMAS DE ORDEN SUPERIOR

%Agrado de un cero real a un sistema de segundo orden con zita=0,6
% Segundo_orden_ceros
close;
clc;
k=3;
zi=0.6;
wn=3;
M=1;
s=tf('s');
g=k*M/(s^2+2*zi*wn*s+wn^2)
pause
pole(g)
pause
close;
step(g)
figure(1)
pause
hold on
for n=1:4
b=input('Ingrese el valor del cero para el sistema de Segundo Orden: ');
g1=(-s/b+1)
pause
g2=g*g1
pause
hold on
step(g2)
figure(1)
pause
end

%%