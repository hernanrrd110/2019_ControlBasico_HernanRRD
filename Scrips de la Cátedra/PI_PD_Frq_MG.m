%% Diseño de reguladores PD con requisito de margen de ganancia
% Se está trabajando en el desarrollo de un agitador, para el cual se 
% requiere el diseño de un cotrol del motor que acciona la platina. Para 
% ello, se ha relevado la planta a controlar como una función de 
% transferencia F(s) (definida debajo). Los requerimientos de diseño son 
% constante de velocidad (Kv >= 20) y un margen de ganancia >= a 10dB. 
close all;
s = tf('s');
Kv = 20;
Mgd = 10;

zita = 0.7;
wn  = 5;

F = (s+5)/((s+0.01)*(s^2+2*zita*wn*s+wn^2)*s);
% Por las características intrínsecas del problema en cuestión, puede
% resultar atractivo el diseño de un controlador PD, debido a que la
% inclusión de ruido en el sistema (debido al aumento en el ancho de banda
% del sistema) no tiene implicancias no deseadas, y el error en estado 
% estacionario no es una variable determinante
Kdc = dcgain(s*F);
Kpd = Kv/Kdc;
figure;
bode(F*Kpd);
grid on;
% busco en el diagrama de magnitud de Bode la frecuencia a la cual  
% |Kp*F| = -Mgd, y mido en el de fase la fase Fb en dicho punto
wc = 0.8;
Fb = -185;
% calculo el deficit angular a aportar y con esto despejo el valor de Td
phib = 180+Fb;
Td = tand(-phib)/wc
% El regulador adquiere la expresión
Gpd = Kpd * (1+Td*s);
% verifico el resultado
figure;
bode(F*Gpd)
grid on;
% Verificación temporal del cumplimiento de los requerimientos: dado que 
% se solicita error de velocidad, debemos comparar con la entrada rampa.
Fcl = F*Gpd/(1+F*Gpd);
figure;
step(Fcl/s,1/s);


% Es el sistema estable? Comente la estabilidad relativa del mismo

%% Diseño de reguladores PI con requisito de margen de ganancia
% Se está automatizando el sistema de control de la posición de la camilla
% de un acelerador lineal. El sistema tiene un mecanismo de seguridad que
% sólo emite el haz cuando el error de posición es menor al 2%, por lo que
% se puede asumir que el transitorio de la posición es seguro para el
% paciente. Asumiendo que la función de transferencia del sistema de
% posición está dada por F(s) (como se describe debajo) y que funciona a 
% lazo cerrado con una realimentación unitaria, diseñe un regulador que
% minimice el error de posicón de este sistema, y que logre un margen de
% ganancia de 6 dB o superior. 

close all;
clear all;
s = tf('s');
Mgd = 6;
F = 8/(s+1)^3;
ep = 0.02; % menor a 0.02

% El error de posicion queda anulado por que el sistema con el regulador PI
% será tipo 1. Por tanto, es factible utilizar dicho regulador para este
% problema

% Para obtener el controlador, primero obtenemos el d. de Bode de la planta
% y en la grafica de fase buscamos la frecuencia de cruce por -180°. 
figure;
margin(F);
grid on;
[Gm, PM, wb, Wpm] = margin(F);
Mb = 20*log10(Gm);  % los valores que entrega la funcion margin son 
                    % absolutos, por lo que es conveniente pasarlos a dB
                    % para utilizar las formulas vistas en la teoría


% para dicho punto, calculamos el valor de Ti y Kp según
Ti = 10/wb;
Kp = 10^(-(Mb+Mgd)/20);
Gpi = Kp*(1+1/(Ti*s));

% verificamos si el resultado satisface los requisitos de Mg
figure;
margin(F*Gpi);
grid on;

% Por simple inspeccion se observa que los resultados no son del todo
% satisfactorios. Una posible estrategia para corregir este resultado
% consiste en volcar el cero del regulador dos decadas antes (en vez de
% una, como se propuso inicialmente). 

Ti = 100/wb;
Kp = 10^(-(Mb+Mgd)/20);
Gpi1 = Kp*(1+1/(Ti*s));

figure;
margin(F*Gpi1);
grid on;

% observamos que aun el requisito de Mg no esta siendo cumplido, por lo que
% probamos otra estrategia, que sería aumentar el requisito de Mg 
% inicialmente planteado a fin de mejorar el desempeño del sistema:
Mgd = 8;
Ti = 10/wb;
Kp = 10^(-(Mb+Mgd)/20);
Gpi2 = Kp*(1+1/(Ti*s));

figure;
margin(F*Gpi2);
grid on;
% verifica el requisito de margen de ganancia; ahora solo resta verificar
% que el error de posición sea menor al 5%:
Gcl = F*Gpi2/(1+F*Gpi2);
figure;
step(Gcl)
grid on;

% Vemos que el diseño satisface los requisitos. 
