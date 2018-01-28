%%%%%%%%%%
%EDIT HERE
if TOOL==1
    mass=0.4;
    omegan=1435*2*pi;
    zeta=0.012;
    M=mass;
    K=M*omegan^2;
    B=2*zeta/omegan*K;
    G=1/(M*s^2+B*s+K);
elseif TOOL==2
    %Plant of x/F
    K0=10^8;
    %Main resonance
    omegani(1)=1925*2*pi;
    zetai(1)=0.01;
    %Sub resonance
    omegani(2)=1200*2*pi;
    zetai(2)=0.006;
    n=2;
    G = tf(1/K0);
    for i=1:n
        G = G * omegani(i)^2/(s^2 +2*zetai(i)*omegani(i)*s + omegani(i)^2);
    end
elseif TOOL==3
    %Plant of x/F
    K=0.25*10^9;
    on = [1052, 1648] * 2 * pi;
    zeta = [0.005, 0.005];
    G = 1/K;
    for i=1:length(on)
       G = G * on(i)^2 * 1/ (s^2 + 2*zeta(i)*on(i)*s + on(i)^2);
    end
elseif TOOL==4
    K=0.58*10^9;
    on = 1190 * 2 * pi;
    zeta=0.0019;
    cpd = 83*170;
    zeta = zeta + cpd / o * on / 2 /K;
    G = 1/K;
    G = G * on^2 * 1/ (s^2 + 2*zeta*on*s + on^2);
elseif TOOL==5
    %Plant of x/F
    K=0.25*10^9;
    on = [1470, 1510, 1650, 1900, 2100] * 2 * pi; %cut_p3_
    zeta = [0.005]*ones(1,5);
    G = 1/K;
    for i=1:length(on)
       G = G * on(i)^2 * 1/ (s^2 + 2*zeta(i)*on(i)*s + on(i)^2);
    end
end    
Tool.plant=ss(minreal(G*eye(2))); %Tool plant system (should be 2 input (Fx, Fy) 2 output (x, y))
%%%%%%%%%%

Tool.flutes=FLUTES;
[Tool.fist, Tool.fiex]=angle_in_out(UP_OR_DOWN,AE/D);
