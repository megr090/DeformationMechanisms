function [] = plotSRPartitioning(SRmat,Tmat,p,D,icestream,Vmat,Tsmat,thetamat,Tempmat,nmat,Amat,Xfix,Yfix,Qdisminus,Qgbsminus,Qdisplus,Qgbsplus)
Vmat(Vmat<0) = 0;

xaxis = linspace(Xfix(1,1)./1000, Xfix(1,end)./1000, size(SRmat,2));
yaxis = linspace(Yfix(1,1)./1000,Yfix(end,1)./1000,size(SRmat,1));

[Xa,Ya] = meshgrid(xaxis,yaxis);

%Xfix = rot90(Xfix');
%Yfix = rot90(Yfix');
Boundary = [Xfix(end,1),Xfix(1,1),Xfix(1,end),Xfix(end,end);Yfix(end,1),Yfix(1,1),Yfix(1,end),Yfix(end,end)]'./1000;

figure;
imagesc(xaxis,yaxis,real(log10(Vmat)))
hold on;
colormap(colorcet('l17','reverse',0))
set(gca,'FontSize',24,'FontWeight','b','GridColor','r');
xticks([]);
xticklabels({});
yticks([]);
yticklabels({});
cbar = colorbar; 
caxis([1 3.6])
cbar.Ticks=[1 2 3 3.6];
cbar.TickLabels={'10', '100', '1000', '4000'};
% caxis([1 3])
% cbar.Ticks=[1 2 3];
% cbar.TickLabels={'10', '100', '1000'};
title('Velocity (m a^{-1})')
load('groundingline.mat')
poly = polyshape(Boundary);
for i=1:676
    lineseg2 = [];
    lineseg = [];
    lineseg = [S(i).X/1000;S(i).Y/1000];
    lineseg2(1,:) = lineseg(1,~isnan(lineseg(1,:)));
    lineseg2(2,:) = lineseg(2,~isnan(lineseg(2,:)));
    [in,out] = intersect(poly,lineseg2');
    plot(in(:,1),in(:,2),'Color','k','LineWidth',2);
    hold on;
end
set(gca,'xdir','reverse')
camroll(90)
camroll(90)

figure;
imagesc(xaxis,yaxis,log10(SRmat))
hold on;
colormap(colorcet('l17','reverse',0))
set(gca,'FontSize',24,'FontWeight','b','GridColor','r');
xticks([]);
xticklabels({});
yticks([]);
yticklabels({});
cbar = colorbar; 
caxis([-11 -8])
cbar.Ticks=[-11 -10 -9 -8];
cbar.TickLabels={'10^{-11}', '10^{-10}', '10^{-9}', '10^{-8}'};
title('Strain Rates (s^{-1})')
load('groundingline.mat')
poly = polyshape(Boundary);
for i=1:676
    lineseg2 = [];
    lineseg = [];
    lineseg = [S(i).X/1000;S(i).Y/1000];
    lineseg2(1,:) = lineseg(1,~isnan(lineseg(1,:)));
    lineseg2(2,:) = lineseg(2,~isnan(lineseg(2,:)));
    [in,out] = intersect(poly,lineseg2');
    plot(in(:,1),in(:,2),'Color','k','LineWidth',2);
    hold on;
end
set(gca,'xdir','reverse')
camroll(90)
camroll(90)

figure;
imagesc(xaxis,yaxis,Tmat)
hold on;
colormap(colorcet('l17','reverse',0))
set(gca,'FontSize',24,'FontWeight','b','GridColor','r');
xticks([]);
xticklabels({});
yticks([]);
yticklabels({});
colorbar; 
caxis([0 2000])
title('Thickness (m)')
load('groundingline.mat')
poly = polyshape(Boundary);
for i=1:676
    lineseg2 = [];
    lineseg = [];
    lineseg = [S(i).X/1000;S(i).Y/1000];
    lineseg2(1,:) = lineseg(1,~isnan(lineseg(1,:)));
    lineseg2(2,:) = lineseg(2,~isnan(lineseg(2,:)));
    [in,out] = intersect(poly,lineseg2');
    plot(in(:,1),in(:,2),'Color','k','LineWidth',2);
    hold on;
end
set(gca,'xdir','reverse')
camroll(90)
camroll(90)

figure;
imagesc(xaxis,yaxis,Tsmat)
hold on;
colormap(colorcet('l17','reverse',0))
set(gca,'FontSize',24,'FontWeight','b','GridColor','r');
xticks([]);
xticklabels({});
yticks([]);
yticklabels({});
colorbar; 
caxis([240 273])
title('Surface Temperature (K)')
load('groundingline.mat')
poly = polyshape(Boundary);
for i=1:676
    lineseg2 = [];
    lineseg = [];
    lineseg = [S(i).X/1000;S(i).Y/1000];
    lineseg2(1,:) = lineseg(1,~isnan(lineseg(1,:)));
    lineseg2(2,:) = lineseg(2,~isnan(lineseg(2,:)));
    [in,out] = intersect(poly,lineseg2');
    plot(in(:,1),in(:,2),'Color','k','LineWidth',2);
    hold on;
end
set(gca,'xdir','reverse')
camroll(90)
camroll(90)

nmat(Vmat < 30) = 9999;

figure;
imagesc(xaxis,yaxis,real(nmat))
hold on
[M,c] = contour(Xa,Ya,Vmat,[200 400 600],'-.k');
c.LineWidth=0.5;
%cmap = colorcet('cbl2_g','N',6);
%cmap = colorcet('cbd1_g','N',5);
cmap = colorcet('cbd1_hg');
cbar = colorbar;
colormap(cmap)
caxis([3.8 4.01])
set(gca,'FontSize',24,'FontWeight','b','GridColor','r');
title('n') 
%cbar.Ticks=[-25, -24, -23];
%cbar.TickLabels={'10^{-25}','10^{-24}', '10^{-23}'};
xticks([]);
xticklabels({});
yticks([]);
yticklabels({});
load('groundingline.mat')
poly = polyshape(Boundary);
for i=1:676
    lineseg2 = [];
    lineseg = [];
    lineseg = [S(i).X/1000;S(i).Y/1000];
    lineseg2(1,:) = lineseg(1,~isnan(lineseg(1,:)));
    lineseg2(2,:) = lineseg(2,~isnan(lineseg(2,:)));
    [in,out] = intersect(poly,lineseg2');
    plot(in(:,1),in(:,2),'Color','k','LineWidth',2);
    hold on;
end
set(gca,'xdir','reverse')
camroll(90)
camroll(90)

Amat(Vmat < 30) = 9999;

figure;
imagesc(xaxis,yaxis,real(log10(Amat)))
hold on
[M,c] = contour(Xa,Ya,Vmat,[200 400 600],'-.k');
c.LineWidth=0.5;
cmap = colorcet('l10_g');
cbar = colorbar;
colormap(cmap)
caxis([-31 -29])
set(gca,'FontSize',24,'FontWeight','b','GridColor','r');
title('A') 
%cbar.Ticks=[-25, -24, -23];
%cbar.TickLabels={'10^{-25}','10^{-24}', '10^{-23}'};
xticks([]);
xticklabels({});
yticks([]);
yticklabels({});
load('groundingline.mat')
poly = polyshape(Boundary);
for i=1:676
    lineseg2 = [];
    lineseg = [];
    lineseg = [S(i).X/1000;S(i).Y/1000];
    lineseg2(1,:) = lineseg(1,~isnan(lineseg(1,:)));
    lineseg2(2,:) = lineseg(2,~isnan(lineseg(2,:)));
    [in,out] = intersect(poly,lineseg2');
    plot(in(:,1),in(:,2),'Color','k','LineWidth',2);
    hold on;
end
set(gca,'xdir','reverse')
camroll(90)
camroll(90)

Tempmat(Vmat < 30) = -999;

figure;
imagesc(xaxis,yaxis,real(Tempmat))
hold on
[M,c] = contour(Xa,Ya,Vmat,[200 400 600],'-.k');
c.LineWidth=0.5;
cbar = colorbar;
colormap(colorcet('l17_g'))
caxis([245 273])
set(gca,'FontSize',24,'FontWeight','b','GridColor','r');
title('Temperature (K)') 
%cbar.Ticks=[-25, -24, -23];
%cbar.TickLabels={'10^{-25}','10^{-24}', '10^{-23}'};
xticks([]);
xticklabels({});
yticks([]);
yticklabels({});
load('groundingline.mat')
poly = polyshape(Boundary);
for i=1:676
    lineseg2 = [];
    lineseg = [];
    lineseg = [S(i).X/1000;S(i).Y/1000];
    lineseg2(1,:) = lineseg(1,~isnan(lineseg(1,:)));
    lineseg2(2,:) = lineseg(2,~isnan(lineseg(2,:)));
    [in,out] = intersect(poly,lineseg2');
    plot(in(:,1),in(:,2),'Color','k','LineWidth',2);
    hold on;
end
set(gca,'xdir','reverse')
camroll(90)
camroll(90)

end

