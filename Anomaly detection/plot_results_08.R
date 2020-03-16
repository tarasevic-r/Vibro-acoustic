# plot results
# 2020-01-22 T11:18 RT

# Select columns
not_anomaly <- as.data.frame(not_anom[,1:2])

# make differences
x <- as_datetime(not_anomaly$date[2:length(not_anomaly$date)])
y <- diff(not_anomaly$observed)


# data set with differences
df_new <- cbind(x, y)

# plot results
par(mfrow=c(2,1))
plot(x = x, y = normalize(y)
     , type = 'l'
     , col = 'gold'
     , xlab = 'time'
     , ylab = 'value'
     , main = 'without anomalies')

plot(date[2:length(date)], normalize(diff(subset$value))
     , type = 'l'
     , col = "darkseagreen3"
     , xlab = 'time'
     , ylab = 'value'
     , main = 'raw data')
