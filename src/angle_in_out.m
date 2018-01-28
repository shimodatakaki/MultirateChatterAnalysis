function [fist,fiex]=angle_in_out(up_or_down,aD)
if up_or_down == 1 % up-milling
    fist = 0; % start angle
    fiex = acos(1 - 2*aD); % exit anlge
elseif up_or_down == -1 % down-milling
    fist = acos(2*aD - 1); % start angle
    fiex = pi; % exit angle
end
end