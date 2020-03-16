# EMD vs FFT
# 2020-01-15 T18:59 RT

# Clean up
rm(list=ls())
par(mfrow=c(1,1))

## Task
source('task.R')

## Generate signal, s1 (10hz), s2 (20hz), s3 (40hz)
source('data_generation.R')

source('normalize.R')

## Generate random noise 
source('random_noise.R') # Generate to different noises

# Add noise to original signal
## compare both signals
source('noise_adding.R')

## FFT
source('fft.R')

## FFT filter
# source('fft_filter.R')

# EMD calculation and number of IMF's
source('EMD.R')

# main frequencies
source('test main harmonics.R')
# calculate main coeficient
# get indexes of main coeficients
# sums of magnitudes 

## Inverse FFT
source('inverse_fft.R')
# calculate inverse FFT
# plot results

####
# We can easily restore original signal with added noise
# that consist only 1 main frequency using FFT
# and we can restore original signal with more than one main frequency with 
# added noise if we know original signals main frequencies.
####
