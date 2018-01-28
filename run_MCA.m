clear all
close all
clc

addpath('data','src');

supertime=datestr(datetime,'yyyymmdd_HHMMSS');
dirname=strcat('result/SLD_MCA_',supertime);
mkdir(dirname);

%EDIT HERE
%%%%%%%%%%%%%%%%%%%
TOOL_LIST=[1, 2]; %Tool plant dynamics
%%%%%%%%%%%%%%%%%%%

for itool=1:length(TOOL_LIST)
    TOOL = TOOL_LIST(itool);
    multirate_analysis_CS;
    save_all;
end

fprintf('\nEOF\n')