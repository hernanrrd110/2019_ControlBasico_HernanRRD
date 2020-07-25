%% EJEMPLO 1 de la Teoria

%Se pide utilizar un regulador PID en la forma IDEAL diseñado por el método analítico  
% para lograr en BC un error de velocidad menor al 5%, un MF de unos 55º y un MG=8 dB
clear ll; close all,clc;
s=tf('s');
g=20/(s*(0.1*s+1)^2*(0.05*s+1))

%Para el diseño por PID por método analítico, siendo MF el requerido:
MF=60; 
[Mg,Mf,wcg,wcp] = margin(g);  %Márgenes  del sistema actual; Mg es el de ganancia en relación de amplitudes
magnitud=1/Mg; %la magnitud donde la fase de g es -180 grados es la inversa de Mg

%De las fórmulas deducidas por el método analítico tenemos:
Kp=cosd(MF)/magnitud;

%Para Ti y Td se utiliza el cálculo simbólico de Matlab
syms Ti Td
[solTi, solTd]=solve(Ti==8*Td, Kp*(Td*wcg-1/(Ti*wcg))==sind(MF)/magnitud,[Ti, Td]);

posiblesTi=vpa(solTi)
Ti=double(posiblesTi(2));  %Ti=....
posiblesTd=vpa(solTd)
Td=double(posiblesTd(2));  % Td=....

% gpid=(Kp*(1+1/(Ti*s)+Td*s));

%% EJEMPLO 2 de la Teoria

%Se pide utilizar un regulador PID en la forma SERIE diseñado como PD en cascada co un PI 
% para lograr en BC un error de velocidad menor al 5%, un MF de unos 55º y un MG=8 dB
clear ll; close all,clc;
s=tf('s');
g=20/(s*(0.1*s+1)^2*(0.05*s+1))
....
....
....

%% EJEMPLO 3 de la Teoria

%Ejemplo de la teoría del método de ciclo límite de Z-N
clear all, close all, clc
s=tf('s');
g=1/((s+0.5)*(s+1)*(s+10));
...
...
...

%% EJEMPLO 4 de la Teoria

%Utilizando el método "S" de Z-N diseñar un PID para que cumple con un ts
%menor a 5 seg y un Mp menor al 20%
clear all, close all, clc;
s=tf('s');
g=(s+3)/(s^3+5*s^2+9*s+5);
dt=0.05;
t=0:dt:8;
y=step(g,t);
figure
step(g,t)
hold on
dy=diff(y)/dt;
[m,p]=max(dy);  %El punto de inflexión ocurre en un valor de máxima derivada
                % m es la pendiente de la recta tangente en el punto de inflexión

ti=t(p); %coordenada t del punto de inflexión
yi=y(p); % Coordenada y del punto de inflexión
plot(ti,yi,'r*')
L=ti-(yi/m)
T=y(end)/m
%La ecuación de la recta tangente al punto de inflexión será:
y1=m*(t-ti)+yi;
%Sobre la respuesta temporal como hay un hold on habilitado dibujo la recta
% tangente en el punto de inflexión
plot(t(5:45),y1(5:45),'r')

%Diseño del relugar PID según las tablas de Z-N
kp=1.2*T/L;
ti=2*L;
td=0.5*L;
gpid=minreal(kp*(1+1/(ti*s)+td*s))
gbc=minreal(g*gpid/(1+g*gpid));
figure
step(gbc)  %La respuesta es oscilatoria pero cumple con la consigna de Z-N - Mp 50%
           %Hay que ajustar Td para que cumpla con lo solicitado

figure
%Se puede aumentar td para disminuir el Mp 
for td=0.11:0.05:0.36
    gpid=minreal(kp*(1+1/(ti*s)+td*s));
    gbc=minreal(g*gpid/(1+g*gpid));
    step(gbc)
    hold on
    pause
end
%La mejor respuesta y que cumple con lo solicitado se da a un ajuste de
%Td=0.36. Adoptamos este valor
close all;
step(gbc) %Se verifica un Mp=18,3% y un ts=3,1 y está dentro de lo solicitado