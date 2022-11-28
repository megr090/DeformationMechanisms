function [grainsize] = computeGrainSize(T,theta,D,p,tau,strainrate)

R = 8.314; % J/mol K
mu = 3e9; %Pa, shear modulus
M0 = 0.023; % m^2 s kg^-1
c = 6; % for spherical grains (Behn et al in prep)
gamma = 0.065; % J/m^2 (Cuffey and Paterson 2010)
k0 = 11.4266; %mm^p/s (Azuma et al 2012)
k0 = k0./1000^p; %m^p/s

[grainsize] = findGrainSize(T,theta,R,mu,D,M0,k0,gamma,p,c,strainrate,tau);

grainsize = mean(grainsize);

end

