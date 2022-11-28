function [diff] = findStressDiffFromSRGK_constantT(x,theta,strainrate,ngbs,ndis,A0displus,A0disminus,Qdisplus,Qdisminus,A0gbsplus,A0gbsminus,Qgbsplus,Qgbsminus,T0,D,p)

[T] = T0;

% Adis = computeDislocationFlowRateParameter_TestParams(T,strainrate,A0displus,A0disminus,Qdisplus,Qdisminus);
% Agbs = computeGBSFlowRateParameter_TestParams(T,A0gbsplus,A0gbsminus,Qgbsplus,Qgbsminus);
Adis = computeDislocationFlowRateParameter_SmoothTransition(T,strainrate,A0displus,A0disminus,Qdisplus,Qdisminus);
Agbs = computeGBSFlowRateParameter_SmoothTransition(T,A0gbsplus,A0gbsminus,Qgbsplus,Qgbsminus);

[d] = computeGrainSize(T,theta,D,p,x.*1e6,strainrate);

strainratest = Adis.*x.^ndis+Agbs.*(d./1e3).^(-1.4).*x.^ngbs;
%[strainratest,sr_dislocation,sr_gbs] = computeStrainRate(T,d./1e3,x.*1e6,ndis,ngbs,strainrate);

diff = abs(strainrate-strainratest).*1e10;

end
