# Forecast and write results to table
# 2020-01-22 T10:30 RT
library("forecast")

#iterate test data
results <- data.frame()
for (idx in 1:length(y.te)) {
  
  print(idx)
  # PREDICT NEW VALUE
  
  # ARIMA parameters
  (fit0 <- auto.arima(y_predicted))
  
  # Forecast horizont
  (fc0 <- forecast(fit0, h=1))
  
  # predicted value
  ( y_hat <- as.numeric(fc0$mean) )
  
  # real value
  ( y.te[idx] )
  
  # real and predicted value difference
  cat(difference <- (y.te[idx] - y_hat)^2)
  
  # append forecast to training set
  y_predicted <- c(y_predicted, y_hat)
  
  # get results
  result <-
    data.frame(
      x_orig = y.te[idx]
      , x_hat = y_hat
      , difference = abs(y.te[idx]-y_hat)
      , RMSE = Metrics::rmse(y.te[idx], y_hat)
    )
  
  # add results to table
  results <- rbind(results, result)
  
}

results

#forecast
plot(y_predicted, type = 'l')
lines(x, col = "blue")

