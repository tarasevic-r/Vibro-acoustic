# FFT training
# URL: https://anomaly.io/detect-seasonality-using-fourier-transform-r/
# check-frequency.R
# 2020-01-09T1908 AU

library('TSA')

x <- c(1,0,0,0)

plot(x,xlab='Day')
TSA::periodogram(x,ylab='Periodogram')
abline(h=0)

stats::fft(x) / length(x)

# compute the periodogram
p <- TSA::periodogram(x)

p$freq[p$spec > 0.05]

dd = data.frame(freq=p$freq, spec=p$spec)
order = dd[order(-dd$spec),]
top_freq = head(order, 5)

# display the 2 highest "power" frequencies
top_freq

# convert frequency to time periods
time = 1/top_freq$f
time
