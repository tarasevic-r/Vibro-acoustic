#R.Tarsaevic 2019.12.23
#prognoze po 1 taska

library(rhdf5)
library(plotly)
library(graphics)
library(stats)
library(ggplot2)
library(lubridate)
library(forecast)
library(TTR)
library(dplyr)
library(fpp2)
library(TSA)
library(data.table)


rm(list=ls())
# load data
P =
  h5read("C:/users/user2/Desktop/T9_802_R3166.H5",
         
         "/promc.dataset.orig", bit64conversion="double")
dim(P)

# The selection of subsets of parameters on a time interval

# timestamp conversion from seconds to date and time
timestamp_date <- as_datetime(as.numeric(P$timestamp/1000000),tz="GMT-3")
P_with_date <- data.frame(timestamp_date,P$value)
# subset of the P parameter in the time interval
P_subset <- subset(P_with_date, timestamp_date > "2018-08-24 13:10:00"
                   & timestamp_date < "2018-08-24 13:20:00")
#plot_ly(x = P_subset$timestamp_date, y = P_subset$P.value, type = 'scatter', mode = 'lines')


x <- P_subset$P.value
ndiffs(x)

p <- periodogram(diff(x))

data.table(period=1/p$freq, spec=p$spec)[order(-spec)][1:2]
length(x)
# Train set
y <- ts(x[1:224])
y_predicted <- y

# Test set
y.te <- x[225:length(x)]
length(y.te)

#iterate test data
results <- data.frame()

for (idx in 1:length(y.te)) {
  # idx = 1
  print(idx)
  # PREDICT NEW VALUE
  #auto ARIMA
  (fit0 <- auto.arima(y))
  (bestfit <- list(aicc=fit0$aicc, i=0, j=0, fit=fit0))
  # Choose the best model by AIC
  for(i in 1:3) {
    for (j in 1:3){
      z1 <- fourier(ts(y, frequency=160), K=i)
      z2 <- fourier(ts(y, frequency=29.09091), K=j)
      fit <- auto.arima(y, xreg=cbind(z1, z2), seasonal=F)
      if(fit$aicc < bestfit$aicc) {
        bestfit <- list(aicc=fit$aicc, i=i, j=j, fit=fit)
      }
    }
  }
  bestfit
  
  fc <- forecast(bestfit$fit, 
                 xreg=cbind(
                   fourier(ts(y, frequency=160), K=bestfit$i, h=1),
                   fourier(ts(y, frequency=29.09091), K=bestfit$j, h=1), h=1))
  
  #predicted value
  ( y_hat <- as.numeric(fc$mean[1]) )
  #real value
  ( y.te[idx] )
  
  #real and predicted value difference
  # cat(difference <- (y.te[idx] - y_hat)^2)
  
  # append forecast to training set
  y_predicted <- c(y_predicted, y_hat)
  result <- data.frame(x_orig = y.te[idx], x_hat = y_hat, difference = abs(y.te[idx]-y_hat), RMSE = RMSE(y.te[idx], y_hat))  
  results <- rbind(results, result)
}

results

#forecast
plot(y_predicted, type = 'l')
lines(x, col = "orange")
rmse(x, y_predicted)
#check accuracy
accuracy(y_predicted[225:length(x)], y.te)
