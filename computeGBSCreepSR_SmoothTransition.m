function [sr_gbs] = computeGBSCreepSR_SmoothTransition(tau,ngbs,grainsize,T,A0gbsplus,A0gbsminus,Qgbsplus,Qgbsminus)

[Agbs] = computeGBSFlowRateParameter_SmoothTransition(T,A0gbsplus,A0gbsminus,Qgbsplus,Qgbsminus);
grainsize = grainsize./1e3;

sr_gbs = Agbs.*grainsize.^(-1.4).*(tau./1e6).^ngbs; %Pa to MPa

end

