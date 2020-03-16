#Empirical Mode Decomposition

library(rhdf5)
library(plotly)
library(graphics)
library(stats)
library(ggplot2)

P = h5read("C:/Users/user/Desktop/Nadezda/BF/BF8/F4/2018.03.29-2018.09.30/T9_802_R3166.H5", 
            "/promc.dataset.orig", bit64conversion="double") # specify a link to the required H5 file

# The selection of subsets of parameters on a time interval (2018.04.05 10:00:00-2018.04.05 11:00:00)
library(lubridate)
# timestamp conversion from seconds to date and time
timestamp_date <- as_datetime(as.numeric(P$timestamp/1000000),tz="GMT-2")
P_with_date <- data.frame(timestamp_date,P$value)
# subset of the P parameter in the time interval (2018.04.05 10:00:00-2018.04.05 11:00:00)
P_subset <- subset(P_with_date, timestamp_date > "2018-04-05 10:00:00" 
                    & timestamp_date < "2018-04-05 11:00:00")

#Emjpirical Mode Decomposition
library(EMD)
pemd<-emd(P_subset$P.value)
par(mfrow=c(1,3))
pemd<-emd(P_subset$P.value, plot.imf = TRUE) # plot all Decomposition (IMFs and Residues)
