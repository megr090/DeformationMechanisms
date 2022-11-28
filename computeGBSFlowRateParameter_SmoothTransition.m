function [Agbs] = computeGBSFlowRateParameter_SmoothTransition(T,A0gbsplus,A0gbsminus,Qgbsplus,Qgbsminus)

R = 8.314; % J/mol K

Temp = T-273;

% Activation Energy for Creep
tp = 0;
tm = -20;
tc = -11;

Qcp = Qgbsplus; %kJ/mol
Qcm = Qgbsminus; %kJ/mol
c1 = (Qcp-Qcm)./(tanh(tp-tc)-tanh(tm-tc));
c2 = Qcp-c1*tanh(tp-tc);
Qc = zeros(size(T));
Qc = c1*tanh(Temp-tc)+c2;
%Qc = Qc.*1e3;

A0p = log10(A0gbsplus); %kJ/mol
A0m = log10(A0gbsminus); %kJ/mol
A01 = (A0p-A0m)./(tanh(tp-tc)-tanh(tm-tc));
A02 = A0p-A01*tanh(tp-tc);
A0 = zeros(size(T));
A0 = A01*tanh(Temp-tc)+A02;
A0 = 10.^A0;

% Grain Boundary Sliding
Agbs = zeros(size(T));
for i=1:length(T)
    if T(i) < 262
        %A0 = A0gbsminus;
        %Qcgbs = Qgbsminus;
    elseif T(i) >= 262
        %A0 = A0gbsplus;
        %Qcgbs = Qgbsplus;
    end
    %Agbs(i) = A0*exp(-(Qcgbs./(R.*T(i))));
    Agbs(i) = A0*exp(-(Qc(i)./(R.*T(i))));
end

end
