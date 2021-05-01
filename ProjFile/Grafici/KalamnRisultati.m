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
KalmanError =  SimOut.KalmanError;

KalmanError_array = struct2cell(KalmanError);


g1 = figure;
subplot(2,1,1)
plot(SimOut.zc_real,'DisplayName','Zc [m] reale')
hold on
plot(SimOut.zc_h,'DisplayName','Zc [m] stimato')
title('Zc')
grid
legend
xlabel('Time [s]');
ylabel('');

subplot(2,1,2)
plot(SimOut.zc_dot_rumore,'DisplayName','Zc dot [m/s] reale')
hold on
plot(SimOut.zc_dot_hat,'DisplayName','Zc dot [m/s] stimato')
title('Zc dot')
grid
legend
xlabel('Time [s]');
ylabel('');

path = 'C:\Users\fadir\OneDrive\Desktop\MatlabCC\HalfCar\Results\LQG\Kalman';
print(g1,'-dpng','-r200',fullfile(path,['KalmanZc.png']))



g2 = figure;
subplot(2,1,1)
plot(SimOut.phi_rumore,'DisplayName','Phi [deg] reale')
hold on
plot(SimOut.phi_h,'DisplayName','Phi [deg] stimato')
grid
title('Phi [deg]')
legend
xlabel('Time [s]');
ylabel('');
subplot(2,1,2)
plot(SimOut.phi_dot_rumore,'DisplayName','phi dot [deg/s] reale')
hold on
plot(SimOut.phi_dot_hat,'DisplayName','phi dot [deg/s] stimato')
grid
title('Phi dot [deg/s]')

legend
xlabel('Time [s]');
ylabel('');


path = 'C:\Users\fadir\OneDrive\Desktop\MatlabCC\HalfCar\Results\LQG\Kalman';
print(g2,'-dpng','-r200',fullfile(path,['KalmanPhi.png']))

g3 = figure;
subplot(2,1,1)
xlabel('Time [s]');
ylabel('Errori');

for i=3:1:length(KalmanError_array)
hold on
plot(KalmanError_array{i},'DisplayName',KalmanError_array{i}.Name);
end
plot(KalmanError_array{1},'DisplayName',KalmanError_array{1}.Name);
legend
grid;
subplot(2,1,2)


plot(KalmanError_array{2},'DisplayName',KalmanError_array{2}.Name);
grid;legend;
xlabel('Time [s]');
ylabel('Errori');
path = 'C:\Users\fadir\OneDrive\Desktop\MatlabCC\HalfCar\Results\LQG\Kalman';
print(g3,'-dpng','-r200',fullfile(path,['Errore Kalman.png']))

