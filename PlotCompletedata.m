load('Finaldata.mat');
global title_plot1 title_plot2
global myArray1 myArray2

%%
figA = figure( 'units', 'pixels', 'position', [200 70 1000 600], 'name',title_plot1);
figure(figA);
stairs(myArray1(:,1), myArray1(:,2), 'Linewidth',1.5);
ax = gca;
if Sim_time<30
    ax.XTick = myArray1(1:1:max(size(myArray1),1));
end

if Sim_time>=30 && Sim_time<40
    ax.XTick = myArray1(1:2:max(size(myArray1),1));
end

if Sim_time>=40
    ax.XTick = myArray1(1:5:max(size(myArray1),1));
end
grid minor
datetick('x', 'dd-mm-yyyy MM:SS.FFF', 'keeplimits', 'keepticks')
set(gca, 'XTickLabelRotation', 45)
pmu_unit = 'Power (MW)';
xlabel('timestamp (UTC)'); 
ylabel(pmu_unit);
title(title_plot1);
%set(findall(gca, 'Type', 'Line'),'LineWidth',1);

%%

figB = figure( 'units', 'pixels', 'position', [250 80 1000 600], 'name',title_plot2);
figure(figB);
stairs(myArray2(:,1), myArray2(:,2), 'Linewidth',1.5);
ax = gca;
if Sim_time<30
    ax.XTick = myArray2(1:1:max(size(myArray2),1));
end

if Sim_time>=30 && Sim_time<40
    ax.XTick = myArray2(1:2:max(size(myArray2),1));
end

if Sim_time>=40
    ax.XTick = myArray2(1:5:max(size(myArray2),1));
end
grid minor
datetick('x', 'dd-mm-yyyy MM:SS.FFF', 'keeplimits', 'keepticks')
set(gca, 'XTickLabelRotation', 45)
pmu_unit = 'Power (MW)';
xlabel('timestamp (UTC)'); 
ylabel(pmu_unit);
title(title_plot2);
%set(findall(gca, 'Type', 'Line'),'LineWidth',1);