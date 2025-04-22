clear;  close all; font_size=10; 

[t_nep, jp_nep, etol_nep] = gpumd_heatflux();
plot(t_nep,jp_nep,'-','linewidth',3)
xlabel('Time (ns)')
ylabel('Accumulated heat (keV)')
% xlim([0, 0.1])
% ylim([0, 0.1])

title("(a) GPUMD-NEP")
hold on
plot(t_nep,etol_nep,'-','linewidth',3)
legend('from atoms','from thermostats')
xticks([0  0.5 1.0 1.5 2.0])
ylim([0 2.5])

function [t,accum_jpy, Etol]=gpumd_heatflux()
dt = 0.001; % ps
Ns = 1000;  % sample interval
Index_begin = 500;

compute=load('./compute.out'); 
%如果计算温度的话，最后两列分别是source和sink的热流
Ein=compute(Index_begin:end,end-1);
Eout=compute(Index_begin:end,end);
Etol=(Eout-Ein)/2/1000;%Kev
t = dt * (1:length(Etol)) * Ns / 1000; %#unit in ns
Etol=Etol-Etol(1);%% 热御计算

jp=compute(Index_begin:end,11:end-2);%前13列为输出温度
jpy = jp(:, 26); % in units of eV^{3/2} amu^{-1/2}，注意1和12组为热浴组
% jp的1-13为jpx，skip；
% 14为一项不知名列，15为热浴（即是组1）
% 26列为组12，也是热浴

% python语句中，是15：25，因为从0开始索引，并且不包含25
BLOCK_LENGTH = 80;%单位是A
jpy = jpy / BLOCK_LENGTH * 98207.9; % #98207.9将ev^{3/2} amu^{-1/2} A^{-1}转换为eV/ns
jpy_ave = mean(jpy, 2);
accum_jpy = cumsum(jpy_ave) * 0.001 / 1000; %#in units of keV
% 原子计算
end
