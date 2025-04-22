clear; close all; 
colorred=[255,0,0]/255;colorblue=[3,174,240]/255;colorblue2=[21,56,148]/255;Fontsize=13;

%%
BAs=load ('total_dos_BAs.dat');
hBAs=plot(BAs(:,1),BAs(:,2)/6,'-',...
'linewidth',2,'color',colorred,'MarkerSize',6,'MarkerFaceColor',colorred);
hold on
% area(BAs(:,1),BAs(:,2)/6, 'FaceColor', colorred, 'FaceAlpha', 0.2, 'EdgeColor', 'none');
% hold on;



%%
GaO=load ('total_dos_GaO.dat');
hGaO=plot(GaO(:,1),GaO(:,2)/30,'-',...
'linewidth',2,'color',colorblue,'MarkerSize',6,'MarkerFaceColor',colorblue);
hold on
% area(GaO(:,1),GaO(:,2)/30, 'FaceColor', colorblue, 'FaceAlpha', 0.1, 'EdgeColor', 'none');
% hold on;

%%
diamond=load ('total_dos_diamond.dat');
hdiamond=plot(diamond(:,1),diamond(:,2)/6,'-',...
'linewidth',2,'color',colorblue2,'MarkerSize',6,'MarkerFaceColor',colorblue2);
hold on
% area(diamond(:,1),diamond(:,2)/6, 'FaceColor', colorblue2, 'FaceAlpha', 0.2, 'EdgeColor', 'none');
% hold on;

xlabel("Phonon frequency (THz)",'Fontname', 'Times New Roman', 'Fontsize', Fontsize)
ylabel("Normalized phonon DOS",'Fontname', 'Times New Roman', 'Fontsize', Fontsize)
legend([hBAs,hGaO,hdiamond],'cBAs','b-Ga2O3','Diamond')
xlim([0 40])
ylim([0 0.4])
axis square;
