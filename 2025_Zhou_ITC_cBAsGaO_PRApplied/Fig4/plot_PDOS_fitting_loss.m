clear; close all; 
colorred=[255,0,0]/255;colorblue=[3,174,240]/255;orange=[253,199,49]/255;green=[7,133,52]/255;
Fontsize=13;
[x,y]=load_data();
figure(1)
plot(x,y(:,1),'linewidth',1,'Color',colorred)
hold on
plot(x,y(:,3),'-','linewidth',2,'Color',colorred)
xlim([0,10])
ylim([-0.01,0.02]) 
xlabel("Frequency (THz)",'Fontname', 'Times New Roman', 'Fontsize', Fontsize)
ylabel("Normalized density",'Fontname', 'Times New Roman', 'Fontsize', Fontsize)
% set(gcf,'unit','centimeters','position',[10 5 10 8]);
%legend('B-O bonds: dos','B-O bonds:linear','Ga-As bonds: dos','Ga-As bonds:linear')


figure(2)
plot(x,y(:,2),'linewidth',1,'Color',colorred)
hold on
plot(x,y(:,4),'-','linewidth',2,'Color',colorred)
hold on
xlim([0,10])
ylim([-0.01,0.02]) 
xlabel("Frequency (THz)",'Fontname', 'Times New Roman', 'Fontsize', Fontsize)
ylabel("Normalized density",'Fontname', 'Times New Roman', 'Fontsize', Fontsize)
% set(gcf,'unit','centimeters','position',[10 5 10 8]);


function [x,y]=load_data()
data=load('.\Energy_loss.txt');
x=data(:,1);
y=data(:,2:end);
end
