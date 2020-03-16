## Literature
# https://www.researchgate.net/publication/302633657_A_New_Wavelet_Threshold_Function_and_Denoising_Application

## Time series denoising with Haar wavelet (Levels 1 & 2 & 3)
library(rhdf5)
library(plotly)
library(graphics)
library(stats)
library(ggplot2)

P = h5read("C:/Users/user/Desktop/Nadezda/BF/BF8/F4/2018.03.29-2018.09.30/T9_802_R3166.H5", 
           "/promc.dataset.orig", bit64conversion="double")
# The selection of subsets of parameters on a time interval
library(lubridate)
# timestamp conversion from seconds to date and time
timestamp_date <- as_datetime(as.numeric(P$timestamp/1000000),tz="GMT-3")
P_with_date <- data.frame(timestamp_date,P$value)
# subset of the P parameter in the time interval
P_subset <- subset(P_with_date, timestamp_date > "2018-04-23 16:00:00" 
                   & timestamp_date < "2018-04-23 17:00:00")
# Interpolation every n seconds (Please, indicate a needed number of seconds)
library(zoo)
subb<-data.frame(seq(P_subset$timestamp_date[1], tz="GMT-3",     
                     P_subset$timestamp_date[nrow(P_subset)], tz="GMT-3", 
                     by = 2)) # indicate a needed number of seconds
colnames(subb)[1] <- "timestamp_date"
subb<-cbind(subb, value = c(1:nrow(subb)))
P_subb<-merge(subb, P_subset, by='timestamp_date', all=TRUE)
# linear interpolation of values
P_subb[,3]<-c(na.approx(P_subb$P.value, na.rm=FALSE))
# delete rows with missing values NA 
P_sub_int<-P_subb[rowSums(is.na(P_subb)) == 0,] 
# values of time series are added by zeros till the close time series length multiple of 2
n<-nrow(P_sub_int)
v<-P_sub_int$P.value
for (m in 1:30){
  if (n <= 2^m){g<-2^m-n
  for (j in 1:(n+g)){
    if (j<=n){v[j]<-v[j]}
    else {v[j]<-0}}
  break} 
  else {m<-m+1}
}
n<-n+g
#Time series denoising with Haar wavelet (Levels 1 & 2 & 3)
#HARD THRESHOLD
#Level 1
library(wavelets)
pdwt<-dwt(v, filter="haar", n.levels = 1)
par(mfrow=c(1,1))
threshold1<-sd(pdwt@W[["W1"]])*sqrt(2*log2(length(pdwt@W[["W1"]])))
for(i in 1:(length(pdwt@W[["W1"]]))){
  if (abs(pdwt@W[["W1"]][i]) > threshold1){pdwt@W[["W1"]][i]<-pdwt@W[["W1"]][i]}
  if (abs(pdwt@W[["W1"]][i]) <= threshold1){pdwt@W[["W1"]][i]<-0}
}
pidwt<-idwt(pdwt) # Inverse Discrete Wavelet Transform
plot(P_sub_int$timestamp_date, P_sub_int$P.value, type = "l", col = "blue")# orig
points(P_sub_int$timestamp_date, pidwt[1:(n-g)], type = "l", col="orange")# approx. with W1 tresholding

#Level 2
library(wavelets)
pdwt<-dwt(v, filter="haar", n.levels = 2)
par(mfrow=c(1,1))
threshold1<-sd(pdwt@W[["W1"]])*sqrt(2*log2(length(pdwt@W[["W1"]])))
for(i in 1:(length(pdwt@W[["W1"]]))){
  if (abs(pdwt@W[["W1"]][i]) > threshold1){pdwt@W[["W1"]][i]<-pdwt@W[["W1"]][i]}
  if (abs(pdwt@W[["W1"]][i]) <= threshold1){pdwt@W[["W1"]][i]<-0}
}
threshold2<-sd(pdwt@W[["W2"]])*sqrt(2*log2(length(pdwt@W[["W2"]])))
for(i in 1:(length(pdwt@W[["W2"]]))){
  if (abs(pdwt@W[["W2"]][i]) > threshold2){pdwt@W[["W2"]][i]<-pdwt@W[["W2"]][i]}
  if (abs(pdwt@W[["W2"]][i]) <= threshold2){pdwt@W[["W2"]][i]<-0}
}
pidwt<-idwt(pdwt) # Inverse Discrete Wavelet Transform
plot(P_sub_int$timestamp_date, P_sub_int$P.value, type = "l", col = "blue")# orig
points(P_sub_int$timestamp_date, pidwt[1:(n-g)], type = "l", col="orange")# approx. with W1,W2 tresholding

#Level 3
library(wavelets)
pdwt<-dwt(v, filter="haar", n.levels = 3)
par(mfrow=c(1,1))
threshold1<-sd(pdwt@W[["W1"]])*sqrt(2*log2(length(pdwt@W[["W1"]])))
for(i in 1:(length(pdwt@W[["W1"]]))){
  if (abs(pdwt@W[["W1"]][i]) > threshold1){pdwt@W[["W1"]][i]<-pdwt@W[["W1"]][i]}
  if (abs(pdwt@W[["W1"]][i]) <= threshold1){pdwt@W[["W1"]][i]<-0}
}
threshold2<-sd(pdwt@W[["W2"]])*sqrt(2*log2(length(pdwt@W[["W2"]])))
for(i in 1:(length(pdwt@W[["W2"]]))){
  if (abs(pdwt@W[["W2"]][i]) > threshold2){pdwt@W[["W2"]][i]<-pdwt@W[["W2"]][i]}
  if (abs(pdwt@W[["W2"]][i]) <= threshold2){pdwt@W[["W2"]][i]<-0}
}
threshold3<-sd(pdwt@W[["W3"]])*sqrt(2*log2(length(pdwt@W[["W3"]])))
for(i in 1:(length(pdwt@W[["W3"]]))){
  if (abs(pdwt@W[["W3"]][i]) > threshold3){pdwt@W[["W3"]][i]<-pdwt@W[["W3"]][i]}
  if (abs(pdwt@W[["W3"]][i]) <= threshold3){pdwt@W[["W3"]][i]<-0}
}
pidwt<-idwt(pdwt) # Inverse Discrete Wavelet Transform
plot(P_sub_int$timestamp_date, P_sub_int$P.value, type = "l", col = "blue")# orig
points(P_sub_int$timestamp_date, pidwt[1:(n-g)], type = "l", col="orange")# approx. with W1,W2 tresholding

#Time series denoising with Haar wavelet (Levels 1 & 2 & 3)
#SOFT THRESHOLD
#Level 1
library(wavelets)
pdwt<-dwt(v, filter="haar", n.levels = 1)
par(mfrow=c(1,1))
threshold1<-sd(pdwt@W[["W1"]])*sqrt(2*log2(length(pdwt@W[["W1"]])))
for(i in 1:(length(pdwt@W[["W1"]]))){
  if (abs(pdwt@W[["W1"]][i]) > threshold1){pdwt@W[["W1"]][i]<-sign(pdwt@W[["W1"]][i])*(abs(pdwt@W[["W1"]][i])-threshold1)}
  if (abs(pdwt@W[["W1"]][i]) <= threshold1){pdwt@W[["W1"]][i]<-0}
}
pidwt<-idwt(pdwt) # Inverse Discrete Wavelet Transform
plot(P_sub_int$timestamp_date, P_sub_int$P.value, type = "l", col = "blue")# orig
points(P_sub_int$timestamp_date, pidwt[1:(n-g)], type = "l", col="orange")# approx. with W1 tresholding

#Level 2
library(wavelets)
pdwt<-dwt(v, filter="haar", n.levels = 2)
par(mfrow=c(1,1))
threshold1<-sd(pdwt@W[["W1"]])*sqrt(2*log2(length(pdwt@W[["W1"]])))
for(i in 1:(length(pdwt@W[["W1"]]))){
  if (abs(pdwt@W[["W1"]][i]) > threshold1){pdwt@W[["W1"]][i]<-sign(pdwt@W[["W1"]][i])*(abs(pdwt@W[["W1"]][i])-threshold1)}
  if (abs(pdwt@W[["W1"]][i]) <= threshold1){pdwt@W[["W1"]][i]<-0}
}
threshold2<-sd(pdwt@W[["W2"]])*sqrt(2*log2(length(pdwt@W[["W2"]])))
for(i in 1:(length(pdwt@W[["W2"]]))){
  if (abs(pdwt@W[["W2"]][i]) > threshold2){pdwt@W[["W2"]][i]<-sign(pdwt@W[["W2"]][i])*(abs(pdwt@W[["W2"]][i])-threshold2)}
  if (abs(pdwt@W[["W2"]][i]) <= threshold2){pdwt@W[["W2"]][i]<-0}
}
pidwt<-idwt(pdwt) # Inverse Discrete Wavelet Transform
plot(P_sub_int$timestamp_date, P_sub_int$P.value, type = "l", col = "blue")# orig
points(P_sub_int$timestamp_date, pidwt[1:(n-g)], type = "l", col="orange")# approx. with W1,W2 tresholding

#Level 3
library(wavelets)
pdwt<-dwt(v, filter="haar", n.levels = 3)
par(mfrow=c(1,1))
threshold1<-sd(pdwt@W[["W1"]])*sqrt(2*log2(length(pdwt@W[["W1"]])))
for(i in 1:(length(pdwt@W[["W1"]]))){
  if (abs(pdwt@W[["W1"]][i]) > threshold1){pdwt@W[["W1"]][i]<-sign(pdwt@W[["W1"]][i])*(abs(pdwt@W[["W1"]][i])-threshold1)}
  if (abs(pdwt@W[["W1"]][i]) <= threshold1){pdwt@W[["W1"]][i]<-0}
}
threshold2<-sd(pdwt@W[["W2"]])*sqrt(2*log2(length(pdwt@W[["W2"]])))
for(i in 1:(length(pdwt@W[["W2"]]))){
  if (abs(pdwt@W[["W2"]][i]) > threshold2){pdwt@W[["W2"]][i]<-sign(pdwt@W[["W2"]][i])*(abs(pdwt@W[["W2"]][i])-threshold2)}
  if (abs(pdwt@W[["W2"]][i]) <= threshold2){pdwt@W[["W2"]][i]<-0}
}
threshold3<-sd(pdwt@W[["W3"]])*sqrt(2*log2(length(pdwt@W[["W3"]])))
for(i in 1:(length(pdwt@W[["W3"]]))){
  if (abs(pdwt@W[["W3"]][i]) > threshold3){pdwt@W[["W3"]][i]<-sign(pdwt@W[["W3"]][i])*(abs(pdwt@W[["W3"]][i])-threshold3)}
  if (abs(pdwt@W[["W3"]][i]) <= threshold3){pdwt@W[["W3"]][i]<-0}
}
pidwt<-idwt(pdwt) # Inverse Discrete Wavelet Transform
plot(P_sub_int$timestamp_date, P_sub_int$P.value, type = "l", col = "blue")# orig
points(P_sub_int$timestamp_date, pidwt[1:(n-g)], type = "l", col="orange")# approx. with W1,W2,W3 tresholding
