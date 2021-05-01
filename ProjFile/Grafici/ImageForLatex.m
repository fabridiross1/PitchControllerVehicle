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


path = 'C:\Users\fadir\OneDrive\Desktop\MatlabCC\HalfCar\Results\Autovalori';

grafici = grafico(StateFeedback_array);
print(grafici(1),'-dpng','-r150',fullfile(path,['AutovaloriRisposte.png']))
print(grafici(2),'-dpng','-r150',fullfile(path,['AutovaloriIngressi.png']))
print('-sHalfCar/SF','-dpng','-r200',fullfile(path,['AutovaloriSchema.png']))

path = 'C:\Users\fadir\OneDrive\Desktop\MatlabCC\HalfCar\Results\AutovaloriInteg';
grafici = grafico(StateFeedback_Integ_array);
print(grafici(1),'-dpng','-r200',fullfile(path,['AutovaloriIntegRisposte.png']))
print(grafici(2),'-dpng','-r200',fullfile(path,['AutovaloriIntegIngressi.png']))
print('-sHalfCar/SF+IN','-dpng','-r200',fullfile(path,['AutovaloriIntegSchema.png']))

path = 'C:\Users\fadir\OneDrive\Desktop\MatlabCC\HalfCar\Results\LQI';
grafici = grafico(LQI_array);
print(grafici(1),'-dpng','-r200',fullfile(path,['LQIRisposte.png']))
print(grafici(2),'-dpng','-r200',fullfile(path,['LQIIngressi.png']))
print('-sHalfCar/LQI','-dpng','-r200',fullfile(path,['LQISchema.png']))

path = 'C:\Users\fadir\OneDrive\Desktop\MatlabCC\HalfCar\Results\LQG';
grafici = grafico(LQGRealState_array);
print(grafici(1),'-dpng','-r200',fullfile(path,['LQGRisposte.png']))
print(grafici(2),'-dpng','-r200',fullfile(path,['LQGIngressi.png']))
print('-sHalfCar/LQG','-dpng','-r200',fullfile(path,['LQGSchema.png']))

path = 'C:\Users\fadir\OneDrive\Desktop\MatlabCC\HalfCar\Results\IntegOss';
grafici = grafico(StateFeedback_Integ_Obs_array);
print(grafici(1),'-dpng','-r200',fullfile(path,['SfInObsRisposte.png']))
print(grafici(2),'-dpng','-r200',fullfile(path,['SfInObsIngressi.png']))
print('-sHalfCar/SfInObs','-dpng','-r200',fullfile(path,['SfInObsSchema.png']))

path = 'C:\Users\fadir\OneDrive\Desktop\MatlabCC\HalfCar\Results\AnelloAperto';
grafici = grafico(AnelloAperto_array);
print(grafici(1),'-dpng','-r200',fullfile(path,['AnelloApertoRisposte.png']))
print('-sHalfCar/AnelloAperto','-dpng','-r200',fullfile(path,['AnelloApertoSchema.png']))
