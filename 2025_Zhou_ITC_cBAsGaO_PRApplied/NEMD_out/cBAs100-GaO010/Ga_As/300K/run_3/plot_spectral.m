clear; %close all; 
font_size = 15; load ./shc.out; 

% set up a few parameters from your GPUMD inputs
Nc=250; % Number of correlation steps
Nw=1000; % Number of frequency points
deltaT=18.914; % Temperature difference (K)
vol=47.6009*48.2943*12; % volume considered (A^3)

% calculate the quantities to be plotted
[K,G]=get_K_and_G('./shc.out',Nc,Nw,deltaT,vol);

% plot results
figure;
subplot(1,2,1);
plot(K(:,1),K(:,2),'b-','linewidth',2);
set(gca,'fontsize', font_size);
xlabel('Correlation time (ps)','fontsize', font_size);
ylabel('K (GW/m^2)','fontsize', font_size);
title('(a)');

subplot(1,2,2);
plot(G(:,1), G(:,2)*1000, 'b-','linewidth',1.5);
set(gca,'fontsize',font_size);
xlabel('\omega/2\pi (THz)','fontsize',font_size);
ylabel('G(\omega) (MW/m^2/K/THz)','fontsize',font_size);
xlim([0,25]);
set(gca,'ticklength',get(gca,'ticklength')*2);
title('(b)');
trapz(G(:,1),G(:,2)*1000)
% Quantum correction
omega=G(:,1);hbar=1.05457266*10^-34;kB=1.38*10^-23;T=300;
x=hbar*2*pi*omega*10^(12)/kB/T;
factor=x.^2.*exp(x)./(exp(x)-1).^2;
G_quantum=G(:,2).*factor;
hold on
plot(G(:,1), G_quantum*1000,'--r')
trapz(G(:,1),G_quantum*1000)