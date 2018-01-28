function Kf_mat=calc_Kf_static(Tool,SDM,Work)
k=SDM.k;
intk=SDM.intk;
flutes=Tool.flutes;
fist=Tool.fist;
fiex=Tool.fiex;
Kt=Work.Kt;
Kn=Work.Kn;

Kf_mat=zeros(2,2,k); 
g=zeros(1,flutes); %screen function
phi=zeros(1,intk); %phi=angle

for i = 1 : k
    dtr = 2*pi/flutes/k; % tau/k, if tau = 2pi/flutes
    for j = 1 : flutes % loop for tooth j
        for h = 1 : intk % loop for numerical integration of hi
            phi(h) = mod( dtr*(i+ h/intk) + j*2*pi/flutes , 2*pi );
            if (phi(h) >= fist)&&(phi(h) <= fiex)
                g(h) = 1; % tooth is in the cut
            else
                g(h) = 0; % tooth is out of cut
            end
        end
        Kf_mat(1,1,i) = Kf_mat(1,1,i) + sum(g.*(Kt.* cos(phi) + Kn.* sin(phi)).* sin(phi))/intk;
        Kf_mat(1,2,i) = Kf_mat(1,2,i) + sum(g.*(Kt.* cos(phi) + Kn.* sin(phi)).* cos(phi))/intk;
        Kf_mat(2,1,i) = Kf_mat(2,1,i) + sum(g.*(-Kt.* sin(phi) + Kn.* cos(phi)).* sin(phi))/intk;
        Kf_mat(2,2,i) = Kf_mat(2,2,i) + sum(g.*(-Kt.* sin(phi) + Kn.* cos(phi)).* cos(phi))/intk;
    end
end

end
