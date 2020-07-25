%% EJEMPLO 1 de la Teoria

%Se pide utilizar un regulador PID en la forma IDEAL dise�ado por el m�todo anal�tico  
% para lograr en BC un error de velocidad menor al 5%, un MF de unos 55� y un MG=8 dB
clear ll; close all,clc;
s=tf('s');
g=20/(s*(0.1*s+1)^2*(0.05*s+1))

%Para el dise�o por PID por m�todo anal�tico, siendo MF el requerido:
MF=60; 
[Mg,Mf,wcg,wcp] = margin(g);  %M�rgenes  del sistema actual; Mg es el de ganancia en relaci�n de amplitudes
magnitud=1/Mg; %la magnitud donde la fase de g es -180 grados es la inversa de Mg

%De las f�rmulas deducidas por el m�todo anal�tico tenemos:
Kp=cosd(MF)/magnitud;

%Para Ti y Td se utiliza el c�lculo simb�lico de Matlab
syms Ti Td
[solTi, solTd]=solve(Ti==8*Td, Kp*(Td*wcg-1/(Ti*wcg))==sind(MF)/magnitud,[Ti, Td]);

posiblesTi=vpa(solTi)
Ti=double(posiblesTi(2));  %Ti=....
posiblesTd=vpa(solTd)
Td=double(posiblesTd(2));  % Td=....

% gpid=(Kp*(1+1/(Ti*s)+Td*s));

%% EJEMPLO 2 de la Teoria

%Se pide utilizar un regulador PID en la forma SERIE dise�ado como PD en cascada co un PI 
% para lograr en BC un error de velocidad menor al 5%, un MF de unos 55� y un MG=8 dB
clear ll; close all,clc;
s=tf('s');
g=20/(s*(0.1*s+1)^2*(0.05*s+1))
....
....
....

%% EJEMPLO 3 de la Teoria

%Ejemplo de la teor�a del m�todo de ciclo l�mite de Z-N
clear all, close all, clc
s=tf('s');
g=1/((s+0.5)*(s+1)*(s+10));
...
...
...

%% EJEMPLO 4 de la Teoria

%Utilizando el m�todo "S" de Z-N dise�ar un PID para que cumple con un ts
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
[m,p]=max(dy);  %El punto de inflexi�n ocurre en un valor de m�xima derivada
                % m es la pendiente de la recta tangente en el punto de inflexi�n

ti=t(p); %coordenada t del punto de inflexi�n
yi=y(p); % Coordenada y del punto de inflexi�n
plot(ti,yi,'r*')
L=ti-(yi/m)
T=y(end)/m
%La ecuaci�n de la recta tangente al punto de inflexi�n ser�:
y1=m*(t-ti)+yi;
%Sobre la respuesta temporal como hay un hold on habilitado dibujo la recta
% tangente en el punto de inflexi�n
plot(t(5:45),y1(5:45),'r')

%Dise�o del relugar PID seg�n las tablas de Z-N
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
step(gbc) %Se verifica un Mp=18,3% y un ts=3,1 y est� dentro de lo solicitado