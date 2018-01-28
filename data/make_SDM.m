%Semi-Discretization-Method Parameter
%%%%%%%%%%
%EDIT HERE
SDM.stx = 50; % steps of spindle speed
SDM.sty = 50; % steps of depth of cut
SDM.k = round(2*pi/O_ST*8*10^3/FLUTES); %minimum sampling freq is 8000 Hz (tau = k dt)
%%%%%%%%%%

SDM.intk=20; % tau_Kf=intk * dt;
SDM.wa = 1/2 ; % since time delay = time period
SDM.wb = 1/2 ; 
