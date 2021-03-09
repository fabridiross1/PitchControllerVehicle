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
j = 1;
b = figure;
for i= [1,3]
    array = StateFeedback_Integ_array
    subplot(2,1,j);
    grid;
    hold on
    plot(array{i},'DisplayName',array{i}.Name);
    xlabel('Time [s]');
    %ylabel(array{i}.Name);
    
    
    array = StateFeedback_array
    subplot(2,1,j);
    grid;
    hold on
    plot(array{i},'DisplayName',array{i}.Name);
    xlabel('Time [s]');
    %ylabel(array{i}.Name);
    grid
    j = j+1;
    legend
    
end
k = 1;
a = figure;
for i = [9,10]
    subplot(2,1,k);
    hold on
    array = StateFeedback_Integ_array
    plot(array{i},'DisplayName',array{i}.Name);
    xlabel('Time [s]');
    
    array = StateFeedback_array
    plot(array{i},'DisplayName',array{i}.Name);
    
    xlabel('Time [s]');
    
    k=k+1;
    legend;
    grid;
    
end

path = 'C:\Users\fadir\OneDrive\Desktop\MatlabCC\HalfCar\Results\AutovaloriInteg';
print(a,'-dpng','-r600',fullfile(path,['ComparazioneUscite.png']))
print(b,'-dpng','-r600',fullfile(path,['ComparazioneIngressi.png']))

