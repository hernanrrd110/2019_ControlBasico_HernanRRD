%% Control Básico - FI- UNER.
% Diseño de reguladores por medio de características frecuenciales
% Las resoluciones han de ser revisadas. El presente material es sólo a
% título orientativo. 
% Por consultas o sugierencias, dirigirse a eosella@ingenieria.uner.edu.ar
% Fecha: 20190528

%% ej. 2)
clc;
clear all;
close all;
s = tf('s');
F = (s+5)/((s+0.1)*(s^2+10*s+29)*s);
% como el sistema es tipo 1, con el integrador seria tipo 2 y el error de
% velocidad me quedaria cero. Por tanto, puedo utilizar un PI. Para
% dise�arlo, busco la frecuencia donde deseo mi margen de fase de
phi = -180+5+40;
% en el DB de fase.
bode(F);
grid on;
wc = 0.1;
% valor medido aproximadamente 0.1
Ti =  10/wc;
% Ahora busco la magnitud en esa frecuencia. daba -21.7, gano un dB mas
% para corregir mejor.
Ma = -22.7;
Kp = 10^(Ma/20);
Gpi = (Kp +Kp/(Ti*s));
figure;
bode(Gpi*F);
grid on;
% como da error de velocidad, lo que tenemos que evaluar en la respuesta temporal es la rampa como entrada
figure;
step(Gpi*F/(s*(1+Gpi*F)));
grid on;
hold on;
step(1/s);
%% Ej. 3) 

clear all;
close all;
clc;
%%
s = tf('s');
F = 200*(s+1)/((s+0.1)*(s^2+10*s+29));
figure;
bode(F);
grid on;
% busco en el bode la frecuencia con fase en phi = -180+Mf+5 = 115
wc = 7.26;
Ti = 10/wc;
Ma = 8.26;
Kr = 10^(-Ma/20);
Gpi = (Kr +Kr/(Ti*s));
figure;
bode(Gpi*F);
grid on;
Gcli = Gpi*F/(1+Gpi*F);
step(Gcli);
grid on;
%% dise�o del PD
Ke  = 200/2.9;
Kpd = 99/Ke;
%Kpd = 10*Kpd;
figure;
bode(Kpd*F);
grid on;
% buscamos en el bode de magnitud la frecuencia de crce por cero de Kpd*F 
wc = 16.3;
% en dicha frecuencia, buscamos la fase Fa y caulculamos el aporte
% requerido por el PD
Fa = -149;
phi = -180+60+5-Fa;
Td  = tan(phi*pi/180)/wc;
Gpd = Kpd*(1+Td*s);
figure;
bode(Gpd*F);
grid on;

figure;
bode(Gpi*F,Gpd*F);
grid on;
Gcld = Gpd*F/(1+Gpd*F);
figure;
step(Gcli);
hold on;
step(Gcld);
grid on;
% es de eleccion el PD por que es mucho mas rapido y mejora el margen de
% ganancia (infty)

%% ej.4)
close all;
clear all;
clc
%%
s  = tf('s');
Kv = 20;
Mf = 50;
Mg = 10;
G = 4/(s*(s+2));
H = 1;
bode(G*H);
grid on;
Kpd = Kv*0.5;
bode(G*H*Kpd);
grid on;

wc = 6.18;
f_wc = -162;
phi = Mf+5-f_wc-180;
Td = tan(38*pi/180)/wc;

Gpd = Kpd*(1+Td*s);
bode(Gpd*H*G);
grid on;

figure;
step(Gpd*G/(1+Gpd*G));
grid on;

%% Ej. 5. 
clc;
clear all;
close all;
s = tf ('s');
%%
G = 1/(s*(s+10)^2);
zita = 0.7;
Kv = 20;
bode(G);
grid on;
Mf = atan(2*zita/(sqrt(sqrt(1+4*zita^2)-2*zita^2)))*180/pi;
phi = -180+Mf+5;
wc = 2.29;
Gain  = -47.7;

Ti = 10/wc;
Kp = 10^(-Gain/20);
Gpi = (Kp+Kp/(Ti*s));

bode(G*Gpi)
grid on;

figure;
step(G*Gpi/(1+G*Gpi));
Mp = 0.13;
zita_e = -log(Mp)/sqrt(pi^2+(log(Mp))^2); 
% no verifica el zita, pero estamos hablando de un sistema aproximado....

%% Ej. 6)
close all;
clear all;
clc
s  = tf('s');

%%
G = 4/(s*(s/50+1)*(s/100+1));
Mfd = 50;
Kv = 200;
wcmin = 60;

bode(G);
grid on;

Gainreq = 30;
Kp = 10^(Gainreq/20);
Gpi = Kp *(1+1/(Ti*s));
Kp = 50;
figure;
bode(Kp*G);
grid on;
wc = 70.7;
Td1 = atan(pi/180*(35+7.52))/wc;
Gpd1 = Kp*(1+Td1*s);
figure;
bode(G*Gpd1);
grid on;

Td2 = atan(pi/180*(55+154-180))/wc;
Gpd2 = (1+Td2*s);
figure;
bode(G*Gpd1*Gpd2);
grid on;
