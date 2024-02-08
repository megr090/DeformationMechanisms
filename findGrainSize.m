function [grainsize] = findGrainSize(T,f,R,mu,D,M0,k0,gamma,p,c,strainrate,tau)

[Qg,Qc,Qm] = defineActivationEnergies(T,k0,R);

% compute grain size
grainsize = zeros(1,length(T));
grainsize = ((4.*mu.^2.*k0.*exp(-Qg./(R.*T)).*p.^(-1).*c.*gamma+tau.^4.*D.^(p).*(0.5.*p).*M0.*exp(-Qm./(R.*T)))./(4.*mu.^2.*tau.*(1-f).*strainrate)).^(1/(1+p));
grainsize =  real(grainsize).*1e3;

end