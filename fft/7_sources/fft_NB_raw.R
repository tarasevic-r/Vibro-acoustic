#FFT

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

# Interpolation every n seconds (Please, indicate the needed quantity of seconds below)
library(zoo)
P_subset_int<-data.frame(seq(P_subset$timestamp_date[1], tz="GMT-2",     
                             P_subset$timestamp_date[nrow(P_subset)], tz="GMT-2", 
                             by = 5)) # indicate the needed quantity of seconds!!!
colnames(P_subset_int)[1] <- "timestamp_date"
P_subset_int<-cbind(P_subset_int, value = c(1:nrow(P_subset_int)))
P_subset_int1<-merge(P_subset_int, P_subset, by='timestamp_date', all=TRUE)

# linear interpolation of values
P_subset_int1[,3]<-c(na.approx(P_subset_int1$P.value, na.rm=FALSE))
# delete rows with missing values NA 
P_sub_int<-P_subset_int1[rowSums(is.na(P_subset_int1)) == 0,] 

timesub <- as.numeric(as.POSIXct(P_subset$timestamp_date),origin="1970-01-01")*1000000
subP <- data.frame(timesub,P_subset$P.value)
h1<-subP$timesub[2:nrow(subP)]
hn<-subP$timesub[1:nrow(subP)-1]
hd<-(h1-hn)/1000000
hsd<-1/min(hd)
n<-nrow(subP)
v<-subP$P_subset.P.value
for (m in 1:30){
  if (n <= 2^m){g<-2^m-n
  for (j in 1:(n+g)){
    if (j<=n){v[j]<-v[j]}
    else {v[j]<-0}}
  break} 
  else {m<-m+1}
}
n<-n+g
n
Hs1=(0:((n/2)/2-1))*hsd/(n/2)
Z1<-fft(v)
Z1<-Z1[1:((n/2)/2)]
Z1s<-abs(Z1)
hss<-cbind.data.frame(Hs1,Z1s)
phss<-plot_ly(x=hss$Hs1,y=hss$Z1s,mode="lines")
phss
