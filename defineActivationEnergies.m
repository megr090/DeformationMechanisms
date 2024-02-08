function [Qg,Qc,Qm] = defineActivationEnergies(T,k0,R)

Temp = T-273;

% Activation Energy for Creep
tp = -13;
tm = -23;
tc = -18;
Qcp = 100; %kJ/mol
Qcm = 60; %kJ/mol
c1 = (Qcp-Qcm)./(atan(tp-tc)-atan(tm-tc));
c2 = Qcp-c1*tanh(tp-tc);


% Activation Energy for Grain Growth
% define Arrhenius relation for grain growth
tp = -13;
tm = -23;
tc = -18;
Qgp = 100; %kJ/mol
%Qgp = 70; %kJ/mol
Qgm = 40; %kJ/mol

% translate these values given the shift in critical temperature
tpprev = -9+273;
tmprev = -11+273;
tcprev = -10+273;
kattp = k0.*exp(-Qgp*1e3./(R.*tpprev));
newQgp = -R.*(tp+273).*log(kattp./k0)./1e3;
kattm = k0.*exp(-Qgm*1e3./(R.*tmprev));
newQgm = -R.*(tm+273).*log(kattm./k0)./1e3;

%Qgm = 20; %kJ/mol
g1 = (newQgp-newQgm)./(atan(tp-tc)-atan(tm-tc));
g2 = newQgp-g1*tanh(tp-tc);

% Activation Energy for Grain Boundary Mobility
% define Arrhenius relation for grain boundary mobility
tp = -13;
tm = -23;
tc = -18;
Qmp = newQgm; %kJ/mol
Qmm = newQgp; %kJ/mol
m1 = (Qmp-Qmm)./(atan(tp-tc)-atan(tm-tc));
m2 = Qmp-m1*atan(tp-tc);

Qg = zeros(size(T));
Qg = g1*atan(Temp-tc)+g2;
Qg = Qg.*1e3;

Qc = zeros(size(T));
Qc = c1*atan(Temp-tc)+c2;
Qc = Qc.*1e3;

% define Arrhenius relation for grain boundary mobility
Qm = zeros(size(T));
Qm = m1*atan(Temp-tc)+m2;
Qm = Qm.*1e3;

end

