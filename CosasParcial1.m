clc;
Mp = 0.5; 
K = 9*(pi^2 + (log(Mp))^2)/(16*(log(Mp))^2) - 1/2
K = 11.6175
wn = sqrt((1+2*K)/2)
zita = 3/sqrt(8*(1+2*K))
syms s;
g = (2*K/(2*s^2+3*s+(1+2*K)));
M = (10*0.0001)
% escalon = minreal(ilaplace(g*M/s))
impulso = simplify(ilaplace(g*M))
K_g = K/wn^2
K_g*M

clear s;
s = tf('s');
g = (2*K/(2*s^2+3*s+(1+2*K)));
step(M*g);
% impulse(M*g);

%%
clear all; close all; clc;

K=0.36;
a = 0.0116;
b = 0.0181;
c = -1;
T = sqrt(a);
wn = 1/T;
zi=b/(2*T);

s=tf('s');


g=K/(a*s^2+b*s+c);


polos=pole(g)

step(g)
%%
clear all; close all; clc;
syms s t;


%%%% Parte 1 Rampa pendiente 4
T_s = 4/s^2;
y_0 = 0;

y_s = T_s/(3*s+4)+ 3*y_0/(3*s+4);

y_t = ilaplace(y_s)
pretty(y_t)

y_t1 = subs(y_t,t,1)
y_1 = solve(y_1 == y_t1,y_1)

%%
%%%% Parte 2 Escalon de 4
clc;

T_s = 4/s;
y_0 = 0.448;
y_s = T_s/(3*s+4)+ 3*y_0/(3*s+4);
y_t = ilaplace(y_s)
pretty(y_t)

%%
%%%% Parte 3 Escalon de 2
clc;

T_s = 2/s;
y_0 = 1.01;
y_s = T_s/(3*s+4)+ 3*y_0/(3*s+4);
y_t = ilaplace(y_s)
pretty(y_t)















