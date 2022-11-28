%% Compute stress exponent n for varying strain rate and ice temperature
% We make a deformation mechanism map, computing the stress exponent n for
% a range of physically-reasonable strain rates and temperatures. It is
% straightforward to replicate this with stress and temperature instead (if
% you would like those codes, please email me at meghanar@ucar.edu).

clear all;

% top-level parameters
D = 0.03; % characteristic length scale for grain size model
p = 9; % grain growth exponent for grain size model
ndis = 4; % stress exponent for dislocation creep
ngbs = 1.8; % stress exponent for grain-boundary sliding
nglen = 3; % glen's flow law exponent
theta = 0.99; % energy partitioning between thermal and stored energy
dep = 0.001; % strain rate range for which n is approximately the same

% kinetic parameters for the composite flow law
A0displus = 6.96e23;
A0disminus = 5e5;
Qdisplus = 151e3;
Qdisminus = 60e3;
A0gbsplus = 8.5e37;
A0gbsminus = 1.1e2;
Qgbsplus = 255e3;
Qgbsminus = 75e3;

% strain rate and temperature range of interest
strainrate = logspace(-13,-6,100); 
temperature = linspace(240,273,100);

% initialize matrices
n = zeros(length(strainrate),length(temperature));
A = zeros(length(strainrate),length(temperature));

for i=1:length(strainrate)
    tau_last = 0.1;
    tau_last_min = tau_last;
    tau_last_max = tau_last;

    for j=1:length(temperature)
        
        % define min and max strain rate
        delta_sr = strainrate(i).*dep;
        sr_min = strainrate(i)-delta_sr;
        sr_max = strainrate(i)+delta_sr;

        % find stress for min strain rate
        options = optimoptions('fsolve','Diagnostics','off','Display','off','MaxIterations',500,'FunctionTolerance',1e-10);
        fun = @(x)findStressDiffFromSRGK_constantT(x,theta,sr_min,ngbs,ndis,A0displus,A0disminus,Qdisplus,Qdisminus,A0gbsplus,A0gbsminus,Qgbsplus,Qgbsminus,temperature(j),D,p);
        x0 = 0.1;
        [tau_min,fval,exitflagmin] = fsolve(fun,x0,options);
        if exitflagmin < 1
            x0 = tau_last;
            [tau_min,fval,exitflagmin] = fsolve(fun,x0,options);
        end
        tau_last_min = tau_min;

        % find stress for max strain rate
        options = optimoptions('fsolve','Diagnostics','off','Display','off','MaxIterations',500,'FunctionTolerance',1e-10);
        fun = @(x)findStressDiffFromSRGK_constantT(x,theta,sr_max,ngbs,ndis,A0displus,A0disminus,Qdisplus,Qdisminus,A0gbsplus,A0gbsminus,Qgbsplus,Qgbsminus,temperature(j),D,p);
        x0 = 0.1;
        [tau_max,fval,exitflagmax] = fsolve(fun,x0,options);
        if exitflagmax < 1
            x0 = tau_last;
            [tau_max,fval,exitflagmax] = fsolve(fun,x0,options);
        end
        tau_last_max = tau_max;
        
        % compute n,A
        n(i,j) = log(sr_min./sr_max)./log(tau_min./tau_max);
        A(i,j) = (sr_max-sr_min)./((tau_max.*1e6).^n(i,j)-(tau_min.*1e6).^n(i,j));
    end
    
    fprintf('Iteration %d of %d done \n',i,length(strainrate))
end

% plot n,A
n_flip = n(end:-1:1,:);
A_flip = A(end:-1:1,:);

figure;
imagesc(real(n_flip))
colorbar;
colormap(colorcet('cbd1','reverse',0))
caxis([1.8 4])
set(gca,'FontSize',18,'FontWeight','b','GridColor','r');
ylabel('Strain Rate (s^{-1})')
xlabel('Temperature (K)')
% yticks([1 26 51 76 100])
% yticklabels({'10^{-7}','10^{-8}','10^{-9}','10^{-10}','10^{-11}'})
yticks([1 15 29 43 57 71 85 100])
yticklabels({'10^{-6}','10^{-7}','10^{-8}','10^{-9}','10^{-10}','10^{-11}','10^{-12}','10^{-13}'})
xticks([1 16 31 46 61 76 91])
xticklabels({'240','245','250','255','260','265','270'})
title('n: Deformation Map, $$d_0(T)$$','Interpreter','Latex')

figure;
imagesc(real(log10(A_flip)))
colorbar;
colormap(colorcet('l10','reverse',0))
caxis([-29 -16])
set(gca,'FontSize',18,'FontWeight','b','GridColor','r');
ylabel('Strain Rate (s^{-1})')
xlabel('Temperature (K)')
% yticks([1 26 51 76 100])
% yticklabels({'10^{-7}','10^{-8}','10^{-9}','10^{-10}','10^{-11}'})
yticks([1 15 29 43 57 71 85 100])
yticklabels({'10^{-6}','10^{-7}','10^{-8}','10^{-9}','10^{-10}','10^{-11}','10^{-12}','10^{-13}'})
xticks([1 16 31 46 61 76 91])
xticklabels({'240','245','250','255','260','265','270'})
title('A: Deformation Map, $$d_0(T)$$','Interpreter','Latex')

% save n,A
title_string = sprintf('deformationmap_varyingstrainratetemp_d(T)_An_intermediaten_smoothtransition_tanh_p%d_dep%d_Qdisminus%d_Qgbsminus%d_Qdisplus%d_Qgbsplus%d.mat',p,dep,Qdisminus,Qgbsminus,Qdisplus,Qgbsplus);
save(title_string,'n','A');