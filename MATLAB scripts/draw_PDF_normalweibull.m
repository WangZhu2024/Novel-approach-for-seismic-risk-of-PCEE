clear;clc;
LS = 85/4;
candy = {[255,0,255]/256,[0,255,255]/256,[254,194,17]/256,[59,195,113]/256,...
    [128,0,128]/256,[0,0,255]/256};
% COV = 0.30;
figure;
set(gcf, 'Color','w')
count = 0;
for COV = 0.05:0.05:0.30
count = count + 1;
x = 0:0.01:50;  % x range
% Normal distr
normal_pdf = normpdf(x, LS, LS*COV);  % PDF of normal distri

% Weibull distr
[lambda, k] = ZW_solve_weibull_klamda(LS,COV);
weibull_pdf = wblpdf(x, lambda, k);  % PDF of Weibull distri

% Plot Normal and Weibull distri curves

plot(x, normal_pdf, '-', 'LineWidth', 2, 'Color',candy{count});  % Normal distri，Blue
hold on;
plot(x, weibull_pdf, '--', 'LineWidth', 2,'Color',candy{count});  % Normal distri，Red dotted
hold on
end

xlabel('LS (MPa)')
ylabel('Probability density')
set(gca, 'FontName', 'Times New Roman', 'FontSize', 18)
grid on
set(gca, 'XMinorGrid', 'on'); % Minor grid
legend({'Normal,5%','Weibull,5%', ...
    'Normal,10%','Weibull,10%', ...
    'Normal,15%','Weibull,15%', ...
    'Normal,20%','Weibull,20%', ...
    'Normal,25%','Weibull,25%', ...
    'Normal,30%','Weibull,30%'},'FontSize',14)