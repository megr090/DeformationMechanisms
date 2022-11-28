function [T] = computeIceTemperature(theta,nglen,z,Hc,smb,strainrate,tau,Ts)

% define ice properties parameters
rho = 917; % kg m^-3
cp = 2050; % J kg^-1 K^-1
Tm = 273; % in K
%Ts = Tm-25; % in K
dT = Tm-Ts;
K = 2.1; % W m^-1 K^-1
Acons = 2.4e-24; % Pa^-3 s^-1 

% find Ice Temperature
[T] = findSSIceTemperature(strainrate,smb,theta,rho,Acons,nglen,dT,z,Hc,Ts,Tm,K,cp,tau);

T = mean(T);

end

