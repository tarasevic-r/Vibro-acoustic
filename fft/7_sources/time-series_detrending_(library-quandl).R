# file:///C:/AU/books/fft/Fourier%20Transform%20%20A%20R%20Tutorial.html

## QUANDL example


library(zoo)

library('Quandl')

# prices <- read.csv("retailgas.csv")       # weekly prices (1 Hz = 1 Week)
prices <- Quandl("EIA/PET_EMM_EPM0_PTE_NUS_DPG_W", api_key="kJQM9aBzVZyeLQQdRkxs")
prices <- prices[order(nrow(prices):1),]  # revert data frame

dates <- prices$Date[1:256]
values <- query

df <-
  data.frame(
    cbind(
  Date = prices$Date[1:256]
, Value = query
)
)

head(df)

df$Date <- as.Date(df$Date)

head(df)

plot(df, type="l")

trend <- lm(Value ~ Date, data = df)
abline(trend, col="red")

detrended.trajectory <- trend$residuals
plot(detrended.trajectory, type="l", main="detrended time series")



f.data <- TSA::periodogram(detrended.trajectory)
harmonics <- 1:20
plot(
  f.data$freq[harmonics]*length(detrended.trajectory)
  , f.data$spec[harmonics]/sum(f.data$spec)
  , xlab="Harmonics (Hz)"
  , ylab="Amplitute Density"
  , type="h"
)


which(f.data$spec[harmonics]/sum(f.data$spec) > 0.04)

