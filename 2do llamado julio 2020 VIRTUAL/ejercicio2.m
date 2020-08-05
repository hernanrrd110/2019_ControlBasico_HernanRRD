%% ejercico 2

%Encontrar la funcion de transferencia.
%para eso voy a determinar cada uno de los factores que lo componen

s=tf('s')
polo1=s %tengo un polo al origen, con pendiente -20dB/dec, que aporta en fase -90 grados
%extendiendo la recta del polo al origen obtengo K, como la frecuencia de
%cruce por el eje 0db
K=300000
w1=10 %frecuencia de corte del polo simple
polo2=(1+s/w1) %con pendiente -20dB/dec, 
%que se uma a la anterior dando una pendiente de -40dB/dec, en fase aporta
%de 0 a -90
w2=30
T=1/w2
zita=0.1
cero1=(T^2*s^2+2*zita*T*s+1) %tengo un cero doble a partir de de w=30
%que anula la pendiente negativa de -40dB dando como resultado pendiente 0,
%y un pico de resonancia, lo que indica que zita es menor a 0.7. Este cero
%aporta en fase de 0 a 180
w3=10^5
polo3=(1+s/w3)

gs=(K*cero1)/(polo1*polo2*polo3)
figure
bode(gs)

%% diseño de un regulador que cumpla MG mayor que 10 y MF=40
h=900/(s^2+s+948)
figure 
margin(gs*h)

%propongo el diseño de un PID
%para tratar de ajustar la fase con el cero TD y luego el margen de
%ganancia con el Ti

%busco wa donde el margen de ganancia es 0
Mf=40+5%margen de seguridad de 5
wa=1.7e+3
fa=-181 %es la fase en wa

phi=Mf-180-fa

%hasta 40 aporta un pd
phi=40 %uso el aporte maximo de un pd

td=tand(phi)/wa %me dio un td=4.9359e-04


