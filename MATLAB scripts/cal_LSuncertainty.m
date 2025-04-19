clear;clc;
% candy = {[255,0,255]/256,[128,0,128]/256,[0,255,255]/256,[254,194,17]/256,[59,195,113]/256,...
    % [102,102,153]/256,[0,0,255]/256};
% candy = {[255,0,255]/256,[102,102,153]/256,[0,255,255]/256,[254,194,17]/256,[59,195,113]/256,...
%     [128,0,128]/256,[0,0,255]/256};
candy = {'k',[255,0,255]/256,[0,255,255]/256,[254,194,17]/256,[59,195,113]/256,...
    [128,0,128]/256,[0,0,255]/256};
load Hazard_Amat_0.mat
model_name = 'PCEE3';
wave_set = 'SetA';
LS=85/4;
sampleSize = 100000;

name = ['Std_Amat',model_name,'_',wave_set,'.txt'];
outname = ['Frarisk_',model_name,'_',wave_set,'_normal.mat'];
matrix = load(name);
sorted_matrix = sortrows(matrix, 1);

figure('Position',[400 100 600 600])
set(gcf,'Color','w')
count = 0;
for COV =0:0.05:0.3
    count = count +1;
    if COV==0
        [PGA,Prob] = ZW_fromagresponse_toProb2(sorted_matrix,LS);
        Prob_final = Prob';
    else
        %%%Weibull
        % [lambda,k] = ZW_solve_weibull_klamda(LS,COV);
        % randomNumbers = wblrnd(lambda, k, sampleSize,1);
        
        %%%Normal
        randomNumbers = normrnd(LS, LS*COV, sampleSize, 1);
        
        for i=1:sampleSize
            [PGA,Prob] = ZW_fromagresponse_toProb2(sorted_matrix,randomNumbers(i));
            Prob_all(i,1:5) = Prob'; 
        end
        Prob_final = mean(Prob_all);
    end

[miu,sigma] = ZW_fragility(PGA, Prob_final);
risk = ZW_risk_Integration(Hazard_Amat_0,miu,sigma);
% draw_fragility(miu,sigma,candy{count});
x1 = 0.01:0.01:1;
y1 = logncdf(x1,miu,sigma);
h_total(count) = plot(x1,logncdf(x1,miu,sigma),'Color',candy{count},'LineWidth',1.5);
hold on
All_info(count,1:5) = [COV,miu,sigma,risk,1/risk];
end

save(outname,'All_info')




%%%%
lgd = legend([h_total(1),h_total(2),h_total(3),h_total(4),h_total(5),h_total(6),h_total(7)], ...
    {'COV=0%','COV=5%','COV=10%','COV=15%','COV=20%','COV=25%','COV=30%'},Location='southeast');
set(lgd, 'FontSize', 18,'FontName', 'Times New Roman'); 
xlim([0,1])
ylim([0,1])
xticks(0:0.2:1)
yticks(0:0.2:1)
xticklabels(0:0.2:1)
yticklabels(0:0.2:1)
xlabel('PGA (g)','FontSize',24)
ylabel('Probability of exceedance','FontSize',24)
set(gca,'FontName','Times New Roman','FontSize',24)
grid on
set(gca, 'XMinorGrid', 'on');
set(gca, 'YMinorGrid', 'on'); 
% set(gca, 'XMinorTick', 'on');


ax = gca;
ax.XAxis.MinorTickValues = [0.1,0.3,0.5,0.7,0.9]; 
ax.YAxis.MinorTickValues = [0.1,0.3,0.5,0.7,0.9];
set(gca, 'MinorGridLineStyle', '-');