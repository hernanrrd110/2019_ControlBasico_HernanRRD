
clear all
close all
syms s

%por la formula de Mason tengo que obtener la funcion de transferencia 
%a partir del diagrama de flujo obtenido

%tengo 3 caminos
camino1=(1/(1+0.1*s))*(-0.01)
camino2=(1/(1+0.33*s))*(0.033)
camino3=(1/(1+0.33*s))*(1/(1+0.33*s))*(0.033)

%No tengo lazos por lo que el determinante es igual a 1, por lo tanto los
%cofactores asociados a cada camino tambien son 1.

Gs=camino1+camino2+camino3
Gs=simplify(Gs)

clear all
s=tf('s')
G=(1089*s + 5600)/((33*s + 100)^2*(s + 10))
polosBA=pole(G)
cerosBA=zero(G)


%% PARTE C DISEÑO DE UN REGULADOR
%los requisitos de diseño son Mp entre 6 y 10 y ts menor a 3 segundos 
Mp=0.07 %propongo un maximo sobreimpulso 7% que cumple con el requisito
ts=2
%con los requisitos busco los parametros de mi polo deseado
sigma=4/ts
r=(log(Mp))^2
zita=sqrt(1/(pi^2/r+1))
wn=sigma/zita
wd=wn*sqrt(1-zita^2)

pd=-sigma+wd*j %pd=-2+/-2.36 


figure
rlocus(G)
hold on
plot(pd, '*r')

%calculo el aporte angular para que el lugar de raices pase por el polo
%deseado

alpha1=(180/pi)*angle(pd-polosBA(1))
alpha2=(180/pi)*angle(pd-polosBA(2))
alpha3=(180/pi)*angle(pd-polosBA(3))

alpha4=(180/pi)*angle(pd-cerosBA(1))%el aporte del cero 

aportetotal=-alpha1-alpha2-alpha3+alpha4 %los polos restan y los ceros suman
%aportetotal=-112.3941
%para que el aporte angular sea -180, se cumpla la condicion de argumento,
%y asi el lugar de raices pase por el polo deseado, el regulador a diseñar
%tiene que aportar
aportereg=-180+112.3941 %tengo que aportar un angulo negativo de -67.6059
%decido poner un PI, que me aporta un polo al origen y u cero

%calculo el aporte del polo al origen
alpha0=(180/pi)*angle(pd-0) %aporta -130.25

%ahora el aporte total es:
aportetotal=-alpha1-alpha2-alpha3+alpha4-alpha0 %-242.6410
%el cero del regulador debera aportar 62.6410

%ubico el cero en tal lugar que me de ese aporte, lo hago por trigonometria

%tand(62.6410)=imag(pd)/dx de aqui despejo dx
dx=imag(pd)/tand(62.6410)
z=-dx+real(pd) %la ubicacion del 0 está en -3.2226

ti=1/abs(z)
kpi=1
gpi=(kpi/(ti*s))*(1+ti*s)

figure
rlocus(gpi*G)
hold on
plot(pd, '*r')

%determino la ganancia para que ase cumpla la condicion de argumento,
%posicionando el sursor sobre el polo deseado
kpi=16.8
gpi=(kpi/(ti*s))*(1+ti*s)
%calculo la funcion a bucle cerrado, de la planta con mi regulador diseñado
%para ver como responde ante una
%entrada escalon y si cumplen las condiciones de diseño
GBC=feedback(G*gpi,1)

figure
step(GBC)


