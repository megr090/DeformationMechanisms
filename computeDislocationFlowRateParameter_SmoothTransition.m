function [Adis] = computeDislocationFlowRateParameter_SmoothTransition(T,sr,A0displus,A0disminus,Qdisplus,Qdisminus)

R = 8.314; % J/mol K

Temp = T-273;

% Activation Energy for Creep
tp = 0;
tm = -20;
tc = -11;

Qcp = Qdisplus; %kJ/mol
Qcm = Qdisminus; %kJ/mol
c1 = (Qcp-Qcm)./(tanh(tp-tc)-tanh(tm-tc));
c2 = Qcp-c1*tanh(tp-tc);
Qc = zeros(size(T));
Qc = c1*tanh(Temp-tc)+c2;
%Qc = Qc.*1e3;

A0p = log10(A0displus); %kJ/mol
A0m = log10(A0disminus); %kJ/mol
A01 = (A0p-A0m)./(tanh(tp-tc)-tanh(tm-tc));
A02 = A0p-A01*tanh(tp-tc);
A0 = zeros(size(T));
A0 = A01*tanh(Temp-tc)+A02;
A0 = 10.^A0;

% % Dislocation Creep
Adis = zeros(size(T)); % MPa^-4 s^-1 
for i=1:length(T)
    if T(i) < 262
        %A0 = A0disminus;
        %Qcdis = Qdisminus;
    elseif T(i) >= 262
        %A0 = A0displus;
        %Qcdis = Qdisplus;
    end
    %Adis(i) = A0.*exp(-(Qcdis./(R.*T(i))));
    Adis(i) = A0.*exp(-(Qc(i)./(R.*T(i))));
end

%f = computeFabricSoftening(sr);
f = 1;
Adis = f.*Adis;

end

