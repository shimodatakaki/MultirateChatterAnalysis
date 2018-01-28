
make_Global
make_SDM
o=0;
make_Tool
make_Work

Work.Kf=calc_Kf_CS(Tool,SDM,Work);

SDM.sso=zeros(SDM.stx + 1,SDM.sty + 1);
SDM.dc=zeros(SDM.stx + 1,SDM.sty + 1);
SDM.ei=zeros(SDM.stx + 1,SDM.sty + 1);

% start of computation
for x = 1 : SDM.stx + 1 % loop for spindle speeds
    tic %begin clock
    o = O_ST + (x - 1)*(O_FI - O_ST)/SDM.stx; % spindle speed
    make_Tool;
    for y = 1 : SDM.sty + 1 % loop for depth of cuts
        w = W_ST + (y - 1)*(W_FI - W_ST)/SDM.sty; % depth of cut
        [F,G,H] = calc_F_G_H(SDM,Tool,Work,o,w);
        SDM.sso(x,y)=o;
        SDM.dc(x,y)=w;
        SDM.ei(x,y)=abs( eigs(F,1,'lm') )^(o/O_NORM); %normalized @ O_NORM
        SDM.forcedHinf(x,y)=norm( (H/(eye(length(F))-F))*G); %max (svd () )
        %SDM.selfexcitedHinf(x,y)=norm( ss(F,G,H,0), inf )^(o/O_NORM); %max sigma_max() for all omega
    end
    tictoc=toc;
    if (mod(x,10)==0)||(x==1)
        leftmin=round(tictoc*(SDM.stx+1-x)/60);
        fprintf('Left %d min\n',leftmin)
    end
end

%{
color_list=['k', 'r', 'g', 'b', 'c', 'm'];
figure(ui) %up or down
[Ccon,hcon] =contour(sso,dc,ei,[1, 1]);
hcon.LineWidth = 2;
hcon.Fill='off';
if up_or_down==1
    hcon.DisplayName=strcat('up milling, a/D=',num2str(aD));
elseif up_or_down==-1
    hcon.DisplayName=strcat('down milling, a/D=',num2str(aD));
end
hcon.LineColor=color_list(1+rem(uj,length(color_list)));
%legend('boxon')
xlabel('nominal spindle speed')
ylabel('nominal axial depth of cut')
hold on;

figname=strcat(dirname,'/','fig_2DOF_up_or_down_',num2str(up_or_down),'_ad_',num2str(aD),'_.fig');
saveas(ui,figname);
fignamejpg=strcat(dirname,'/','fig_2DOF_up_or_down_',num2str(up_or_down),'_ad_',num2str(aD),'_RVA_','_.jpg');
saveas(ui,fignamejpg);
%} 

