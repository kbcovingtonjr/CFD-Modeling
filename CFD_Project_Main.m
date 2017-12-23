% *************************************************************************
% 
% This script is used in the numerical analysis for ASEN 3111 CFD Project
% 
%       
% Author:	Keith Covington
% 
% Created:	12/07/2017
% Modified:	12/07/2017
%
% *************************************************************************

clear; close all; clc; % housekeeping
set(0,'defaulttextInterpreter','latex')


%% --------------------- Define Experimental Data -------------------------


%% NACA 0012 experimental data
expData_0012 = [ ...
                -4.04	-0.4417	0.00871
                -2.14	-0.2385	0.008
                -0.05	-0.0126	0.00809
                2.05	0.2125	0.00816
                4.04	0.4316	0.00823
                6.09	0.6546	0.00885
                8.3     0.8873	0.0105
                10.12	1.0707	0.01201
                11.13	1.1685	0.01239
                12.12	1.2605	0.01332
                13.08	1.3455	0.01503
                14.22	1.4365	0.01625
                15.26	1.5129	0.019
                16.3	1.5739	0.02218
                17.13	1.6116	0.0256
                18.02	0.9967	0.18785
                19.08	1.1358	0.27292 ];
            
aoaExp_0012     = expData_0012(:,1);
clExp_0012      = expData_0012(:,2);
cdExp_0012      = expData_0012(:,3);

% Find zero-lift lift slope and AOA
fitExp_0012 = polyfit(aoaExp_0012(1:8), clExp_0012(1:8), 1);
a0Exp_0012 = fitExp_0012(1) * (180/pi);
stallAOAsExp_0012 = [   aoaExp_0012(clExp_0012 == min(clExp_0012)), ...
                        aoaExp_0012(clExp_0012 == max(clExp_0012)) ];




%% NACA 4412 experimental data
aoaExp_4412 =  [-20, -16, -12, -8, -6, -4, -2, 0, 2, 4, 8, 12, 16, ...
                   18, 20,  24,  30]';
clExp_4412 = [-0.545, -0.742, -0.732, -0.374, -0.211, -0.0255, ...
                   0.146,  0.338,  0.501,  0.677,  1.024,  1.289,  ...
                   1.579,   1.671, 1.690,  1.181,  0.913]';
cnExp_4412 = [-0.592, -0.767, -0.722, -0.372, -0.210, -0.0256, ...
                   0.146,  0.338,  0.501,  0.677,  1.020,  1.275, ...
                   1.548,  1.628,  1.640,  1.212,  1.009]';
caExp_4412 =  [0.0318, -0.0170, -0.1264, -0.0445, -0.0151,  0.0043, ...
                   0.0107,  0.0098, -0.0034, -0.0258, -0.1003, -0.2043, ...
                  -0.3357, -0.4040, -0.4374, -0.1838, -0.0776]';
cdExp_4412 = cnExp_4412 .* sind(aoaExp_4412) + ...
                 caExp_4412 .* cosd(aoaExp_4412);
 

aoaExp_4412 = [ ...
-10.5081241173164	
-8.32436138267678	
-6.24458734968670	
-4.26441430941576	
-2.28775143628909	
0.206222319726865	
1.98017304027094	
3.75675638617322	
5.83389779380508	
7.80354033264318	
9.87190632241434	
11.9367621450412	
13.4843070847788	
13.9928425498074	
15.1077593890115	
16.2235537700018	
18.1528293866805	
20.2909599484444	
]';

clExp_4412 = [...
-0.678131384459283
-0.462173835543184
-0.256499979432614
-0.0353594493425289
0.165180787319522
0.401689267938189
0.612562559131234
0.838886070395306
1.02910970643485
1.18844935624083
1.32717225871029
1.44529486775171
1.52744923283652
1.51191674322305
1.45508494330257
1.40340321673911
1.32583949212269
1.27399322647434
]';

load clDataExp_4412.mat
load cdDataExp_4412.mat
aoaExp_4412 = clDataExp_4412(:,1);
clExp_4412 = clDataExp_4412(:,2);
clExp_4412_plot = cdDataExp_4412(:,1);
cdExp_4412 = cdDataExp_4412(:,2);



            
% Find zero-lift lift slope and AOA
fitExp_4412 = polyfit(aoaExp_4412(1:4), clExp_4412(1:4), 1);
a0Exp_4412 = fitExp_4412(1) * (180/pi);
stallAOAsExp_4412 = [   aoaExp_4412(clExp_4412 == min(clExp_4412)), ...
                        aoaExp_4412(clExp_4412 == max(clExp_4412)) ];

                    



%% ---------------------- Read In Simulation Data -------------------------

%% NACA 0012
% Get filenames from directory
filePath_0012 = 'NACA 0012/';
addpath(filePath_0012);
simFiles_0012 = dir([ filePath_0012 '*.out']);
numFiles_0012 = length(simFiles_0012);
filenames_0012 = cell(numFiles_0012, 1);
for i = 1:numFiles_0012
    filenames_0012{i} = simFiles_0012(i).name;
end

simData_0012 = struct('aoa', [], 'iterations', [], 'cd', [], 'cl', []);

% Loop through files and extract cl and cd
wBar = waitbar(0,'Reading simulation data for NACA 0012...');
for i = 1:numFiles_0012
    fileData = importdata(filenames_0012{i}, ' ', 3);
    
    % Parse aoa from filename
    aoaChar = filenames_0012{i}(24:28);
    aoaChar = regexprep(aoaChar,'[out]','');
    if aoaChar(end) == '.'
        aoaChar(end) = '';
    end
    
    simData_0012(i).aoa         = str2num(aoaChar);
    simData_0012(i).iterations  = fileData.data(end, 1);    % extract number of iterations
    simData_0012(i).cd          = fileData.data(end, 2);    % extract cd
    simData_0012(i).cl          = fileData.data(end, 3);    % extract cl
    
    waitbar(i/numFiles_0012)
end
close(wBar);

% Sort based on AOA
[aoaSim_0012, sortKey_0012] = sort([simData_0012(:).aoa]);
iterationsSim_0012          = [simData_0012(sortKey_0012).iterations];
cdSim_0012                  = [simData_0012(sortKey_0012).cd];
clSim_0012                  = [simData_0012(sortKey_0012).cl];

% Find lift slope and stall angles
stallAOAsSim_0012 = [   aoaSim_0012(clSim_0012 == min(clSim_0012)), ...
                        aoaSim_0012(clSim_0012 == max(clSim_0012)) ];
fitInd_0012 = (aoaSim_0012 > stallAOAsSim_0012(1)) & (aoaSim_0012 < stallAOAsSim_0012(2));
fitInd_0012([1:2, end-1:end]) = [];
fitSim_0012 = polyfit(aoaSim_0012(fitInd_0012), clSim_0012(fitInd_0012), 1);
a0Sim_0012 = fitSim_0012(1) * (180/pi);





%% NACA 4412
% Get filenames from directory
filePath_4412 = 'NACA 4412/';
addpath(filePath_4412);
simFiles_4412 = dir([ filePath_4412 '*.out']);
numFiles_4412 = length(simFiles_4412);
filenames_4412 = cell(numFiles_4412, 1);
for i = 1:numFiles_4412
    filenames_4412{i} = simFiles_4412(i).name;
end

simData_4412 = struct('aoa', [], 'iterations', [], 'cd', [], 'cl', []);

% Loop through files and extract cl and cd
wBar = waitbar(0,'Reading simulation data for NACA 4412...');
for i = 1:numFiles_4412
    fileData = importdata(filenames_4412{i}, ' ', 3);
    
    % Parse aoa from filename
    aoaChar = filenames_4412{i}(24:28);
    aoaChar = regexprep(aoaChar,'[out]','');
    if aoaChar(end) == '.'
        aoaChar(end) = '';
    end
    
    simData_4412(i).aoa         = str2num(aoaChar);
    simData_4412(i).iterations  = fileData.data(end, 1);    % extract number of iterations
    simData_4412(i).cd          = fileData.data(end, 2);    % extract cd
    simData_4412(i).cl          = fileData.data(end, 3);    % extract cl
    
    waitbar(i/numFiles_4412)
end
close(wBar);

% Sort based on AOA
[aoaSim_4412, sortKey_4412] = sort([simData_4412(:).aoa]);
iterationsSim_4412          = [simData_4412(sortKey_4412).iterations];
cdSim_4412                  = [simData_4412(sortKey_4412).cd];
clSim_4412                  = [simData_4412(sortKey_4412).cl];

% Find lift slope and stall angles
stallAOAsSim_4412 = [   aoaSim_4412(clSim_4412 == min(clSim_4412)), ...
                        aoaSim_4412(clSim_4412 == max(clSim_4412)) ];
fitInd_4412 = (aoaSim_4412 > stallAOAsSim_4412(1)) & (aoaSim_4412 < stallAOAsSim_4412(2));
fitInd_4412([1:2, end-1:end]) = [];
fitSim_4412 = polyfit(aoaSim_4412(fitInd_4412), clSim_4412(fitInd_4412), 1);
a0Sim_4412 = fitSim_4412(1) * (180/pi);






%% ------------------------ Vortex Panel Method ---------------------------


%% NACA 0012

% Creating NACA 0012 airfoil with VP method
m = 0/100;
p = 0/10;
t = 12/100;
c = 1;
N = 10;
V_inf = 1000;

% Define NACA airfoil name from function inputs
airfoilName = ['NACA ' num2str(m*100) num2str(p*10) num2str(t*100)];
[x, y] = NACA_Airfoil(m, p, t, c, N, 'PlotsOff');

% Find coefficient of lift vs. angle of attack
aoaVP_0012 = linspace(min([aoaExp_0012', aoaSim_0012]), max([aoaExp_0012', aoaSim_0012]), 5);	% angle of attack [degrees]
for i = 1:length(aoaVP_0012)
	clVP_0012(i) = Vortex_Panel(x, y, V_inf, aoaVP_0012(i), 'PlotsOff');
end

% Find lift slope
fitVP_0012 = polyfit(aoaVP_0012, clVP_0012, 1);
a0VP_0012 = fitVP_0012(1) * (180/pi);




%% NACA 4412

% Creating NACA 4412 airfoil with VP method
m = 4/100;
p = 4/10;
t = 12/100;
c = 1;
N = 1000;
V_inf = 10;

% Define NACA airfoil name from function inputs
airfoilName = ['NACA ' num2str(m*100) num2str(p*10) num2str(t*100)];
[x, y] = NACA_Airfoil(m, p, t, c, N, 'PlotsOff');

% Find coefficient of lift vs. angle of attack
aoaVP_4412 =  linspace(min([aoaExp_4412', aoaSim_4412]), max([aoaExp_4412', aoaSim_4412]), 5);	% angle of attack [degrees]
for i = 1:length(aoaVP_4412)
	clVP_4412(i) = Vortex_Panel(x, y, V_inf, aoaVP_4412(i), 'PlotsOff');
end

% Find lift slope
fitVP_4412 = polyfit(aoaVP_4412, clVP_4412, 1);
a0VP_4412 = fitVP_4412(1) * (180/pi);





%% ------------------------ Thin Airfoil Theory ---------------------------

% NACA 0012
a0TA_0012 = 2*pi;
aoa_L0TA_0012 = 0;

% NACA 4412
a0TA_4412 = 2*pi;
aoa_L0TA_4412 = -4.15 % [degrees]


% For plotting thin airfoil theory results
aoa0012_thinAF = linspace(min([aoaExp_0012', aoaSim_0012]), max([aoaExp_0012', aoaSim_0012]));
aoa4412_thinAF = linspace(min([aoaExp_4412', aoaSim_4412]), max([aoaExp_4412', aoaSim_4412]));
cl0012_thinAF = (a0TA_0012*pi/180) .* aoa0012_thinAF;
cl4412_thinAF = (a0TA_4412*pi/180) .* (aoa4412_thinAF-aoa_L0TA_4412);




%% ------------------------- Report Statistics ----------------------------


% Report 0012 stats.                    
fprintf('**************** NACA 0012 ****************\n\n');

fprintf('Experimental Data:  \n');
fprintf('\t Lift Slope: \t\t %0.3f per radian\n', a0Exp_0012);
fprintf('\t Max cl: \t\t\t %0.3f\n', max(clExp_0012));
fprintf('\t Zero-lift AOA: \t %0.3f degrees\n', -fitExp_0012(2)/fitExp_0012(1));
% fprintf('\t Stall occurence: \t %0.3f, %0.3f degrees\n', stallAOAs_0012(1), stallAOAs_0012(2));
fprintf('\t Stall occurence: \t %0.3f degrees\n', stallAOAsExp_0012(2));
fprintf('\t AOA of max cl: \t %0.3f degrees\n', stallAOAsExp_0012(2));

fprintf('Simulation Data:  \n');
fprintf('\t Lift Slope: \t\t %0.3f per radian\n', a0Sim_0012);
fprintf('\t Max cl: \t\t\t %0.3f\n', max(clSim_0012));
fprintf('\t Zero-lift AOA: \t %0.3f degrees\n', -fitSim_0012(2)/fitSim_0012(1));
fprintf('\t Stall occurence: \t %0.3f, %0.3f degrees\n', stallAOAsSim_0012(1), stallAOAsSim_0012(2));
fprintf('\t AOA of max cl: \t %0.3f degrees\n', stallAOAsSim_0012(2));

fprintf('Vortex Panel Data:  \n');
fprintf('\t Lift Slope: \t\t %0.3f per radian\n', a0VP_0012);
fprintf('\t Max cl: \t\t\t %0.3f\n', max(clVP_0012));
fprintf('\t Zero-lift AOA: \t %0.3f degrees\n', -fitVP_0012(2)/fitVP_0012(1));


fprintf('\n\n');



% Report 4412 stats.                    
fprintf('**************** NACA 4412 ****************\n\n');

fprintf('Experimental Data:  \n');
fprintf('\t Lift Slope: \t\t %0.3f per radian\n', a0Exp_4412);
fprintf('\t Max cl: \t\t\t %0.3f\n', max(clExp_4412));
fprintf('\t Zero-lift AOA: \t %0.3f degrees\n', -fitExp_4412(2)/fitExp_4412(1));
fprintf('\t Stall occurence: \t %0.3f, %0.3f degrees\n', stallAOAsExp_4412(1), stallAOAsExp_4412(2));
% fprintf('\t Stall occurence: \t %0.3f degrees\n', stallAOAsExp_4412(2));
fprintf('\t AOA of max cl: \t %0.3f degrees\n', stallAOAsExp_4412(2));

fprintf('Simulation Data:  \n');
fprintf('\t Lift Slope: \t\t %0.3f per radian\n', a0Sim_4412);
fprintf('\t Max cl: \t\t\t %0.3f\n', max(clSim_4412));
fprintf('\t Zero-lift AOA: \t %0.3f degrees\n', -fitSim_4412(2)/fitSim_4412(1));
fprintf('\t Stall occurence: \t %0.3f, %0.3f degrees\n', stallAOAsSim_4412(1), stallAOAsSim_4412(2));
fprintf('\t AOA of max cl: \t %0.3f degrees\n', stallAOAsSim_4412(2));

fprintf('Vortex Panel Data:  \n');
fprintf('\t Lift Slope: \t\t %0.3f per radian\n', a0VP_4412);
fprintf('\t Max cl: \t\t\t %0.3f\n', max(clVP_4412));
fprintf('\t Zero-lift AOA: \t %0.3f degrees\n', -fitVP_4412(2)/fitVP_4412(1));






%% Plot exp. and simulation data from NACA 0012

% Lift curve
figure
hold on
grid minor
plot(aoaSim_0012, clSim_0012, '-o')     % plot sim. data
plot(aoaExp_0012, clExp_0012, '-*')     % plot exp. data
plot(aoaVP_0012, clVP_0012, '--','LineWidth',1.5)		% plot vortex data
plot(aoa0012_thinAF, cl0012_thinAF, '-.','LineWidth',1.5)	% plot thin airfoil data
set(gca,'TickLabelInterpreter', 'tex');
title('Lift Curve for NACA 0012', 'FontSize', 16)
xlabel('Angle of Attack [$^\circ$]', 'FontSize', 14)
ylabel('Sectional Coefficient of Lift [1]', 'FontSize', 14)
legend({'CFD Simulation Data', 'Experimental Data', ...
		'Vortex Panel Data', 'Thin Airfoil Theory Data'}, ...
		'location','northwest','Interpreter','latex')
print(gcf, 'liftCurve_0012', '-depsc')  % save plot

% Drag Polar
figure
hold on
grid minor
plot(clSim_0012, cdSim_0012, '-o')		% plot sim. data
plot(clExp_0012, cdExp_0012, '-*')		% plot exp. data
set(gca,'TickLabelInterpreter', 'tex');
title('Relationship Between Lift and Drag for NACA 0012', 'FontSize', 16)
xlabel('Sectional Coefficient of Lift [1]', 'FontSize', 14)
ylabel('Sectional Coefficient of Drag [1]', 'FontSize', 14)
legend({'CFD Simulation Data', 'Experimental Data'}, ...
		'location','northwest','Interpreter','latex')
print(gcf, 'dragPolar_0012', '-depsc')  % save plot




%% Plot exp. and simulation data from NACA 4412

figure
hold on
grid minor
plot(aoaSim_4412, clSim_4412, '-o')     % plot sim. data
plot(aoaExp_4412, clExp_4412, '-*')     % plot exp. data
plot(aoaVP_4412, clVP_4412, '--','LineWidth',1.5)		% plot vortex panel data
plot(aoa4412_thinAF, cl4412_thinAF, '-.','LineWidth',1.5)	% plot thin airfoil data
set(gca,'TickLabelInterpreter', 'tex');
title('Lift Curve for NACA 4412', 'FontSize', 16)
xlabel('Angle of Attack [$^\circ$]', 'FontSize', 14)
ylabel('Coefficient of Lift [1]', 'FontSize', 14)
legend({'CFD Simulation Data', 'Experimental Data', ...
		'Vortex Panel Data', 'Thin Airfoil Theory Data'}, ...
		'location','northwest','Interpreter','latex')
print(gcf, 'liftCurve_4412', '-depsc')  % save plot

% Drag Polar
figure
hold on
grid minor
plot(clSim_4412, cdSim_4412, '-o')		% plot sim. data
%plot(clExp_4412, cdExp_4412, '-*')		% plot exp. data
plot(clExp_4412_plot, cdExp_4412, '-*')		% plot exp. data
set(gca,'TickLabelInterpreter', 'tex');
title('Relationship Between Lift and Drag for NACA 4412', 'FontSize', 16)
xlabel('Sectional Coefficient of Lift [1]', 'FontSize', 14)
ylabel('Sectional Coefficient of Drag [1]', 'FontSize', 14)
legend({'CFD Simulation Data', 'Experimental Data'}, ...
		'location','northwest','Interpreter','latex')
print(gcf, 'dragPolar_4412', '-depsc')  % save plot



