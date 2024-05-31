# DeformationMechanisms

This repository contains code that accompanies the paper Ranganathan and Minchew 2024 "A modified viscous flow law for natural glacier ice: Scaling from laboratories to ice sheets", doi:10.1073/pnas.2309788121. The primary
files are denoted with "main" at the beginning.

(1) main_ComputeIceTemperature_Antarctica.m computes ice temperature using the model from Meyer and Minchew 2018 (specifically, it finds the maximum of that output 
and depth-averaged ice temperature, assuming a purely conductive model. This ice temperature will be used as an input to the subsequent model. The output is found as
"temperatureest_antarctica_theta099_intermediaten.mat".

(2) main_ComputeDeformationMechanismMap.m finds values of n for varying (physically relevant) strain rates and ice temperatures. This is necessary before calculating 
n in Antarctica or Antarctic Ice Streams. 

(3) main_ComputeN_Antarctica.m calculates n and A over the Antarctic Ice Sheet.

(4) main_ComputeN_AntarcticIceStreams.m calculates n and A over specific ice streams, with plotSRPartitioning.m being the function called to plot these values. You 
can choose specific ice streams from the following list: Byrd, Bindschadler/MacAyeal, Recovery, Amery, and Pine Island Glacier.

This repository also contains two .csv files, which contain 100x100 arrays for estimates of n and A (respectively) for varying strain-rate and temperature (analogous to the deformation mechanism maps in the manuscript). The values in the arrays are n and A (in Pa^-n s^-1) for varying temperature (x) and strain-rate (y). The .csv files contain row and column headers that denote the strain rate and temperature values associated with each n,A value. There are also .h5 files with the same 100x100 arrays, but these do not have the headers.
