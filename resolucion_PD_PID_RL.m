close all;
clear all;

s = tf('s');

Gp = 1/(s^2+3.6*s+9);

PolesGp = pole(Gp)
zita = 0.5;
ts = 2;

sigma = 4/ts;
wn = sigma/zita;
wd = wn*sqrt(1-zita^2);
pd1 = -sigma+wd*1i
pd2 = -sigma-wd*1i

figure;
rlocus(Gp);
hold on;
plot(real(pd1),imag(pd1),'rx');
plot(real(pd2),imag(pd2),'rx');


%% Vemos que el lugar de raices del sistema no pasa por el polo deseado, 
% por lo que es necesario cambiar la dinamica del sistema mediante la
% inlcusión de un compensador. 
close all;

alpha1 = angle(pd1-PolesGp(1))*180/pi
alpha2 = angle(pd1-PolesGp(2))*180/pi

phi = alpha1+alpha2-180

% Observese que el aporte angular es mayor que cero, por lo que el 
% controlador a utilizar ha de ser un PD o un PID. Si fuera un PD, el cero
% deberia ubicarse como:

%% .................Calculo de parametros con Regulador PID
dx = imag(pd1)/tand(phi)

z1 = dx+real(pd1)
Gd  = (s/abs(z1)+1);
% figure;
% rlocus(Gp*Gd)

% hold on;
% plot(real(pd1),imag(pd1),'rx','LineWidth',2);
% plot(real(pd2),imag(pd2),'rx','LineWidth',2);

Kpd = 1/abs(evalfr(Gd*Gp,pd1));
Gpd = Kpd*Gd;
figure;

% step(feedback(Gp*Gpd,1));

%% ................ Calculo con Regulador PID ............................
clc;

alpha1 = angle(pd1-PolesGp(1))*180/pi
alpha2 = angle(pd1-PolesGp(2))*180/pi

alpha0 = angle(pd1-0)*180/pi

phi = alpha0 + alpha1+alpha2-179

% si consideramos Ti = 4Td, tendremos dos ceros a parte real igual, por lo
% que el aporte angular será el mismo:

phi2 = phi/2;

dx = imag(pd1)/tand(phi2)

z12 = -dx+real(pd1)

Td = -1/(2*z12)
Ti = 4*Td
% Gid = (s/abs(z12)+1)^2/s;

K_PID = 1;
% Ti = 0.56;
% Td = 0.14;

G_PID = (K_PID/(Ti*s))*(Ti*Td*s^2+Ti*s+1);

rlocus(G_PID*Gp);

% verificamos si el diseño promueve los polos donde los deseamos
% figure;
% rlocus(Gp*Gid)

hold on;
plot(real(pd1),imag(pd1),'rx');
plot(real(pd2),imag(pd2),'rx');


K_Nuevo = 12.5;
figure();
G_BucleCerrado = feedback(K_Nuevo*G_PID*Gp,1);
step(G_BucleCerrado);

ceros = zero(G_BucleCerrado)
polos = pole(G_BucleCerrado)

polos_keridos = [pd1 pd2 -20];
polinomio_polos = poly(polos_keridos);

% Dise�o por busqueda de coeficientes de polinomios 

Ti_Nuevo = 0.27;
Td_Nuevo = 0.23;
K_Nuevo_2 = 87;
G_PID_Nuevo = (K_Nuevo_2/(Ti_Nuevo*s))*(Ti_Nuevo*Td_Nuevo*s^2+Ti_Nuevo*s+1);
G_BucleCerrado_Nuevo = feedback(G_PID_Nuevo*Gp,1);
pole(G_BucleCerrado_Nuevo)

step(G_BucleCerrado_Nuevo)

% verificamos si el regulador satisface los requisitos de diseñofigure;
%%
figure;
step(feedback(Gp*Gpid,1))
% vemos que no se da, por lo que tenemos que rediseñar. Esto se debe a que 
% los polos deseados no son dominantes. Una opcion es alejar más el 
% termino integral, Ti>4Td. Como el aporte angular es menor que 90°, el 
% cero debe estar a la izquierda del polo deseado. Propongo 
z1 = -3;
gamma1 = angle(pd1-z1)*180/pi
phi = alpha0 + alpha1+alpha2-gamma1-180
dx = imag(pd1)/tand(phi)
z2 = -dx+real(pd1)

Gid = (s/abs(z1)+1)*(s/abs(z2)+1)/s;

figure;
rlocus(Gp*Gid)
hold on;
plot(real(pd1),imag(pd1),'rx');
plot(real(pd2),imag(pd2),'rx');
K = 1/abs(evalfr(Gid*Gp,pd1));
Gpid = K*Gid;
figure;
step(feedback(Gp*Gpid,1))

%% 
clear all; close all; clc;

s = tf('s');
g = 20/(s*(0.1*s+1)^2*(0.05*s+1))
Mf = 60; %grados
Mg = 7; % Db

margin(g);
ganancia = 1.78; % ganancia en el pasaje por cero
Kp = cosd(60)/ganancia;

Td = 0.2548;
Ti = 8*Td;

G_PID = (Kp/(Ti*s))*(Ti*Td*s^2+Ti*s+1);

margin(g*G_PID)
gbc  = feedback(g*G_PID,1);
impulse(gbc*1/s^2,5);





