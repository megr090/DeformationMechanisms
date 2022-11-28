%% Compute n, probabilities of n across Antarctica, save and plot
clear all;

% activation energy values
Qdisplus = 151e3;
Qdisminus = 60e3;
Qgbsplus = 255e3;
Qgbsminus = 75e3;

% other parameter values
p = 9; % grain size exponent from grain size model
D = 0.03; % grain length scale from grain size model
dep = 0.001; % range of strain rates
ngbs = 1.8; % grain-boundary sliding stress exponent
ndis = 4; % dislocation creep stress exponent
nglen = 3; % glen's flow law exponent

% load ice temperature estimates (computed from
% main_ComputeIceTemperature_Antarctica.m)
load('temperatureest_antarctica_theta099_intermediaten.mat');

% load in rest of data needed (strain rates, ice thickness, surface velocity, surface mass
% balance)
[SRmat,Tmat,Vmat,SMBmat,Xfix,Yfix] = readData_Antarctica();

% load deformation map that defines n,A for
% given strain rate, temperature
title_string = sprintf('deformationmap_varyingstrainratetemp_d(T)_An_intermediaten_smoothtransition_tanh_p%d_dep%d_Qdisminus%d_Qgbsminus%d_Qdisplus%d_Qgbsplus%d.mat',p,dep,Qdisminus,Qgbsminus,Qdisplus,Qgbsplus);
V = load(title_string); % deterministic version

% strain rate and temperature range of interest
strainrate = logspace(-13,-6,100); 
temperature = linspace(240,273,100);

% interpolate
[X,Y] = meshgrid(strainrate,temperature);
Vq = interp2(X,Y,V.n,SRmat,temp_map);
nmat_lookup = Vq;
Aq = interp2(X,Y,V.A,SRmat,temp_map);
Amat_lookup = Aq;
Amat_lookup(abs(Vmat)>5000) = -9999;
Amat_lookup(Vmat < 30) = -9999;
nmat_lookup(abs(Vmat)>5000) = -9999;
nmat_lookup(Vmat < 30) = -9999;

% save
title_save = sprintf('partitioningest_antarctica_p%d_D%d_theta099_intermediaten_incldepthavgtemp_Qdisminus%d_Qgbsminus%d_Qdisplus%d_Qgbsplus%d.mat',p,D,Qdisminus,Qgbsminus,Qdisplus,Qgbsplus);
save(title_save,'temp_map','nmat_lookup','Amat_lookup');

% plot
al = ones(size(nmat_lookup));
al(Vmat<30) = 0;
al(abs(Vmat)>5000) = 0;
[Tssing,R_V] = geotiffread('/Users/meghanaranganathan/Documents/MIT/Research/Data/SameExtent/racmo_tskin_fixedextent.tif');
xaxis = linspace(R_V.XWorldLimits(1)./1000, R_V.XWorldLimits(2)./1000, size(SRmat,2));
yaxis = linspace(R_V.YWorldLimits(1)./1000,R_V.YWorldLimits(2)./1000,size(SRmat,1));
load('groundingline.mat')

figure;
imagesc(xaxis,yaxis,real(nmat_lookup))
alpha(al)
hold on
for i=1:676
    plot(S(i).X/1000,-S(i).Y/1000,'Color',[0 0 0],'LineWidth',1)
    hold on;
end
cmap = colorcet('cbd1');
%cbar = colorbar;
colormap(cmap)
caxis([1.8 4])
set(gca,'FontSize',24,'FontWeight','b','GridColor','r');
title('n') 
xticks([]);
xticklabels({});
yticks([]);
yticklabels({});

figure;
imagesc(xaxis,yaxis,real(log10(Amat_lookup)))
alpha(al)
hold on
for i=1:676
    plot(S(i).X/1000,-S(i).Y/1000,'Color',[0 0 0],'LineWidth',1)
    hold on;
end
colormap(colorcet('l10'));
%colorbar;
caxis([-28 -16])
cbar = colorbar;
xticks([]);
xticklabels({});
yticks([]);
yticklabels({});
title('A') 
set(gca,'FontSize',24,'FontWeight','b','GridColor','r');
