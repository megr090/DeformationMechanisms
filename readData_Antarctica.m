function [SRmat,Tmat,Vmat,SMBmat,Tsmat,X,Y,R] = readData_Antarctica()
% Velocity Contours
[Esing,R] = geotiffread('/Users/meghanaranganathan/Documents/MIT/Research/Data/SameExtent/strainrates_in_seconds.tif');
E=double(Esing);
E(isnan(E))=1e-12;

[Vsing,R_V] = geotiffread('/Users/meghanaranganathan/Documents/MIT/Research/Data/SameExtent/surface_velocity_2014_2015_lowerres_fixedextent.tif');
V=double(Vsing);

[Tsing,R] = geotiffread('/Users/meghanaranganathan/Documents/MIT/Research/Data/SameExtent/bedmachinev01_thickness_fixedres.tif');
T = double(Tsing);

[SMB,R] = geotiffread('/Users/meghanaranganathan/Documents/MIT/Research/Data/SameExtent/smb_racmo_23_ant27_mean_fixedextent.tif');

[Tssing,R_V] = geotiffread('/Users/meghanaranganathan/Documents/MIT/Research/Data/SameExtent/racmo_tskin_fixedextent.tif');
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

