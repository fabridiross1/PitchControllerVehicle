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
KalmanError =  SimOut.KalmanError;
LQGEstimatedState =  SimOut.LQGEstimatedState;
LQGRealState =  SimOut.LQGRealState;

StateFeedback_array = struct2cell(StateFeedback);
StateFeedback_Integ_array= struct2cell(StateFeedback_Integ);
StateFeedback_Integ_Obs_array = struct2cell(StateFeedback_Integ_Obs);
AnelloAperto_array = struct2cell(AnelloAperto);
LQR_array = struct2cell(LQR);
LQI_array = struct2cell(LQI);
KalmanError_array = struct2cell(KalmanError);
LQGEstimatedState_array = struct2cell(LQGEstimatedState);
LQGRealState_array = struct2cell(LQGRealState);

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
f1 = figure(1);
j=1;
for i = [1,2]
    subplot(2,1,j)
    hold on
    switch i
        case 1
            nome = 'phi';
        case 2
            nome = 'phi-{dot}';
        otherwise
            nome  ='';
    end
    plot(StateFeedback_Integ_array{i},'DisplayName','F.I.');
    plot(StateFeedback_Integ_Obs_array{i},'DisplayName','F.I.O')
    plot(LQI_array{i},'DisplayName','LQI');
    plot(LQGEstimatedState_array{i},'DisplayName','LQG');
    
    grid;
    legend;
    ylabel(nome);
    xlabel('Time [s]');
    j = j+1;
end


f2 = figure(2);
j=1;
for i = [3,4]
    subplot(2,1,j)
    hold on
    switch i
        case 3
            nome = 'zc';
        case 4
            nome = 'zc-{dot}';
        otherwise
            nome  ='';
    end
    plot(StateFeedback_Integ_array{i},'DisplayName','F.I.');
    plot(StateFeedback_Integ_Obs_array{i},'DisplayName','F.I.O')
    plot(LQI_array{i},'DisplayName','LQI');
    plot(LQGEstimatedState_array{i},'DisplayName','LQG');
    
    grid;
    legend;
    ylabel(nome);
    xlabel('Time [s]');
    j = j+1;
end

f3 = figure;
k=0;
for i = [9,10]
    k  = k+1;
    switch i
        case 9
            nome = 'u-{Ant}';
        case 10
            nome = 'u-{Pos}';
        otherwise
            nome  ='';
    end
    subplot(2,1,k)
    hold on
    
    plot(StateFeedback_Integ_array{i},'DisplayName','F.I.');
    plot(StateFeedback_Integ_Obs_array{i},'DisplayName','F.I.O')
    plot(LQI_array{i},'DisplayName','LQI');
    plot(LQGEstimatedState_array{i},'DisplayName','LQG');
    grid;
    legend;
    ylabel(nome);
    xlabel('Time [s]');
end

path = 'C:\Users\fadir\OneDrive\Desktop\MatlabCC\HalfCar\Results\Comparazione\Astatici';
print(f1,'-dpng','-r200',fullfile(path,['Stati1.png']))
print(f2,'-dpng','-r200',fullfile(path,['Stati2.png']))
print(f3,'-dpng','-r200',fullfile(path,['Ingressi.png']))
