%%%%%%%%%%%sovling k and lamda of Weibull distri according to mean adn COV
clc;
clear;
v=0.2;
E=70;
sampleSize=1000;
[lamda,k] = ZW_solve_weibull_klamda(E,v)
randomNumbers = wblrnd(lamda, k, sampleSize,1);


