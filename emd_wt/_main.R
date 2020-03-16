#2020-02-25 T13:30
#R.T

# Generate signal
source("generate-signal.R")

# User functinos
source("user-functions.R")

f_input = 25

# Signals spectrogram
source("spectrogram.R")


# Frequencies partial to...
source("partial_freq.R")

# Wavelet decomposition (Daubechie 4)
source("wavelet_decomposition.R")
dev.off()

# extract partial frequencies of main signal from different WD levels  
source("WD_levels_partial_freq.R")


# Select family by Shannon entropy
source("family_selection.R")

par(bg='lightgrey')
# calculate different frequency sub-bands energy
source("sub-band_energy.R")
source("sub-band_energy2.R") # calculate "Manhattan" distance
source("sub-band_statistics.R")
# WD, threshold, basis selection and reconstruction
source("wd_threshold_basis_reconstruct.R")

# ?????????
# source("test.R")


# 
# Pre-emphasis is needed because high
# frequency components of the speech
# signal have small amplitude with respect
# to low frequency components.
# This process will increase
# the energy of signal at higher
# frequency

