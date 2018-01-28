function [F, G, H]=calc_F_G_H(SDM,Tool,Work,o,w)   
k=SDM.k;
wa=SDM.wa;
wb=SDM.wb;
flutes=Tool.flutes;
Kf=Work.Kf;

tau = 2*pi/o/flutes; % time delay
dt = tau/k; % time step

[A,B,C,D]=ssdata(Tool.plant);
n=length(A);

%make D
D = zeros(n*(k + 1), n*(k + 1)); % matrix D
D(n+1:n*(k+1), n+1:n*(k+1))=eye(n*k);

% construct transition matrix F
F = eye(n*(k + 1));
%constuct out/in matrix G
G = zeros(n*(k + 1), k); %only considering x
E = zeros(n*(k + 1), 1);
%
H=zeros(2,(k+1)*n);

for i = 1 : k
    %continuous
    Bc=w*(B*Kf(:,:,i));
    Ac2=Bc*C;
    Ac1=A-Ac2;
    %discrete
    P = expm(Ac1*dt); % matrix Pi
    R = ((P - eye(n))/Ac1)*Ac2; % matrix Ri %()*(inv(Ac1)*Ac2), (Ac1*Ac2)*C=Ac1*(Ac2*C)
    Q=((P - eye(n))/Ac1)*Bc;
    D(1:n, 1:n) = P;
    D(1 : n, n*(k+1) - 2*n + 1:n*(k+1) - n) = wa*R;
    D(1 : n, n*(k+1) - n + 1 : n*(k+1)) = wb*R;
    E(1:n,1)= Q(:,1);
    
    %effective matrix multiplication equal to F=D*F; spare 1 sec
    Fi0 = F;
    %effective still same as F(1:4, :) = D(1:4, :) * Fi0;
    F(1:n, :) = P * Fi0(1:n, :) + D(1:n, n*(k+1) - 2*n + 1 : n*(k+1)) * Fi0(n*(k+1) - 2*n + 1 : n*(k+1), :);
    F(n+1:n*(k+1), :) = Fi0(1:n*k,:);
    
    %G=E+D*G; %Update  G(1)=E(1)+D(1)*G(0)
    G0=G;
    G(:, i)=E;
    %effective multiplication equal to         G(:, i) = D*G(:, i);
    G(1:n,1:i)=P*G(1:n,1:i) +  D(1:n, n*(k+1) - 2*n + 1 : n*(k+1)) * G0(n*(k+1) - 2*n + 1 : n*(k+1), 1:i);
    G(n+1:n*(k+1),1:i)=G0(1:n*k,1:i);
    
    D = zeros(n*(k + 1), n*(k + 1)); % initilize
end

%G=G
%F=F
%H
for i=1:k+1
    H(1:2,n*(i-1)+1:n*i)=C;
end
end