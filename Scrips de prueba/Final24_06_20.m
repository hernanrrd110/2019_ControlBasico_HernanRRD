%% Final 24-06-20
%% ejercicio 1
clear all;close all;clc;

Mp = 10;
ts = 2.5;
zita=(-log(Mp/100))/(sqrt(pi^2+(log(Mp/100))^2));
wn = 4/(zita*ts);
wd = wn*sqrt(1-zita^2);
pd1 = -zita*wn + wd*1i
pd2 = -zita*wn - wd*1i;

s = tf('s'); 

g = (s+6)/(s^3+16*s^2+69*s+90);

figure('Name', 'G sin regular')
rlocus(g)
polos_g = pole(g)
cero_g = zero(g)

alpha1 = angle(pd1 - polos_g(1)) *180/ pi
alpha2 = angle(pd1 - polos_g(2)) *180/ pi
alpha3 = angle(pd1 - polos_g(3)) *180/ pi
tita1 = angle(pd1 - cero_g(1)) *180/ pi
phi = alpha1 + alpha2 + alpha3 -tita1-180

% Aporte recalculado (PI)
alpha0 = angle(pd1) *180/ pi
phi = alpha0 + alpha1 + alpha2 + alpha3 -tita1-180

dx = imag(pd1)/tand(phi)
z_ti = -dx + real (pd1) % posicion del polo deseado

Ti = -1/z_ti
g_pi = (1+1/(Ti*s));

figure('Name','LR con regulador PI')
vector_k = linspace(0,20,100000);
rlocus(g*g_pi)

hold on ;
plot (real(pd1),imag (pd1),'rx');
plot (real(pd2),imag (pd2),'rx');

K = 10.7
g_bc1 = feedback(K*g*g_pi,1);
polos_BC = pole(g_bc1)
ceros_BC = zero(g_bc1)
damp(g_bc1)
stepinfo(g_bc1)

figure('Name','Respuesta al escalon')
step(g_bc1)

%% ejercicio 2
clear all;close all;clc;

s = tf('s');
K = 10; 
g = K*(1+s/1e-3)*(1+s/1e-1)/(s*(1+s/10)*(1+s/1e3)^3)

figure()
margin(g)
grid

figure()
nyquist(g)
Ti = 10/947;
Kp = 1/3.9e5;
gpi = 1+1/(Ti*s);

figure()
margin(Kp*gpi*g)
grid




