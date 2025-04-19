clear;clc;
LineColor = {[0.07,0.62,1.00],[1,0,0],[0,1,0]};
FillColor = {[0.30,0.75,0.93],[0.85,0.33,0.33],[0.55,0.79,0.05]};
% Parameters
% mu = 0;       % mean
% sigma = 1.2;    % std
figure('Position', [100, 100, 900, 300]); % [left, bottom, width, height]
set(gcf,'Color','w')
ax = gca;  
ax.YAxis(1).Color = [1,1, 1];  

% set(gca, 'FontSize', 24, 'FontName', 'Times New Roman');
% set(gca, 'xticklabels', {'0', '0.1', '0.2', '0.3', '0.4', '0.5', '0.6', '0.7','0.8', '0.9', '1.0', ''}, 'FontSize', 14, 'FontName', 'Times New Roman', 'FontWeight', 'bold');

% yyaxis left;
for kk = 6:6
num = kk;
PGA = 0.1*num;
mu = [3,3,3]*PGA+num+5;
sigma = [1.4,1.4,1.4];    % std
LS=[12,14,16];

% figure()
% mu = [3,1.5,-1]
prob_i =0;
for i =1:3
% generate data
low = max(0,mu(i) - 3 * sigma(i));
x = linspace(low, mu(i) + 3 * sigma(i), 1000);          % x range：miu +/- 4 * std
pdf = normpdf(x, mu(i), sigma(i))*1.2+PGA*10;           % Normal distri PDF
prob_tem = 1-normcdf(LS(i), mu(i), sigma(i));
prob_i = prob_i + 1-normcdf(LS(i), mu(i), sigma(i));


% Plot PDF curves
plot(x,pdf,  '-', 'LineWidth', 2,'Color','k');          
hold on;

% Fill right part
% yyaxis left;
x_fill = x(x >= LS(i));                           % x >= mean
pdf_fill = pdf(x >= LS(i));                       % corresponding y value
% fill([pdf_fill, zeros(size(pdf_fill))+PGA*10],[x_fill, fliplr(x_fill)], ...
%       'r', 'FaceAlpha', 0.5, 'EdgeColor', 'none'); % filled area

fill([x_fill, fliplr(x_fill)], [pdf_fill, zeros(size(pdf_fill))+PGA*10], ...
      FillColor{i}, 'FaceAlpha', 0.5, 'EdgeColor', 'none'); % filled area

hold on
end
all_prob(1,kk) = prob_i/3;
end

% plot([0,11],[LS(1),LS(1)],'r','LineWidth',1.5)
% plot([0,11],[LS(2),LS(2)],'r--','LineWidth',1.5)
% plot([0,11],[LS(3),LS(3)],'r','LineWidth',1.5)
% 
% xlim([0,11])
ylim([5.9,6.5])
yticks([6])
yticklabels('PGA\it_i')
% xlabel('x');
% ylabel('Probability Density');
% title('Normal Distribution PDF with Filled Region');
% legend('PDF', 'Mean Right Side', 'Location', 'Best');
% grid on;
% hold off;
% ylabel('Seismic response')
% 
% 
% yyaxis right;
% ax.YAxis(2).Color = [0.07,0.62, 1]; 
% yticks([0, 6,12,18,24,30]);  
% yticklabels({'0', '0.2', '0.4', '0.6', '0.8', '1.0'});
% [miu,sig] = ZW_fragility(0.1:0.1:1,all_prob);
% color = '[0.07,0.62, 1]';
% plot(1:1:10,all_prob*30,'*','Color', color,'MarkerSize',10);
% hold on
% yyaxis right;
% x=0.01:0.01:1;
% y1=logncdf(x,miu,sig);
% plot(x*10,y1*30,'Color', color, LineWidth=2);
% xticks([0, 1,2,3,4,5,6,7,8,9,10,12]); 
% xticklabels({'0', '0.1', '0.2', '0.3', '0.4', '0.5', '0.6', '0.7','0.8', '0.9', '1.0', ''});
set(gca, 'FontSize', 18, 'FontName', 'Times New Roman');
xlabel('Seismic response')
ylabel('Probability density')
