%save data
filename=strcat( 'MCA_aed_',num2str(round(AE/D*1000)),'_tool_',num2str(TOOL) );
save(strcat(dirname,'/',filename,'.mat'));

%save figure
sso=SDM.sso;
dc=SDM.dc;
ei=SDM.ei;
gfc=SDM.forcedHinf;

%Self-excited chatter
fig=figure;
[Ccon, hcon] = contour(sso*60/2/pi, dc*1000,20*log10(ei), [0 0]);
hcon.LineWidth=2;
hcon.LineColor='r';
hcon.LineStyle='-'; 
legend('SLD')
xlabel('Spindle speed (rpm)')
ylabel('Axial depth of cut (mm)')
grid on;
hold on;
[Ccon,hcon] = contour(sso*60/2/pi, dc*1000,20*log10(ei));
hcon.Fill='on';
colorbar;
[Ccon, hcon] = contour(sso*60/2/pi, dc*1000,20*log10(ei), [0 0]);
hcon.LineWidth=2;
hcon.LineColor='r';
hcon.LineStyle='-'; 

hfig=pubfig(fig);
print(strcat(dirname,'/','SLD_',filename), fig, '-dpdf')
print(strcat(dirname,'/','SLD_',filename), fig, '-dpng')
%expfig(fig.Number, strcat(dirname,'/','SLD_',filename),'-pdf','-png',hfig);


%Conventional Self-excited chatter
fig=figure;
[Ccon, hcon] = contour(sso*60/2/pi, dc*1000,20*log10(ei), [0 0]);
hcon.LineWidth=2;
hcon.LineColor='r';
hcon.LineStyle='-'; 
hcon.Fill='on';
legend('SLD')
xlabel('Spindle speed (rpm)')
ylabel('Axial depth of cut (mm)')
grid on;
hold on;
colormap autumn
[Ccon, hcon] = contour(sso*60/2/pi, dc*1000,20*log10(ei), [0 0]);
hcon.LineWidth=2;
hcon.LineColor='r';
hcon.LineStyle='-'; 

hfig=pubfig(fig);
print(strcat(dirname,'/','conv_SLD_',filename), fig, '-dpdf')
print(strcat(dirname,'/','conv_SLD_',filename), fig, '-dpng')



%Forced chatter
fig=figure;
[Ccon, hcon] = contour(sso*60/2/pi, dc*1000,20*log10(gfc));
hcon.Fill='on';
colorbar
xlabel('Spindle speed (rpm)')
ylabel('Axial depth of cut (mm)')
grid on;
hold on;

hfig=pubfig(fig);
print(strcat(dirname,'/','Forced_',filename), fig, '-dpdf')
print(strcat(dirname,'/','Forced_',filename), fig, '-dpng')
%expfig(fig.Number, strcat(dirname,'/','Forced_',filename),'-pdf','-png',hfig);
