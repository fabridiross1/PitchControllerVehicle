function array = grafico(array)
j= 1;
close all;
a = figure(1);

j=1;
for i = [1,3]
    subplot(2,2,j);
    j=j+1;
    hold on
    plot(array{i},'DisplayName',array{i}.Name);
    grid;
    xlabel('Time [s]');
    ylabel(array{i}.Name);
end

for i = [2,4]
    subplot(2,2,j);
    j=j+1;
       grid;
    hold on
    plot(array{i},'DisplayName',array{i}.Name);
    
    xlabel('Time [s]');
        ylabel(array{i}.Name);

end
try
b = figure(2);
k = 1;
for i = [9,10]
    subplot(2,1,k);
    k=k+1;
       grid;
    hold on
    plot(array{i},'DisplayName',array{i}.Name);
    
    xlabel('Time [s]');
        ylabel(array{i}.Name);

end
catch
end

array = [a,b];

end

