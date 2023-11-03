clc;  close all; warning off all; clearvars;

% preparation
pathProject = '/mnt/M/manuelStorage/projects/Project_LFPSpiral/SpiralBeta'      % path to main folder
addpath (pathProject)
addpath ([pathProject '/fieldtrip-20220310'])                                   % path to fieldtrip
ft_defaults;
cd (pathProject)

BetaThresh = 0.75;                                                              % burst definition at 75% percentile of amplitude according to Tinkhauser et al. 2020 Jneurosci
betafreq = 15;

load('data/LFP.mat')


%% calculate beta bursts

% beta-envelope
% filter
cfg = [];
cfg.bpfilter = 'yes'; 
cfg.bpfreq = [betafreq-2 betafreq+2]; 
cfg.bpfiltord = 2;
cfg.channel = {'LFP_cl'};
LFP_beta = ft_preprocessing(cfg, dataLFP_Sbj);

% rectify
cfg = [];
cfg.rectify = 'yes';
LFP_beta_rect = ft_preprocessing(cfg, LFP_beta);

% smooth
cfg = [];
cfg.smoothwin = 0.2;                                                                              % size of moving window in seconds
cfg.feedback = 'no';                                                                              % shows the result of smoothing
LFP_beta_rect_smooth = smoothBeta(cfg, LFP_beta_rect);

% determine threshold
%sampleInfo = LFP_beta_rect_smooth.sampleinfo;
BetaEnvelope = LFP_beta_rect_smooth.trial{1, 1} (1,:);

cfg = [];
cfg.BetaThresh = BetaThresh;
Thresh = determineThresh(cfg, BetaEnvelope);

% get burst features
cfg = [];
input = LFP_beta_rect_smooth;
cfg.thresh = Thresh;
BurstFeatures = betaBurstFeatures(cfg, input);



% plot beta envelope and threshold
figure
ThreshVec(1,1:size(BetaEnvelope,2)) = Thresh;
plot(dataLFP_Sbj.time{1, 1}, BetaEnvelope,'k')
hold on
plot (dataLFP_Sbj.time{1, 1}, ThreshVec,'.r')
legend ({'beta amplitude signal'; 'threshold'})
xlabel ('time(s)')
ylabel ('amplitude')
title ({'beta burst determination' ...
    ['number of bursts: ' num2str(BurstFeatures.withinTrialBurstDescriptives{1, 1}.nBursts)] ...
    ['average burst amplitude: ' num2str(BurstFeatures.withinTrialBurstDescriptives{1, 1}.meanAmpBurst)] ...
    ['average burst duration: ' num2str(BurstFeatures.withinTrialBurstDescriptives{1, 1}.meanDurationBurst)] ...
    })
hold off



%% Frequency analysis
cfg = [];
cfg.length = 1;
dataLFP_base_1s = ft_redefinetrial(cfg,  dataLFP_Sbj);

cfg = [];
cfg.output  = 'pow';
cfg.channel = 'all';
cfg.method  = 'mtmfft';
cfg.taper   = 'dpss';
cfg.tapsmofrq = 2;
cfg.foi     = 1:1:100;
freq = ft_freqanalysis(cfg, dataLFP_base_1s);

plot (freq.freq(12:35), freq.powspctrm(12:35));
title ('Spectral power')
xlabel ('Frequency (Hz)')
ylabel ('absolute Power (uV²)')









