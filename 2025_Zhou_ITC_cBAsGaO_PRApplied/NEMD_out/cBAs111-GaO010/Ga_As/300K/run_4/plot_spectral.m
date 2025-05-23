clear; %close all; 
font_size = 15; load shc.out; 

% set up a few parameters from your GPUMD inputs
Nc=250; % Number of correlation steps
Nw=1000; % Number of frequency points
deltaT=11.4; % Temperature difference (K)
vol=47.1142*48.0523*12; % volume considered (A^3)

% calculate the quantities to be plotted
[K,G]=get_K_and_G('shc.out',Nc,Nw,deltaT,vol);

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
trapz(G(:,1), G(:,2)*1000)
set(gca,'fontsize',font_size);
xlabel('\omega/2\pi (THz)','fontsize',font_size);
ylabel('G(\omega) (MW/m^2/K/THz)','fontsize',font_size);
xlim([0,53]);
set(gca,'ticklength',get(gca,'ticklength')*2);
title('(b)');

