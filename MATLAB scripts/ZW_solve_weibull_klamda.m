function [lamda,k] = ZW_solve_weibull_klamda(E,COV)
syms x
eqn=sqrt(gamma(1+2/x)-gamma(1+1/x)*gamma(1+1/x))/gamma(1+1/x)==COV;
digits(7);
k=vpasolve(eqn,x,[0 1000]);
lamda=E/gamma(1+1/k);
k = double(k);
lamda = double(lamda);