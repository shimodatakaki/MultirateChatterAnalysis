%Global Parameters

s=tf('s');


%%%%%%%%%%
%EDIT HERE
AE=3/1000; %Radial depth of cut (m)
D=10/1000; %diameter of tool (m)

FLUTES = 4; % number of teeth

UP_OR_DOWN=-1; %UP(1) or DOWN(-1) MILLING

W_ST = 0/1000; % starting depth of cut (m)
W_FI = 10/1000; % final depth of cut (m)

O_ST = (2*pi/60) * 4000; %starting spindle speed (rad/s)
O_FI = (2*pi/60) * 8000; %final spindle speed (rad/s)

TAU_NORM=10*10^-3; %nominal period for SLD (s)
%%%%%%%%%%
%EDIT HERE


O_NORM=60/TAU_NORM/FLUTES; %nominal speed
