function [sr_dislocation] = computeDislocationCreepSR_SmoothTransition(tau,ndis,T,sr,A0displus,A0disminus,Qdisplus,Qdisminus)

Adis = computeDislocationFlowRateParameter_SmoothTransition(T,sr,A0displus,A0disminus,Qdisplus,Qdisminus);

sr_dislocation = Adis.*(tau./1e6).^ndis; % Pa to MPa

end

