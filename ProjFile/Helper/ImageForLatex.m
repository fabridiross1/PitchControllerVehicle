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

path = 'C:\Users\fadir\OneDrive\Desktop\MatlabCC\HalfCar\Results\Autovalori';

% 
% grafici = grafico(StateFeedback_array);
% print(grafici(1),'-dpng','-r600',fullfile(path,['AutovaloriRisposte.png']))
% print(grafici(2),'-dpng','-r600',fullfile(path,['AutovaloriIngressi.png']))
% print('-sHalfCar/SF','-dpng','-r600',fullfile(path,['AutovaloriSchema.png']))
% 
% path = 'C:\Users\fadir\OneDrive\Desktop\MatlabCC\HalfCar\Results\AutovaloriInteg';
% grafici = grafico(StateFeedback_Integ_array);
% print(grafici(1),'-dpng','-r600',fullfile(path,['AutovaloriIntegRisposte.png']))
% print(grafici(2),'-dpng','-r600',fullfile(path,['AutovaloriIntegIngressi.png']))
% print('-sHalfCar/SF+IN','-dpng','-r600',fullfile(path,['AutovaloriIntegSchema.png']))

path = 'C:\Users\fadir\OneDrive\Desktop\MatlabCC\HalfCar\Results\LQI';
grafici = grafico(LQI_array);
print(grafici(1),'-dpng','-r600',fullfile(path,['LQIRisposte.png']))
print(grafici(2),'-dpng','-r600',fullfile(path,['LQIIngressi.png']))
print('-sHalfCar/LQI','-dpng','-r600',fullfile(path,['LQISchema.png']))


