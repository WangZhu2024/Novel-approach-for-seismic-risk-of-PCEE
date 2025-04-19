function h = draw_fragility(logmean,logstd,color)
x1 = 0.01:0.01:1;
y1 = logncdf(x1,logmean,logstd);
h = plot(x1,logncdf(x1,logmean,logstd),color,LineWidth=2);
hold on
end
