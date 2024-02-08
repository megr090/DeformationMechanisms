function [SRmat,Tmat,Vmat,SMBmat,Tsmat,X,Y,R] = readData_Antarctica()
% Velocity Contours
[Esing,R_E] = geotiffread('[insert path to strain-rate data in seconds]');
E=double(Esing);
E(isnan(E))=1e-12;

[Vsing,R_V] = geotiffread('[insert path to velocity data in m/yr]');
V=double(Vsing);

[Tsing,R] = geotiffread('[insert path to thickness data in meters]');
T = double(Tsing);

[SMB,R] = geotiffread('[insert path to surface mass balance data]');
SMB = double(SMB);

[Tssing,R] = geotiffread('[insert path to surface temperature data]');
Ts=double(Tssing);

R = R_V;
xtot = linspace(R.XWorldLimits(1),R.XWorldLimits(2),R.RasterSize(1));
ytot = linspace(R.YWorldLimits(1),R.YWorldLimits(2),R.RasterSize(2));
[X,Y] = meshgrid(xtot,ytot);

X = rot90(X');
Y = rot90(Y');

SRmat = E;
Vmat = V;
Tmat = T;
SMBmat = SMB;
Tsmat = Ts;

end

