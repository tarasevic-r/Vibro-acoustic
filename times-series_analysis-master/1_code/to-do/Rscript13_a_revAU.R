#Discrete Wavelet Transform with Haar wavelet (Levels 1 & 2)

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

# Interpolation every n seconds (Please, indcate needed number of seconds below)
library(zoo)
subb<-data.frame(seq(P_subset$timestamp_date[1], tz="GMT-3",     
                     P_subset$timestamp_date[nrow(P_subset)], tz="GMT-3", 
                     by = 2)) # indcate needed number of seconds
colnames(subb)[1] <- "timestamp_date"
subb<-cbind(subb, value = c(1:nrow(subb)))
P_subb<-merge(subb, P_subset, by='timestamp_date', all=TRUE)
# linear interpolation of values
P_subb[,3]<-c(na.approx(P_subb$P.value, na.rm=FALSE))
# delete rows with missing values NA 
P_sub_int<-P_subb[rowSums(is.na(P_subb)) == 0,] 
n<-nrow(P_sub_int)
v<-P_sub_int$P.value
# values of time series are added by zeros till the close time series length multiple of 2
for (m in 1:30){
  if (n <= 2^m){g<-2^m-n
  for (j in 1:(n+g)){
    if (j<=n){v[j]<-v[j]}
    else {v[j]<-0}}
  break} 
  else {m<-m+1}
}
n<-n+g
#Wavelet decomposition (Haar)
#Level 1
library(wavelets)
pdwt<-dwt(v, filter="haar", n.levels = 1)
v1<-rep(pdwt@V[["V1"]], each=2)
v1<-v1/sqrt(2)
w1<-rep(pdwt@W[["W1"]], each=2)
for (i in 1:(length(w1)/2)){
  w1[2*i]<-(-1)*w1[2*i]
}
w1<-w1/sqrt(2)
par(mfrow=c(3,1))
plot(P_sub_int$timestamp_date, P_sub_int$P.value, type = "l", col = "blue")# orig
plot(v1[1:(n-g)], type = "l", col="orange")# V1 approx.
plot(w1[1:(n-g)], type = "l", col="red")# W1 details
#Level 2
library(wavelets)
pdwt<-dwt(v, filter="haar", n.levels = 2)
v2<-rep(pdwt@V[["V2"]], each=4)
v2<-v2/2
w1<-rep(pdwt@W[["W1"]], each=2)
for (i in 1:(length(w1)/2)){
  w1[2*i]<-(-1)*w1[2*i]
}
w1<-w1/sqrt(2)
w2<-rep(pdwt@W[["W2"]], each=4)
for (i in 1:(length(w2)/4)){
  w2[3*i]<-(-1)*w2[3*i]
  w2[4*i]<-(-1)*w2[4*i]
}
w2<-w2/2
par(mfrow=c(3,1))
plot(P_sub_int$timestamp_date, P_sub_int$P.value, type = "l", col = "blue")
plot(v2[1:(n-g)], type = "l", col="orange")
plot(w1[1:(n-g)], type = "l", col="red")
points(w2[1:(n-g)], type = "l", col="green")
