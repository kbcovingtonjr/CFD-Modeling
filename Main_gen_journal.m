

clear; clc;

%% NACA 0012

airfoil     = 'NACA0012';   % name of airfoil
% aoa         = [ -20:.5:-13, -12:2:12, 13:.5:20 ];      % [degrees]
% iterations  = [repelem(16000, 1, length(-20:.5:-13)), ...
%                    repelem(5000, 1, length(-12:2:12)), ...
%                    repelem(16000, 1, length(13:.5:20))];% number of iterations
aoa         = [ -19:.5:-13.5, 13.5:.5:19 ];      % [degrees]
aoa         = [ -19:.5:-13.5 ];      % [degrees]
aoa         = [ 13.5:.5:19 ];      % [degrees]
iterations  = repelem(60000, 1, length(aoa));
length(aoa)
% Generate journal file
filesToCopy = '';
for i = 1:length(aoa)
    filename{i} = createJournal0012_ITLL(airfoil, iterations(i), aoa(i), i==1);
    filesToCopy = [filesToCopy filename{i} '+'];
end
filesToCopy(end) = []; % remove last plus
system(['copy ' filesToCopy ' ' airfoil '_allAOA_journal_2']);



clear;
%% NACA 4412
airfoil     = 'NACA4412';   % name of airfoil
% aoa         = [ -17:.5:-8, -7:2:7, 8:.5:17 ];      % [degrees]
% iterations  = [repelem(20000, 1, length(-17:.5:-8)), ...
%                    repelem(10000, 1, length(-7:2:7)), ...
%                    repelem(20000, 1, length(8:.5:17))];% number of iterations
                              
aoa         = [ 17.5:.5:30 ];      % [degrees]
iterations  = [repelem(30000, 1, length(aoa))];

aoa         = [ 12.5:.5:15.5 ];      % [degrees]
aoa(aoa==13) = [];
aoa
iterations  = [repelem(40000, 1, length(aoa))];
               
% Generate journal file
filesToCopy = '';
for i = 1:length(aoa)
    filename{i} = createJournal4412(airfoil, iterations(i), aoa(i), i==1);
    filesToCopy = [filesToCopy filename{i} '+'];
end
filesToCopy(end) = []; % remove last plus
system(['copy ' filesToCopy ' ' airfoil '_allAOA_journal']);


