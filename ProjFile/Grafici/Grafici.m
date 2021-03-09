set(0,'DefaultLineLineWidth',1.5);
set(0,'DefaultlineMarkerSize',2);
set(0,'DefaultlineMarkerFace','r');
set(0, 'DefaultAxesFontSize', 12);
set(0, 'DefaultTextFontSize', 12);
set(0,'DefaultAxesFontName','arial');set(0,'DefaultTextFontName','arial');
spessore = 1.5;
clear;close all;
set(0,'DefaultFigureColor','w','DefaultAxesColor','w','DefaultAxesXColor','k','DefaultAxesYColor','k','DefaultAxesZColor','k','DefaultTextColor','k')


warning('off','all');
options = simset('SrcWorkspace','current');
run('main');
options.ReturnWorkspaceOutputs = 'on';
SimOut = sim('HalfCar',[],options);

StateFeedback = SimOut.StateFeedback;
StateFeedback_Integ = SimOut.StateFeedback_Integ;
StateFeedback_Integ_Obs = SimOut.StateFeedback_Integ_Obs;
AnelloAperto = SimOut.AnelloAperto;
LQR = SimOut.LQR;
LQI = SimOut.LQI;

StateFeedback_array = struct2cell(StateFeedback);
StateFeedback_Integ_array= struct2cell(StateFeedback_Integ);
StateFeedback_Integ_Obs_array = struct2cell(StateFeedback_Integ_Obs);
AnelloAperto_array = struct2cell(AnelloAperto);
LQR_array = struct2cell(LQR);
LQI_array = struct2cell(LQI);

j=1;
%% Senza Integratori
% for i = 1:1:(length(StateFeedback_Integ_Obs_array)-2)
%     figure(j);
%     j = j+1;
%     hold on
%     
%     if (i<9)
%         plot(AnelloAperto_array{i},'DisplayName',AnelloAperto_array{i}.Name);
%     end
%     plot(StateFeedback_array{i},'DisplayName',StateFeedback_array{i}.Name);
%     plot(LQR_array{i},'DisplayName',LQR_array{i}.Name);
%     
%     grid;
%     legend;
%     
%     xlabel('Time [s]');
%     
% end
% 
% for i = (length(StateFeedback_Integ_Obs_array)-1):1:(length(StateFeedback_Integ_Obs_array))
%     k  = k+1;
%     subplot(2,1,k)
%     hold on
%     
%     if (i<9)
%         plot(AnelloAperto_array{i},'DisplayName',AnelloAperto_array{i}.Name);
%     end
%     plot(StateFeedback_array{i},'DisplayName',StateFeedback_array{i}.Name);
%     plot(LQR_array{i},'DisplayName',LQR_array{i}.Name);
%     grid;
%     legend;
%     xlabel('Time [s]');
% end

%% Con integratori
for i = 1:1:(length(StateFeedback_Integ_Obs_array)-2)
    figure(j);
    j = j+1;
    hold on
    plot(StateFeedback_Integ_array{i},'DisplayName',StateFeedback_Integ_array{i}.Name);
    plot(StateFeedback_Integ_Obs_array{i},'DisplayName',StateFeedback_Integ_Obs_array{i}.Name);
    plot(LQI_array{i},'DisplayName',LQI_array{i}.Name);
    grid;
    legend;
    xlabel('Time [s]');
end

figure(j+1);
k=0;
for i = (length(StateFeedback_Integ_Obs_array)-1):1:(length(StateFeedback_Integ_Obs_array))
    k  = k+1;
    subplot(2,1,k)
    hold on
    plot(StateFeedback_Integ_Obs_array{i},'DisplayName',StateFeedback_Integ_Obs_array{i}.Name);
    grid;
    legend;
    plot(StateFeedback_Integ_array{i},'DisplayName',StateFeedback_Integ_array{i}.Name);
    plot(LQI_array{i},'DisplayName',LQI_array{i}.Name);
    
    xlabel('Time [s]');
end