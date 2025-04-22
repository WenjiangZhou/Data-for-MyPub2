clear; close all;format long
%
% 获取当前文件夹路径
currentFolder = pwd;

% 查找所有job-*文件夹
jobFolders = dir(fullfile(currentFolder, 'job-*'));

% 检查是否找到任何job-*文件夹
if isempty(jobFolders)
    disp('没有找到job-*文件夹');
    return;
end
% 初始化一个cell数组来存储文件内容
fileContents = cell(length(jobFolders), 1);

% 遍历每个job-*文件夹
for i = 1:length(jobFolders)
    % 构建kappa.out文件的完整路径
    kappaFile = fullfile(currentFolder, jobFolders(i).name, 'kappa.out');
    
    % 检查文件是否存在
    if exist(kappaFile, 'file') == 2
        % 读取文件内容
%         try
            % load kappa.out
            data = importdata(kappaFile);
            k_niuz_cumm=running_ave(data(:,3));
            kappa(i,:)=k_niuz_cumm';
            %plot
            t1=(1:size(k_niuz_cumm,1))*0.001;
            plot(t1,k_niuz_cumm(:,1),'LineWidth',1);
            hold on
            
            % 显示读取成功信息
            fprintf('成功读取: %s\n', kappaFile);
            
%         catch ME
%             fprintf('读取文件出错: %s\n错误信息: %s\n', kappaFile, ME.message);
%             fileContents{i} = [];
%         end
    else
        fprintf('文件不存在: %s\n', kappaFile);
        fileContents{i} = [];
    end
end
hold on
plot(t1,mean(kappa,1),'r-','Linewidth',3)

kappa_ave=mean(mean(kappa(:,end/2:end),2))
kappa_std=std2(kappa(:,end/2:end))/length(jobFolders)

xlabel('Time (ns)')
ylabel('\kappa (W/m-K)')
legend('1','2','3','4')
ylim([0 30])
title('kyy_{out}')

function [ k_niux_ave ] = running_ave( k_niux )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
m=length(k_niux);
k_niux_ave=zeros(m,1);

for i=1:m
    k_niux_ave(i)=sum(k_niux(1:i))/i;
end

end
