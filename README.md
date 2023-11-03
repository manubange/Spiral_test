# Matlab Code for the SpiralBeta paper.  
The function determineThresh.m defines the beta amplitude threshold (defined as 75 percentile of the amplitude distribution).  
The function betaBurstFeatures.m extracts burst amplitude, duration, and number of bursts of a given segment of electrophysiological data.    
Example data are provided in /data  

# Installation guide
No installation required. 
Download FieldTrip36 (https://www.fieldtriptoolbox.org/) and kinematics toolbox (http://www.diedrichsenlab.org/toolboxes/toolbox_kinematics.htm) and add them to the working directory in Matlab.


# Demo Instructions
To run the example scripts (spiral.m and determineBetaBurstsPatxx.m), adjust the working directory and add the toolboxes to path  
spiral.m loads a spiral drawn by a studyparticipant (Spiral_patxx.mat), healthy person (Spiral_HC.mat), or a modelled spiral.  
determineBetaBurstsPatxx.m calculates burst characteristics of one example dataset (LFP_patxx.mat).  
determineBetaBursts.m loads 10 seconds of modelled electrophysiological data (LFP.mat)

Expected time to run:  
- spiral.m < 1 minute
- determineBetaBurstsPatxx.m < 1 minute   
- determineBetaBursts.m < 1 minute   

Expected output can be seen in   
- SpiralPatxx.jpg, SpiralHC.jpg, and SpiralModel.jpg  
- PowerspecRest-Draw.jpg and Powerspec.jpg  
- BetaBurstDrawing.jpg and BetaBurstDetermination.jpg  


# System requirements
Dependencies:
- FieldTrip36 (version 20220310, https://www.fieldtriptoolbox.org/) 
- Kinematics toolbox (http://www.diedrichsenlab.org/toolboxes/toolbox_kinematics.htm)


Tested with Matlab 9.11.0.1769968 (R2021b) and Fieldtrip36 (20220310) on a Centos7 (CentOS Linux release 7.9.2009 (Core)) Server and   
Matlab 9.13.0.2049777 (R2022b) and Fieldtrip36 (20220310) on a Windows10 home desktop PC.
