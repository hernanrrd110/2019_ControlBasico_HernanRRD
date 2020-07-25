%% Practica Reguladores por LR
%% Ejercicio 1
clc; clear all; close all

Mp = 10;
ts = 1;
zita=(-log(Mp/100))/(sqrt(pi^2+(log(Mp/100))^2));
wn = 4/(zita*ts);
wd = wn*sqrt(1-zita^2);
pd1 = -zita*wn + wd*1i
pd2 = -zita*wn - wd*1i;

s = tf('s'); 

Gp = 0.5/(s*(s+7));
Gr = 0.0227*s + 1;
rlocus(Gp*Gr)
grid;
hold on ;
plot (real(pd1),imag (pd1),'rx');
plot (real(pd2),imag (pd2),'rx');

K = 1/abs(evalfr(Gr*Gp, pd1));
% K = 90;
Gbc = feedback(Gr*Gp*K,1);
figure();
step (Gbc);

polos_bc = pole(Gbc)
ceros_bc = zero(Gbc)

damp(Gbc)

%% Ejercicio 2
clc; clear all; close all

Mp = 10;
ts = 1.6;
zita=(-log(Mp/100))/(sqrt(pi^2+(log(Mp/100))^2));
wn = 4/(zita*ts);
wd = wn*sqrt(1-zita^2);
sigma = -zita*wn;
pd1 = -zita*wn + wd*1i
pd2 = -zita*wn - wd*1i;

s = tf('s'); 

g = 4/((s+2)*(1+0.25*s));
polos_g = pole(g)

% Aportes de los polos existentes en el polo deseado
alpha1 = angle(pd1 - polos_g(1)) *180/ pi
alpha2 = angle(pd1 - polos_g(2)) *180/ pi
phi = alpha1 + alpha2 -180

%Aporte negativo --> PI
%Recalculo de aporte con polo

alpha0 = angle(pd1)*180/ pi
phi = alpha0 + alpha1 + alpha2 -180

dx = imag(pd1)/tand(phi)
z_ti = -dx + real (pd1) % posicion del polo deseado

Ti = -1/z_ti
g_pi = (1+1/(Ti*s));

figure('Name','LR con regulador PI')
vector_k = linspace(0,10,100000);
rlocus(g*g_pi,vector_k)

hold on ;
plot (real(pd1),imag (pd1),'rx');
plot (real(pd2),imag (pd2),'rx');

Kp = 0.931;

g_bc1 = feedback(Kp*g*g_pi,1);
polos_BC = pole(g_bc1)
ceros_BC = zero(g_bc1)
damp(g_bc1)
stepinfo(g_bc1)

figure('Name','Respuesta al escalon')
step(g_bc1)


%% Ejercicio 3
clc; clear all; close all

zita = 0.8;
Mp = exp(-zita*pi/sqrt(1-zita^2));
ts = 7; % Requerimiento menor a 8.2
wn = 4/(zita*ts);
wd = wn*sqrt(1-zita^2);
sigma = -zita*wn;
pd1 = -zita*wn + wd*1i
pd2 = -zita*wn - wd*1i;

s = tf('s');
h1 = 2;
g = 1/((s+1)*(1+5*s));
polos_g = pole(g)

% Aportes de los polos existentes en el polo deseado
alpha1 = angle(pd1 - polos_g(1)) *180/ pi
alpha2 = angle(pd1 - polos_g(2)) *180/ pi
phi = alpha1 + alpha2 -180

%Aporte negativo --> PI
%Recalculo de aporte con polo

alpha0 = angle(pd1)*180/ pi
phi = alpha0 + alpha1 + alpha2 -180

dx = imag(pd1)/tand(phi)
z_ti = -dx + real (pd1) % posicion del polo deseado

Ti = -1/z_ti
g_pi = (1+1/(Ti*s));

figure('Name','LR con regulador PI')
vector_k = linspace(0,5,100000);
rlocus(h1*g*g_pi,vector_k)

hold on ;
plot (real(pd1),imag (pd1),'rx');
plot (real(pd2),imag (pd2),'rx');

Kp = 0.935;

g_bc1 = feedback(Kp*g*g_pi,h1);
polos_BC = pole(g_bc1)
ceros_BC = zero(g_bc1)
damp(g_bc1)
stepinfo(g_bc1)

figure('Name','Respuesta al escalon')
step(g_bc1)
%% Ejercicio 3 c
clc; clear all; close all

% datos del inciso anterior
s = tf('s');
h1 = 2;
g1 = 0.935/((s+1)*(1+5*s));
Ti_1 = 12.8800;
g_pi_1 = (1+1/(Ti_1*s));

% Recalculo de los parametros del sistema
Mp = 5;
zita=(-log(Mp/100))/(sqrt(pi^2+(log(Mp/100))^2))
ts = 5; % Requerimiento menor a 8.2
wn = 4/(zita*ts);
wd = wn*sqrt(1-zita^2);
sigma = -zita*wn;
pd1 = -zita*wn + wd*1i
pd2 = -zita*wn - wd*1i;

% polos y ceros de ba del sistema entero
g_bc1 = feedback(g1*g_pi_1,h1);
h2 = 0.22*(s+5)/(s+2);
polos_gba2 = pole(g_bc1*h2)
ceros_gba2 = zero(g_bc1*h2)

alpha1 = angle(pd1 - polos_gba2(1)) *180/ pi
alpha2 = angle(pd1 - polos_gba2(2)) *180/ pi
alpha3 = angle(pd1 - polos_gba2(3)) *180/ pi
alpha4 = angle(pd1 - polos_gba2(4)) *180/ pi
tita1 = angle(pd1 - ceros_gba2(1)) *180/ pi
tita2 = angle(pd1 - ceros_gba2(2)) *180/ pi
phi = -180 + alpha1 + alpha2 + alpha3 + alpha4 - tita1 - tita2

% Aporte positivo --> PD

dx = imag(pd1)/tand(phi)
z_pd = -dx + real(pd1)
Td = 1/abs(z_pd)

G_reg = 1+Td*s;

figure('Name','LR con regulador PI')
vector_k = linspace(3,7,100000);
rlocus(g_bc1*h2*G_reg,vector_k)
hold on ;
plot (real(pd1),imag (pd1),'rx');
plot (real(pd2),imag (pd2),'rx');

Kp = 6.61;

g_bc2 = feedback(Kp*g_bc1*G_reg,h2);
polos_BC = pole(g_bc2)
ceros_BC = zero(g_bc2)
damp(g_bc2)
stepinfo(g_bc2)

figure('Name','Respuesta al escalon')
step(g_bc2)







