close all; clear all; clc;

% ================ Ejercicio resuelto con PD y PID ================
s = tf('s');
% Funcion tranferencia
Gp = 1/(s^2+3.6*s +9);
PolesGp = pole (Gp);
% Condiciones 
zita = 0.5;
ts = 2;
sigma = 4/ ts;
wn = sigma/zita;
wd = wn*sqrt(1-zita^2);
pd1 = - sigma + wd *1i
pd2 = - sigma - wd *1i
figure;
% Lugar de raices original
rlocus (Gp);
hold on;
plot(real(pd1),imag(pd1),'rx');
plot(real(pd2),imag(pd2),'rx');

% Aportes de los polos existentes en el polo deseado
alpha1 = angle (pd1 - PolesGp (1)) *180/ pi
alpha2 = angle (pd1 - PolesGp (2)) *180/ pi
phi = alpha1 + alpha2 -180

dx = imag(pd1)/tand(phi)

z1 = -dx + real (pd1) % posicion del polo deseado
Gd = (s/abs(z1)+1) ;
figure ;
rlocus (Gp*Gd)
hold on ;
plot (real(pd1),imag (pd1),'rx');
plot (real(pd2),imag (pd2),'rx');

Kp = 1/abs(evalfr(Gd*Gp, pd1));

figure;
%Kp = 7.27;
step(feedback (Kp*Gp*Gd ,1));

%% ========================= Calculo PID =========================
close all; clear all; clc;

s = tf('s');
% Funcion tranferencia
Gp = 1/(s^2+3.6*s +9);
PolesGp = pole (Gp);
% Condiciones 
zita = 0.5;
ts = 2;
sigma = 4/ ts;
wn = sigma/zita;
wd = wn*sqrt(1-zita^2);
pd1 = - sigma + wd *1i
pd2 = - sigma - wd *1i

% Aporte del regulador PID
phi = alpha0 + alpha1 + alpha2 -180;
phi = phi/2 %Debido a que hay dos ceros iguales que aportan lo mismo

% Posicion de los ceros
z1_PID = -imag(pd1)/tand(phi) + real(pd1) % posicion del polo deseado
Td = 1/(2*abs(z1_PID))
Ti = 4*Td
G_PID = 1+1/(Ti*s)+Td*s;

% Lugar de raices compensado con PID
figure;
vector_k = linspace(0,140,1000);
rlocus(Gp*G_PID,vector_k)
hold on 
plot (real(pd1),imag (pd1),'rx');
plot (real(pd2),imag (pd2),'rx');

Kp_PID = 12,4;
figure;
step(feedback (Kp_PID*Gp*G_PID ,1));


%% ================ Calculo PID Por Asignacion de polos  =================
close all; clear all; clc;

s = tf('s');
% Funcion tranferencia
Gp = 1/(s^2+3.6*s +9);
PolesGp = pole (Gp);
% Condiciones 
zita = 0.5;
Mp = exp(-zita*pi/sqrt(1-zita^2))
ts = 2;
sigma = 4/ ts;
wn = sigma/zita;
wd = wn*sqrt(1-zita^2);

%Polos deseados
pd1 = - sigma + wd *1i
pd2 = - sigma - wd *1i

%Polo adicional
pd3 = -15.0000

fprintf('polos:\n')
fprintf('%.4f+ %.4f i \n',real(pd1),imag(pd1))
fprintf('%.4f+ %.4f i \n',real(pd2),imag(pd2))
fprintf('%.4f+ %.4f i \n',real(pd3),imag(pd3))

polos = [pd1 pd2 pd3];
poli_deseado = poly(polos)
a3 = poli_deseado(1);
a2 = poli_deseado(2);
a1 = poli_deseado(3);
a0 = poli_deseado(4);

%resolucion de ecuaciones
syms K Td Ti
eqns = [3.6+K*Td==a2,K+9==a1,K/Ti==a0];
soluciones = solve(eqns,[K Td Ti]);
clear K Td Ti
Kp_PID = double(soluciones.K)
Td = double(soluciones.Td)
Ti = double(soluciones.Ti)

% De la igualacion de los polinomios, obtenemos
% Td = 0.234;
% Ti = 0.273;
% Kp_PID = 87;

G_PID = 1+1/(Ti*s)+Td*s;

G_bc = feedback (Kp_PID*Gp*G_PID ,1);
fprintf('polos:')
pole(G_bc)
fprintf('ceros:')
zero(G_bc)


figure('Name','Respuesta regulada, zita de 0.5 y ts de 2');
step(G_bc);


