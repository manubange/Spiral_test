Matlab Code for the SpiralBeta paper. 
The main functions are determineThresh.m and betaBurstFeatures.m. 


## Installation guide
No installation required.
Download FieldTrip36 (https://www.fieldtriptoolbox.org/) and kinematics toolbox (http://www.diedrichsenlab.org/toolboxes/toolbox_kinematics.htm) and add them to the working directory in Matlab.


## Demo Instructions
To run the example scripts (spiral.m and determineBetaBursts.m), adjust the working directory and add the toolboxes to path
spiral.m loads a spiral drawn by a healthy person (spiral_JB1.mat)
determineBetaBursts.m loads 10 seconds of modelled electrophysiological data (LFP.mat)

Expected time to run:
spiral.m < 1 minute
determineBetaBursts.m < 1 minute

Expected output can be seen in
Powerspec.jpg
BetaBurstDetermination.jpg


## System requirements
Dependencies:
- FieldTrip36 (version 20220310, https://www.fieldtriptoolbox.org/) 
- Kinematics toolbox (http://www.diedrichsenlab.org/toolboxes/toolbox_kinematics.htm)

Tested with Matlab 9.11.0.1769968 (R2021b) and Fieldtrip36 (20220310) on a Centos7 (CentOS Linux release 7.9.2009 (Core)) Server and

Matlab xxx and Fieldtrip36 (20220310) on a Windows10 Desktop PC.
