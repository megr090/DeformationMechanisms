# DeformationMechanisms

This repository contains code that accompanies the paper Ranganathan and Minchew, preprint "The highly nonlinear viscosity of fast-flowing glacier ice". The primary
files are denoted with "main" at the beginning.

(1) main_ComputeIceTemperature_Antarctica.m computes ice temperature using the model from Meyer and Minchew 2018 (specifically, it finds the maximum of that output 
and depth-averaged ice temperature, assuming a purely conductive model. This ice temperature will be used as an input to the subsequent model. The output is found as
"temperatureest_antarctica_theta099_intermediaten.mat".

(2) main_ComputeDeformationMechanismMap.m finds values of n for varying (physically relevant) strain rates and ice temperatures. This is necessary before calculating 
n in Antarctica or Antarctic Ice Streams. 

(3) main_ComputeN_Antarctica.m calculates n and A over the Antarctic Ice Sheet.

(4) main_ComputeN_AntarcticIceStreams.m calculates n and A over specific ice streams, with plotSRPartitioning.m being the function called to plot these values. You 
can choose specific ice streams from the following list: Byrd, Bindschadler/MacAyeal, Recovery, Amery, and Pine Island Glacier.
