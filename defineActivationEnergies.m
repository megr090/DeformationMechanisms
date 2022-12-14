function [Qg,Qc,Qm] = defineActivationEnergies(T)

Temp = T-273;

% Activation Energy for Creep
tp = 0;
tm = -20;
tc = -10;
Qcp = 100; %kJ/mol
Qcm = 60; %kJ/mol
c1 = (Qcp-Qcm)./(atan(tp-tc)-atan(tm-tc));
c2 = Qcp-c1*tanh(tp-tc);

% Activation Energy for Grain Growth
% define Arrhenius relation for grain growth
tp = 0;
tm = -20;
tc = -10;
Qgp = 100; %kJ/mol
%Qgp = 70; %kJ/mol
Qgm = 40; %kJ/mol
%Qgm = 20; %kJ/mol
g1 = (Qgp-Qgm)./(atan(tp-tc)-atan(tm-tc));
g2 = Qgp-g1*tanh(tp-tc);

% Activation Energy for Grain Boundary Mobility
% define Arrhenius relation for grain boundary mobility
tp = 0;
tm = -20;
tc = -10;
Qmp = 40; %kJ/mol
Qmm = 100; %kJ/mol
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

