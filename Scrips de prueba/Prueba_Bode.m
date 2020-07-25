%%
clear all; close all; clc;
s = tf('s');
g = 10*(s+0.1)/(s*(s+0.5)*(s+1));
w = logspace(-2,2,1000);
bode(g,w);
grid;

%%
clear all; close all; clc;
s = tf('s');
g = (s+2)/(s*(s+5)*(s^2+2*s+2));
w = logspace(-2,2,1000);
bode(g,w);
grid;

