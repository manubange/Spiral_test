clc;  close all; warning off all; clearvars;

% preparation
pathProject = '/mnt/M/manuelStorage/projects/Project_LFPSpiral/Bangeetal'      % path to main folder
addpath (pathProject)
addpath ([pathProject '/kinematics'])   


%load spiral_model.mat
load spiral_noised.mat


%% filter (4th order LP 10Hz butterworth)
fc = 10;
fs = 100;
fordbutter=4;
[b,a] = butter(fordbutter,fc/(fs/2));
x = filter (b,a, x);
y = filter (b,a, y);

% set to 0/0
x=x-x(1);
y=y-y(1);



%% calculate velocity and acceleration, gauss filter
dt = t(2)-t(1);
vTan = tangvelocity([x,y], 2);
vTan = vTan/dt;               % get correct units (cm/s)
vTan_avg =  mean(abs(vTan));


%% radius-angle-transform
pos=find(x>0);
neg = find (x<0);
xBin(pos)=1;
xBin(neg)=-1;

posTransitions = (find (diff(xBin)>0)+1)';
nFullLoops = size (posTransitions,1)-1;
[theta,rho] = cart2pol(x,y);
transition1 = posTransitions(2);
transitionLast = posTransitions(end);

theta_glm = unwrap(theta);
theta_glm = theta_glm/-pi;  % to clockwise (pi rad)
theta1 = theta_glm(transition1);
thetaLast=  theta_glm(transitionLast);

rho_glm = rho;
mdl = fitlm(theta_glm(transition1:end),rho_glm(transition1:end));  % rho ~ 1 + theta   --> excluding first loop
RMSE_glm = mdl.RMSE;
Slope_glm = table2array(mdl.Coefficients (2,1));



%% plot spiral, vTan, radius-angle-transform
% plot spiral 
subplot(2,2,1)
plot(x,y) ;
xlim ([-8 8])
ylim ([-8 8])
axis square
xlabel ('pos x (cm)')
ylabel ('pos y (cm)')

% plot tangential velocity
subplot(2,2,2)
plot(t,vTan)
title ({'tangential velocity', ...
    ['average velocity = ', num2str(vTan_avg), ' cm/s' ], ...
    });
xlabel ('time (second)')
ylabel ('vTan (cm/s)')

% plot radius-angle-transform, glm, optimal spiral
subplot(224);
hold on;
plot(mdl,...
    'color',[0 0 0], 'Markersize', 1);
title ({'radius-angle-transform:', ...
    ['RMSE (glm) = ', num2str(RMSE_glm) ], ...
    ['Slope (glm) = ', num2str(Slope_glm) ], ...
    });
xlabel ('angle (pi radians)');
ylabel ('radius (cm)');
hold off


