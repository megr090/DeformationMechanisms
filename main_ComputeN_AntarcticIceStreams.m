%% Create plots of strain-rate partitioning between dislocation creep and grain-boundary sliding from Antarctic Ice Streams

clear all;
% choose the ice stream
icestream = 'PIG'; % options: BM (Bindschadler/MacAyeal), Byrd, Recovery, Amery, PIG

[SRmat,Tmat,Vmat,SMBmat,Tsmat,Tempmat,Xfix,Yfix] = readData(icestream);

% define key parameters
n = 3; % glen's flow law stress exponent
p = 9; % grain growth exponent for grain size model
D = 0.03; % characteristic length scale for grain size model
dep = 0.001; % range of strain rates for which n is approximately the same
thetamat = 0.99.*ones(size(SRmat)); % energy partitioning between thermal and stored energy

% activation energy values
Qdisplus = 151e3;
Qdisminus = 60e3;
Qgbsplus = 255e3;
Qgbsminus = 75e3;

% strain rate and temperature range of interest
strainrate = logspace(-13,-6,100);
temperature = linspace(240,273,100);

% estimate n, A deterministically
title_string = sprintf('deformationmap_varyingstrainratetemp_d(T)_An_intermediaten_smoothtransition_tanh_p%d_dep%d_Qdisminus%d_Qgbsminus%d_Qdisplus%d_Qgbsplus%d.mat',p,dep,Qdisminus,Qgbsminus,Qdisplus,Qgbsplus);
V = load(title_string);
V.n = real(V.n);
V.A = real(V.A);

% interpolate on variables
[X,Y] = meshgrid(strainrate,temperature);
Vq = interp2(X,Y,V.n,SRmat,Tempmat);
nmat_lookup = Vq;
Vq2 = interp2(X,Y,V.A,SRmat,Tempmat);
Amat_lookup = Vq2;

% plot
plotSRPartitioning(SRmat,Tmat,p,D,icestream,Vmat,Tsmat,thetamat,Tempmat,nmat_lookup,Amat_lookup,Xfix,Yfix,Qdisminus,Qgbsminus,Qdisplus,Qgbsplus);
