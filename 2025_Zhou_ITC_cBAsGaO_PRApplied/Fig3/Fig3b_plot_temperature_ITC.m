clear; close all; 
colorred=[255,0,0]/255;colorblue=[3,174,240]/255;orange=[253,199,49]/255;green=[7,133,52]/255;Fontsize=13;

%% BAs100-GaO010:B-O oriention
[Temperature,ave,error]=BAs100_GaO010_B_O();
h_BAs100_GaO010_BO = errorbar(Temperature,ave,error,'s',...
'linewidth',1,'color',colorblue,'MarkerSize',6);
hold on
plot(Temperature,ave,'linewidth',1,'color',colorblue)
hold on
[Temperature,ave,error]=BAs100_GaO010_B_O_quantum();
h_BAs100_GaO010_BO = errorbar(Temperature,ave,error,'s',...
'linewidth',1,'color',colorblue,'MarkerSize',6);
hold on
plot(Temperature,ave,'-','linewidth',1,'color',colorblue)
hold on

% Ga-As oriention
[Temperature,ave,error]=BAs100_GaO010_Ga_As();
h_BAs100_GaO010_GaAs = errorbar(Temperature,ave,error,'d',...
'linewidth',1,'color',green,'MarkerSize',6,'MarkerFaceColor',green);
hold on
plot(Temperature,ave,'linewidth',1,'color',green)
hold on
[Temperature,ave,error]=BAs100_GaO010_Ga_As_quantum();
h_BAs100_GaO010_GaAs = errorbar(Temperature,ave,error,'d',...
'linewidth',1,'color',green,'MarkerSize',6,'MarkerFaceColor',green);
hold on
plot(Temperature,ave,'-','linewidth',1,'color',green)
hold on


%% 111-010
[Temperature1,ave1,error1]=BAs111_GaO010_Ga_As();
h_BAs111_GaO010_GaAs = errorbar(Temperature1,ave1,error1,'o',...
    'linewidth',1,'color',orange,'MarkerSize',6,'MarkerFaceColor',orange);
hold on
plot(Temperature1,ave1,'linewidth',1,'color',orange)
hold on
[Temperature1,ave1,error1]=BAs111_GaO010_Ga_As_quantum();
h_BAs111_GaO010_GaAs = errorbar(Temperature1,ave1,error1,'o',...
    'linewidth',1,'color',orange,'MarkerSize',6,'MarkerFaceColor',orange);
hold on
plot(Temperature1,ave1,'-','linewidth',1,'color',orange)
hold on

[Temperature,ave,error]=BAs111_GaO010_B_O();
h_BAs111_GaO010_BO = errorbar(Temperature,ave,error,'o',...
    'linewidth',1,'color',colorred,'MarkerSize',6);
hold on
plot(Temperature,ave,'linewidth',1,'color',colorred)
hold on
[Temperature,ave,error]=BAs111_GaO010_B_O_quantum();
h_BAs111_GaO010_BO = errorbar(Temperature,ave,error,'o',...
    'linewidth',1,'color',colorred,'MarkerSize',6);
hold on
plot(Temperature,ave,'-','linewidth',1,'color',colorred)
hold on

xlim([100,400])
ylim([150,1050]) 
xlabel("Temperature (K)",'Fontname', 'Times New Roman', 'Fontsize', Fontsize)
ylabel("Interfacial thermal conductance G (MW/m2-K)",'Fontname', 'Times New Roman', 'Fontsize', Fontsize)
% legend([h_BAs100_GaO010_GaAs,h_BAs100_GaO010_BO,h_BAs111_GaO010_GaAs,h_BAs111_GaO010_BO],...
%     'cBAs(100)/b-Ga2O3 Ga-As','cBAs(100)/b-Ga2O3 B-O','cBAs(111)/b-Ga2O3 Ga-As','cBAs(111)/b-Ga2O3 B-O','location','NorthWest')












%%
function [Temperature,ave,error]=BAs100_GaO010_B_O()
data=[100.00 	451.23 	443.0415 	472.5071 
200.00 	513.83 	478.1833 	510.1589
300.00 	519.29 	516.49 	527.95 
400.00 	595.04 	510.3300 	532.5041];
[m,n]=size(data);
Temperature=data(:,1);
ave=mean(data(:,2:4),2);
for i=1:m
    error(i,1)=std(data(i,2:4))/sqrt(n-1);
end
end
function [Temperature,ave,error]=BAs100_GaO010_B_O_quantum()
data=[100	258.04 	254.37 	269.90 
200	427.78 	398.43 	423.63 
300	472.89 	469.98 	480.26 
400	540.62 	464.63 	486.92 ];
[m,n]=size(data);
Temperature=data(:,1);
ave=mean(data(:,2:4),2);
for i=1:m
    error(i,1)=std(data(i,2:4))/sqrt(n-1);
end
end

function [Temperature,ave,error]=BAs100_GaO010_Ga_As()
data=[100	348.10 	350.37 	346.76 
200	364.93 	367.59 	358.66 
300	394.21 	385.40 	386.96 
400	475.02 	418.80 	461.11 ];
[m,n]=size(data);
Temperature=data(:,1);
ave=mean(data(:,2:4),2);
for i=1:m
    error(i,1)=std(data(i,2:4))/sqrt(n-1);
end
end

function [Temperature,ave,error]=BAs100_GaO010_Ga_As_quantum()
data=[100	198.68 	199.94 	197.57 
200	302.08 	304.10 	297.22 
300	358.55 	351.05 	352.63 
400	448.53 	395.66 	435.02 ];
[m,n]=size(data);
Temperature=data(:,1);
ave=mean(data(:,2:4),2);
for i=1:m
    error(i,1)=std(data(i,2:4))/sqrt(n-1);
end
end















%%
function [Temperature,ave,error]=BAs111_GaO010_Ga_As()
data=[100.00 	473.40 	488.0168 	480.4812
200.00 	609.84 	618.2910 	602.3328 
300.00 	 764.4816 	796.5082 	685.5841
400.00 	772.91 	799.8904 	727.9534 ];%% 
[m,n]=size(data);
Temperature=data(:,1);
ave=mean(data(:,2:4),2);
for i=1:m
    error(i,1)=std(data(i,2:4))/sqrt(n-1);
end
end
function [Temperature,ave,error]=BAs111_GaO010_Ga_As_quantum()
data=[100	268.54 	275.24 	270.96 
200	504.21 	510.37 	497.55 
300	695.61 	722.90 	623.97 
400	733.15 	756.47 	689.80 ];
[m,n]=size(data);
Temperature=data(:,1);
ave=mean(data(:,2:4),2);
for i=1:m
    error(i,1)=std(data(i,2:4))/sqrt(n-1);
end
end

function [Temperature,ave,error]=BAs111_GaO010_B_O()
data=[100 620.4599 628.1357 612.5215
    200 751.0323 756.5475 751.1850
    300 798.3958 780.1868 892.3448
    400 900.4218 811.5890 881.3608];
[m,n]=size(data);
Temperature=data(:,1);
ave=mean(data(:,2:4),2);
for i=1:m
    error(i,1)=std(data(i,2:4))/sqrt(n-1);
end
end
function [Temperature,ave,error]=BAs111_GaO010_B_O_quantum()
data=[100	357.36 	362.63 	352.83 
200	626.58 	630.99 	625.11 
300	728.53 	711.63 	814.90 
400	853.77 	769.01 	834.03 ];
[m,n]=size(data);
Temperature=data(:,1);
ave=mean(data(:,2:4),2);
for i=1:m
    error(i,1)=std(data(i,2:4))/sqrt(n-1);
end
end