clear;  close all; font_size=10; 
load compute.out; temperature=compute;

% Some parameters from MD
dt = 0.001; % ps
Ns = 1000;  % sample interval
A=4.76009*4.82943; % nm^2
% group
max_z=379.102; % A
min_z= 0; 
z_interface=193;
num_groups = 29;
num_groups_1=fix(num_groups/2);num_groups_2=num_groups_1;
z_range_1 = linspace(min_z, z_interface-6, num_groups_1 + 1);  % 分组的 Z 范围
z_range_2 = linspace(z_interface+6, max_z, num_groups_2 + 1);  % 分组的 Z 范围
z_range = [z_range_1,z_range_2];  % 分组的 Z 范围
z=(z_range(1:end-1)+z_range(2:end))/2;

N_temp = size(temperature, 1);
temp_ave=mean(temperature(end/2+1:end,2:end-2));
temp_difference = temp_ave(1)-temp_ave(end);


% temperature profile
figure;

subplot(1, 2, 1);
z_position=z(2:end-1);%去除fix组
y_temp=mean(temperature(end/2:end,2:end-2));
plot(z_position,y_temp,'ko','linewidth',1);%z_position
hold on
xdata1=z_position(2:13);ydata1=y_temp(2:13);
pn=polyfit(xdata1,ydata1,1);
xdata=12:1:193;
ydata=polyval(pn,xdata);
plot(xdata,ydata,'-r','linewidth',1.5)
hold on
xdata2=z_position(15:end-1);ydata2=y_temp(15:end-1);
pn=polyfit(xdata2,ydata2,1);
xdata=193:1:400;
ydata=polyval(pn,xdata);
plot(xdata,ydata,'-r','linewidth',1.5)
hold on
plot([193 193],[280 320])
xlabel('Z position (A)','fontsize',font_size);
ylabel('T (K)','fontsize',font_size);
set(gca,'fontsize',font_size);
title('(a)');
temp_difference2=14.6;
ylim([270 330])

% energy exchange between the system and the thermostats
subplot(1, 2, 2);
t=dt*(1:N_temp)* Ns/1000; % ns
plot(t,temperature(:,end-1)/1000,'r-','linewidth',2);
hold on;
plot(t,temperature(:,end)/1000,'b-','linewidth',2);
hold on;
xlabel('t (ns)','fontsize',font_size);
ylabel('Heat (keV)','fontsize',font_size);
set(gca,'fontsize',font_size);
legend('source','sink');
title('(b)');
set(gcf,'unit','centimeters','position',[10 5 22 8]);
%% heat flux calculated from the thermostats
Q1=(temperature(end/2,end-1)-temperature(end,end-1))/(N_temp/2)/dt/Ns;%dE/dt:求斜率
Q2=(temperature(end,end)-temperature(end/2,end))/(N_temp/2)/dt/Ns;% unit of E is eV
Q=(Q1+Q2)/2; % eV/ps (1.6*10^-7 J/s)
% classical ballistic conductance
G=(Q*1.6*10^-7)/(A*10^-18)/temp_difference*10^-6 % MW/m^2K

%%利用界面温度降计算界面热导
J_= (Q*1.6*10^-7)/(A*10^-18)*10^-6;% Mw/m^2
G=J_/temp_difference2
ylim([-5 5])
