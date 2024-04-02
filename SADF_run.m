%% Main Program
%  load('TEMPSADF.mat');
% Ip_address_primary = '';             
%% Make clean workspace
clc
clear all
instrreset 
feature accel on 
format short
warning off

%% Enable MATLAB process in real-time priority 
pid=feature('getpid');
[~,~] = system(sprintf('wmic process where processid="%d" CALL setpriority 256',pid));

%% Welcome message
disp('#############################################################################################################');
disp(' Welcome to MATLAB supported Synchro-measurement (IEEE C37.118 std.) Application Tool');
disp(' Version: 2.0');
disp('#############################################################################################################');
disp('_____________________________________________________________________________________________________________');
disp(' ');

%% PMU/PDC connection initialisation
global SADF DATA CFG_1 CFG_2_3 HDR CMD demo
global title_plot1 title_plot2 title_plot3 title_plot4

% Simulation and PMU/PDC connection setting (edit before use)
 load('TEMPSADF.mat');
 varCreate();

% Variables initialisation
VAR_initialisation();

% ICT Connection initialisation
ICT_initialisation();

%% Start parsing the IEEE C37.118 std messages
global fig1
%%tempAct_1();
fig1 = figure('windowstyle', 'normal', 'units', 'normalized', 'name','Online Monitoring : derivation of voltage');
  
while ( strcmpi(SADF.Connection_primary.status, 'open') == 1 ) 
%      strcmpi(SADF.Connection_primary.status, 'open') == 1            toc(SADF.sim_start) < SADF.sim_time
    IEEE_C37_118_2_parser();
 end

%close(fig1);

%% ICT Connection close
ICT_close();

% Print session report
if SADF.session_report; report(); end
save('Finaldata.mat');
