function [Taddiff] = findSSIceTemperature(strainrate,smb,theta,rho,Acons,n,dT,z,H,Ts,Tm,K,cp,tau)

smb = smb./(3.154e7)./rho;
Pe = (rho.*cp.*smb.*H)./(K);

% solve for Brinkmann number
%Br = ((2*theta*H^2)./(K.*(Tm-Ts))).*(strainrate.^(n+1)./Acons).^(1/n);
Br = ((2*theta*H^2)./(K.*(Tm-Ts))).*strainrate.*tau; % make dependent on stress

% find critical strain rate
%elatcrit = ((0.5.*Pe.^2)./(Pe-1+exp(-Pe))).^(n./(n+1)).*((K.*dT)./(Acons^(-1/n).*H.^2.*theta)).^(n/(n+1));
elatcrit = ((0.5.*Pe.^2)./(Pe-1+exp(-Pe))).*((K.*dT)./(H.^2.*theta.*tau)); % make dependent on stress

% find the thickness of the temperate zone
if strainrate > elatcrit
    zetaH = 1-(Pe/(Br))-(1/Pe).*(1+real(lambertw(-exp((-Pe.^2)./(Br)-1))));
else
    zetaH = 0;
end

zetaaddiff = zetaH.*H;

% find the temperature profile
Taddiff = zeros(size(z));
for i=1:length(z)
    if and(z(i)>=zetaH.*H,z(i)<=H)
        Taddiff(i) = Ts + dT*(Br./Pe).*(1-(z(i)./H)+(1/Pe).*exp(Pe.*(zetaH-1))-(1/Pe).*exp(Pe.*(zetaH.*H-z(i))./H));
    else
        Taddiff(i) = Tm;
    end
end
end

