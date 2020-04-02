rm(list=ls())
#### LOAD DATA ####

# load user functions
source("user-functions.R")

#read wav file
vibration = F # set T for vibration data
audio = "signal_1" # change "signal_1" to save different graphs
name = "../../data/audio/graztas.wav" # audio signal name
graph = FALSE # plot original signal? TRUE/FALSE
source('read_audio.R')




#### LOAD DATA FROM FILE LIST ####
# # get file names
# source("Generate_file_names.R")
# 
# # Load data
# source("load_data.R")

#### read rhdf5 file
# source("load_rhdf5.R")


#### WAVELET PARAMETERS ####
# select wavelet decomposition level 
source("wavelet_parameters_selection.R")


#### ENERGY CALCULATION ####
# calculate wavelet decomposition energy (u-th level)
source("energy_calculation.R")
# cluster sub-band energy
source("sub-band_energy_clustering.R")
# mean category calculation
source("Mean_category.R")


#### CLUSTERING ####
# Final clustering results
source("energy_classification.R")
# Final clustering results
dev.off()
# calculate distance between energy samples calculated above (exported to .csv)
# source("energy_distance.R")




