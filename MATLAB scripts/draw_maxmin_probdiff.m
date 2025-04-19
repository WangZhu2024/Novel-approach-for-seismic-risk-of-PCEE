% Data
clear;clc;
load Diff_PCEE3_SetA_normal
load Diff_PCEE3_SetA_weibull

% data = [diffpeak_normal(:,1),diffpeak_weibull(:,1)];
data = [diffpeak_normal(:,2),diffpeak_weibull(:,2)];
% draw
figure('Position',[400 100 600 500])
set(gcf,'Color','w')
bar(data,'BarWidth', 1,'LineWidth',1.5);

% axis title
xlabel('COV');
ylabel('Extreme difference in Probabilities');

% Legend
% legend({'Normal', 'Weibull'}, 'Location', 'northwest');
legend({'Normal', 'Weibull'}, 'Location', 'southwest');

% X tick label
xticklabels({'5%', '10%', '15%','20%', '25%', '30%'});
set(gca,'FontName','Times New Roman','FontSize',20)