clear all;

[SRmat,Tmat,Vmat,SMBmat,Tsmat,Xfix,Yfix] = readData_Antarctica();
Vmat(abs(Vmat)>5000) = 0;

% define key parameters
ngbs = 1.8;
ndis = 4;
nglen = 3;
tau = 1e5; % Pa

% load theta
%[thetamat] = loadThetaEstimate(icestream,p); 
thetamat = 0.99.*ones(size(SRmat));
 
% initialize results arrays
Tempmat = zeros(size(SRmat));

% compute strain-rate partitioning for each datapoint
for i=1:size(SRmat,1)
    for j=1:size(SRmat,2)

        if Vmat(i,j) >=30
            % set parameters
            theta = 0.99;
            strainrate = SRmat(i,j);
            if strainrate<1e-13
                strainrate = 1e-12;
            end
            SRmat(isnan(SRmat))=1e-12;
            H = Tmat(i,j);
            if H < 10
                H = 10;
            end
            z = linspace(0,H,100);
            smb = SMBmat(i,j);
            Ts = Tsmat(i,j);
            
            % compute partitioning
            [Tempmat(i,j)] = computeIceTemperature(theta,nglen,z,H,smb,strainrate,tau.*1e6,Ts);
        else
            Tempmat(i,j) = 0;
        end
    end
    fprintf('Iteration %d of %d done \n',i,size(SRmat,1))
end

% compute depth-averaged temperature
[Tssing,R_V] = geotiffread('/Users/meghanaranganathan/Documents/MIT/Research/Data/SameExtent/racmo_tskin_fixedextent.tif');
Ts=double(Tssing);
Ts_C = Ts-273;

depth_avg_temp_C = Ts_C./2;
depth_avg_temp = depth_avg_temp_C + 273;

% estimate temperatures
temp_map = max(Tempmat,depth_avg_temp);

save_string = sprintf('temperatureest_antarctica_theta099_intermediaten.mat');
save(save_string,'temp_map');
