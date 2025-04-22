clear; close all;format long
%
% ��ȡ��ǰ�ļ���·��
currentFolder = pwd;

% ��������job-*�ļ���
jobFolders = dir(fullfile(currentFolder, 'job-*'));

% ����Ƿ��ҵ��κ�job-*�ļ���
if isempty(jobFolders)
    disp('û���ҵ�job-*�ļ���');
    return;
end
% ��ʼ��һ��cell�������洢�ļ�����
fileContents = cell(length(jobFolders), 1);

% ����ÿ��job-*�ļ���
for i = 1:length(jobFolders)
    % ����kappa.out�ļ�������·��
    kappaFile = fullfile(currentFolder, jobFolders(i).name, 'kappa.out');
    
    % ����ļ��Ƿ����
    if exist(kappaFile, 'file') == 2
        % ��ȡ�ļ�����
%         try
            % load kappa.out
            data = importdata(kappaFile);
            k_niuz_cumm=running_ave(data(:,3));
            kappa(i,:)=k_niuz_cumm';
            %plot
            t1=(1:size(k_niuz_cumm,1))*0.001;
            plot(t1,k_niuz_cumm(:,1),'LineWidth',1);
            hold on
            
            % ��ʾ��ȡ�ɹ���Ϣ
            fprintf('�ɹ���ȡ: %s\n', kappaFile);
            
%         catch ME
%             fprintf('��ȡ�ļ�����: %s\n������Ϣ: %s\n', kappaFile, ME.message);
%             fileContents{i} = [];
%         end
    else
        fprintf('�ļ�������: %s\n', kappaFile);
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
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
m=length(k_niux);
k_niux_ave=zeros(m,1);

for i=1:m
    k_niux_ave(i)=sum(k_niux(1:i))/i;
end

end
