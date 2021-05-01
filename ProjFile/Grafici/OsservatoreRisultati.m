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
LaumbErro = struct2cell(SimOut.ErroreLuenberger);



g1 = figure;
xlabel('Time [s]');
ylabel('Errori');
subplot(2,1,1)
for i=5:1:length(LaumbErro)-2
    hold on
    plot(LaumbErro{i},'DisplayName',LaumbErro{i}.Name);
end
legend;
grid;

subplot(2,1,2)
for i=length(LaumbErro)-2:1:length(LaumbErro)
    hold on
    plot(LaumbErro{i},'DisplayName',LaumbErro{i}.Name);
end
legend;
grid;


g2=figure;
subplot(2,1,1)
hold on;
plot(LaumbErro{1},'DisplayName',LaumbErro{1}.Name);
plot(LaumbErro{2},'DisplayName',LaumbErro{2}.Name);
legend;
grid;

subplot(2,1,2)
hold on;
plot(LaumbErro{3},'DisplayName',LaumbErro{3}.Name);
plot(LaumbErro{4},'DisplayName',LaumbErro{4}.Name);
legend;
grid;

path = 'C:\Users\fadir\OneDrive\Desktop\MatlabCC\HalfCar\Results\IntegOss';
print(g1,'-dpng','-r200',fullfile(path,['ErroreLaumberg1.png']))
print(g2,'-dpng','-r200',fullfile(path,['ErroreLaumberg2.png']))


