%% Ejemplo 1

clc;
Mp = 10;
ts = 1;
zita=(-log(Mp/100))/(sqrt(pi^2+(log(Mp/100))^2));
wn = 4/(zita*ts);
wd = wn*sqrt(1-zita^2);
p1 = -zita*wn + wd*1i;
p2 = -zita*wn + wd*1i;

s = tf('s');

Gp = 1/(s*(s+5)*(s+8));
Gr = 0.2*s + 1;
rlocus(Gp*Gr)

K = 229;
Gbc = feedback(Gr*Gp*K,1);
step (Gbc);

pole(Gbc)
zero(Gbc)

%% Ejemplo 2
clear all; close all;
clc;

Mp = 4;
ts = 1;
zita=(-log(Mp/100))/(sqrt(pi^2+log(Mp/100)^2));
wn = 4/(zita*ts);
wd = wn*sqrt(1-zita^2);
p1 = -zita*wn + wd*1i
p2 = -zita*wn + wd*1i


s = tf('s');

Gp = 0.5/((s+5)*(s+1));
Gr = 1/13.2*s + 1;
rlocus(Gp*Gr)
[K,p] = rlocfind(Gp*Gr,[-4+3.9i])

Gbc = feedback(40*Gr*Gp,1);
figure();
step (Gbc);

zero(Gbc)

%% Ejemplo 3
clear all; close all;
clc;

ts = 2.5;
zita = 0.5;
wn = 4/(zita*ts);
wd = wn*sqrt(1-zita^2);
p1 = -zita*wn + wd*1i
p2 = -zita*wn + wd*1i


s = tf('s');

Gp = 1/(s^2+3.6*s+9);
pole(Gp)

%%
Gr = 1/13.2*s + 1;
rlocus(Gp*Gr)
[K,p] = rlocfind(Gp*Gr,[-4+3.9i])

Gbc = feedback(40*Gr*Gp,1);
figure();
step (Gbc);

zero(Gbc)