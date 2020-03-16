library(tseries)
# ####
#
x <- as.numeric(df$timestamp)
y <- df$value
pts3 <- loess.smooth(x, y, span = 1/120)
pts2 <- loess.smooth(x, y, span = 1/60)
pts <- loess.smooth(x, y, span = 1/10)
plot(df)
lines(pts, col = 'yellow')
lines(pts2, col = 'red')
lines(pts3, col = 'blue')
summary(pts)
pts
plot(diff(log(pts3$y)), type = 'l')

kpss.test(diff(log(pts3$y)))

x <- rnorm(1000)
plot(x, type='l')
dx <- diff(x)

####
# URL: <https://www.statisticshowto.datasciencecentral.com/kpss-test/>
# A major disadvantage for the KPSS test is that it has a high rate of Type I errors (it tends to reject the null hypothesis too often). If attempts are made to control these errors (by having larger p-values), then that negatively impacts the test’s power.
# One way to deal with the potential for high Type I errors is to combine the KPSS with an ADF test. If the result from both tests suggests that the time series in stationary, then it probably is.
####

# ???
stopifnot(adf.test(x)$p.value < 0.05)

# ???
kpss.test(x, null = 'L')
kpss.test(x, null = 'T')
