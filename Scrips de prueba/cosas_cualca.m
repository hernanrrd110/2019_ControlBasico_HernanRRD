clear all; close all; clc;

Mp = 15;
zita=(-log(Mp/100))/(sqrt(pi^2+(log(Mp/100))^2))

s = tf ('s')
g = 2/(s*(s+1)^2)

vector_k = linspace(0,50,10000);
figure()
rlocus(g,vector_k)
grid;

gbc1 = feedback(0.18*g,1)
polos_gbc1 = pole(gbc1)
 
T_prueba = 0.4;
figure()
rlocus(gbc1*(T_prueba*s+1))

figure()
kr = 9;
margin(kr*gbc1)

T = 0.5 
gpd = T*s+1;
figure()
margin(kr*gpd*gbc1)

figure()
step(feedback(kr*gbc1,gpd))
