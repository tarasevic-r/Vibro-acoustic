# Title: Spectral Analysis of Time Series with R
# Review: 2020-01-07T0926 AU


## Loading the data

# Load in the nino3 sea surface temperature data.
# These data are an average of monthly sea surface temperatures over the East Equatorial Pacific.

nino <-
  read.table(
    "../2_raw-data/nino3data.asc"
    , skip = 3
  )

names(nino) <- c("Year", "SST", "SSA")

## Plot data
plot(
  nino$Year
  , nino$SST
  , type = "l"
)


# library('ggplot2')
par(mfrow=c(2,1))
plot1 <- ggplot2::ggplot(data = nino) + geom_line(aes(y = SST, x = Year))
plot2 <- ggplot2::ggplot(data = nino) + geom_line(aes(y = SSA, x = Year))
# library('gridExtra')
gridExtra::grid.arrange(plot1, plot2)

# plot of chunk simpleplot plot of chunk simpleplot
# Autocorrelation plots

acf1 <- acf(nino$SST, lag.max = 12 * 20, plot = F)
acf2 <- acf(nino$SSA, lag.max = 12 * 20, plot = F)
plot1 <- ggplot() + geom_line(aes(x = c(acf1$lag)/12, y = c(acf1$acf)))
plot2 <- ggplot() + geom_line(aes(x = c(acf2$lag)/12, y = c(acf2$acf)))
grid.arrange(plot1, plot2)
# plot of chunk unnamed-chunk-1


## Harmonic Regression ####


# The purpose of spectral analysis is to decompose a time series into periodic components. We might consider doing this with a regression, where we regress the time series on a set of sine and cosine waves. For a dataset with annual variation, we might expect that the sine and cosine waves with one year might be important, but what other waves might be present in this time series?

# Let's try a “harmonic regression'' in which we regress the time series on harmonics (waves). I've included here annual harmonics, as well as other harmonics, some of which I think might duplicate the El Nino/La Nina cycle around 3-6 years.

# Create dataframe with different harmonics
X <- data.frame(
  Year=nino$Year,
  y = nino$SST,
  sin(2*pi*1*nino$Year), cos(2*pi*1*nino$Year), # sine and cos for frequency = 1
  sin(2*pi*2*nino$Year), cos(2*pi*2*nino$Year), # freq. equals 2 (i.e. period= 6 months)
  sin(2*pi*1/3*nino$Year), cos(2*pi*1/3*nino$Year), # freq = 1/3 (period=3 years)
  sin(2*pi*1/3.5*nino$Year), cos(2*pi*1/3.5*nino$Year), # freq=3.5 (period=3.5 years)
  sin(2*pi*1/6*nino$Year), cos(2*pi*1/6*nino$Year),   # freq=6 (period=6 years)
  sin(2*pi*1.01*nino$Year), cos(2*pi*1.01*nino$Year) # freq=1.01 (period=.99 years)
)
ggplot(data=subset(X, Year>1980)) + geom_line(aes(x=Year, y=X[X$Year>1980,3]))

# plot of chunk unnamed-chunk-2

ggplot(data=subset(X, Year>1980)) + geom_line(aes(x=Year, y=X[X$Year>1980,5]))

# plot of chunk unnamed-chunk-2

ggplot(data=subset(X, Year>1980)) + geom_line(aes(x=Year, y=X[X$Year>1980,7]))

# plot of chunk unnamed-chunk-2

ggplot(data=subset(X, Year>1980)) + geom_line(aes(x=Year, y=X[X$Year>1980,9]))

# plot of chunk unnamed-chunk-2

ggplot(data=subset(X, Year>1980)) + geom_line(aes(x=Year, y=X[X$Year>1980,11]))

# plot of chunk unnamed-chunk-2

# Now that we've created a dataframe that has sines and cosines, we might see how well these predict the data series. We might regress SST on these sines and cosines.

mod <-
  lm(
    y ~ . - Year
    , data = X
  )  # Regress y on everything (but Year)
summary(mod)

##
## Call:
## lm(formula = y ~ . - Year, data = X)
##
## Residuals:
##     Min      1Q  Median      3Q     Max
## -2.0478 -0.5220 -0.0544  0.4492  2.7313
##
## Coefficients:
##                                 Estimate Std. Error t value Pr(>|t|)
## (Intercept)                      25.7119     0.0193 1331.89  < 2e-16 ***
## sin.2...pi...1...nino.Year.       1.2815     0.0281   45.68  < 2e-16 ***
## cos.2...pi...1...nino.Year.      -0.2815     0.0275  -10.24  < 2e-16 ***
## sin.2...pi...2...nino.Year.      -0.1903     0.0277   -6.88  8.7e-12 ***
## cos.2...pi...2...nino.Year.      -0.2229     0.0269   -8.27  2.9e-16 ***
## sin.2...pi...1.3...nino.Year.     0.0984     0.0272    3.61  0.00031 ***
## cos.2...pi...1.3...nino.Year.    -0.0625     0.0273   -2.29  0.02235 *
## sin.2...pi...1.3.5...nino.Year.  -0.1047     0.0273   -3.84  0.00013 ***
## cos.2...pi...1.3.5...nino.Year.  -0.1915     0.0273   -7.01  3.5e-12 ***
## sin.2...pi...1.6...nino.Year.    -0.0290     0.0273   -1.06  0.28857
## cos.2...pi...1.6...nino.Year.     0.0632     0.0273    2.32  0.02074 *
## sin.2...pi...1.01...nino.Year.   -0.0296     0.0278   -1.07  0.28586
## cos.2...pi...1.01...nino.Year.    0.0203     0.0278    0.73  0.46517
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 0.752 on 1505 degrees of freedom
## Multiple R-squared:  0.622,  Adjusted R-squared:  0.619
## F-statistic:  206 on 12 and 1505 DF,  p-value: <2e-16

# What's significant? The 1 year frequency is, but not the 1.01. The twice a year frequency is. The 3, 3.5 and 6 year frequenceis are significant. I tried other "El Nino frequencies” too, but they weren't always significant. For example, 4 years was not significant. This trial and error approach is difficult!

X$resid <- residuals(mod)
X$pred <- predict(mod)
ggplot(data = subset(X, Year > 1970)) + geom_line(aes(x = Year, y = y)) + geom_line(aes(x = Year,
                                                                                        y = pred), color = "red")

# plot of chunk unnamed-chunk-4

# We've described the annual variation pretty well. But we haven't picked up a lot of the year-to-year variation.
# Frequency analysis.

# I could extend this regression. If I have N data, and I include N sines and cosines, then my regression will perfectly predict the data. The regression will be overfitted. But I might learn something be seeing which coefficients are significantly different from zero. This is what the “periodogram” tells us.

x11()
raw.spec <-
  spec.pgram(
    nino$SST
    , taper = 0
  )

# plot of chunk unnamed-chunk-5

plot(raw.spec)
plot(raw.spec, log = "no")

# plot of chunk unnamed-chunk-5

# spec.df <- as.data.frame(raw.spec)
spec.df <- data.frame(freq = raw.spec$freq, spec = raw.spec$spec)
# Create a vector of periods to label on the graph, units are in years
yrs.period <- rev(c(1/6, 1/5, 1/4, 1/3, 0.5, 1, 3, 5, 10, 100))
yrs.labels <- rev(c("1/6", "1/5", "1/4", "1/3", "1/2", "1", "3", "5", "10", "100"))
yrs.freqs <- 1/yrs.period * 1/12  #Convert annual period to annual freq, and then to monthly freq
spec.df$period <- 1/spec.df$freq
ggplot(data = subset(spec.df)) + geom_line(aes(x = freq, y = spec)) + scale_x_continuous("Period (years)",
                                                                                         breaks = yrs.freqs, labels = yrs.labels) + scale_y_continuous()

# plot of chunk unnamed-chunk-6

# Sometimes the log scaling of the spectrum is more revealing:

ggplot(data = subset(spec.df)) + geom_line(aes(x = freq, y = spec)) + scale_x_continuous("Period (years)", breaks = yrs.freqs, labels = yrs.labels) + scale_y_log10()
# plot of chunk unnamed-chunk-7

# The log-scaling has some theoretical advantages, too. The periodogram values should be approximately normally distributed in the log scale.

# I could clean up the labels at the left end, but sometimes a log scaling can be helpful there, too, because as log scaling will spread out the low frequencies and squish the high frequencies:

ggplot(data = subset(spec.df)) +
  geom_line(aes(x = freq, y = spec)) +
  scale_x_log10(
    "Period (years)"
    , breaks = yrs.freqs
    , labels = yrs.labels
  ) +
  scale_y_log10()

# plot of chunk unnamed-chunk-8

# Typically, it is the relatively low frequency stuff that is the most interesting. And also the most challenging to resolve. (The overlap of interesting and challenging is not mere concidence. If it were easy, we know all about it and it would stop being interesting!)
# Smoothing the periodogram:

# There is a fundamental problem with the periodogram. Unlike most estimates you've encountered, such as the mean or a regression coefficient, which get more reliable as you collect more data, the periodogram does not get more reliable. As you collect more data, you add more periodogram points, but they are all just as noisy as before.

# We are assuming that there is some underlying curve of spectral values, and that the periodogram estimates this. But the periodogram is noisy, and will always be noisy. We call this underlying curve the “spectral density function,” or sometimes the “power spectrum.”

# The only way to get smooth estimates of the power spectrum is by taking moving averages of the periodogram. In essence, though, we want to give more weight to close frequencies, and little weight to far away frequencies. There are different ways to create weights. You could use a bell curve shape to give weights. You could use a triangle, or a rectangle. There are lots of others too. These are called 'kernel functions.'

plot(kernel("daniell", m = 10))  # A short moving average

# plot of chunk unnamed-chunk-9

plot(kernel("daniell", m = 50))  # A long moving average

# plot of chunk unnamed-chunk-9

plot(kernel("daniell", c(5, 5)))  # m=5 moving average of a m=5 moving average

# plot of chunk unnamed-chunk-9

plot(kernel("daniell", c(5, 5, 5)))  # a m=5 moving average of that!

# plot of chunk unnamed-chunk-9

plot(kernel("daniell", c(5, 5, 5, 5)))  # a m=5 moving average of that!

# plot of chunk unnamed-chunk-9

plot(kernel("daniell", c(9, 9, 9)))

# plot of chunk unnamed-chunk-9

plot(kernel("daniell", c(3, 3, 21)))

# plot of chunk unnamed-chunk-9

k = kernel("daniell", c(9, 9, 9))

smooth.spec <-
  spec.pgram(
    nino$SST
    , kernel = k
    , taper = 0
  )

# plot of chunk unnamed-chunk-9


# Note how the confidence interval got much narrower

spec.df <- data.frame(freq = smooth.spec$freq, `c(9,9,9)` = smooth.spec$spec)
names(spec.df) <- c("freq", "c(9,9,9)")
# Add other smooths
k <- kernel("daniell", c(9, 9))
spec.df[, "c(9,9)"] <- spec.pgram(nino$SST, kernel = k, taper = 0, plot = FALSE)$spec
k <- kernel("daniell", c(9))
spec.df[, "c(9)"] <- spec.pgram(nino$SST, kernel = k, taper = 0, plot = FALSE)$spec


# melt from wide format into long format
library('reshape2')
spec.df <-
  reshape2::melt(
    spec.df
    , id.vars = "freq"
    , value.name = "spec"
    , variable.name = "kernel"
  )
plot1 <-
  ggplot(data = subset(spec.df)) +
  geom_path(
    aes(
      x = freq
      , y = spec
      , color = kernel
      )
    ) +
  scale_x_continuous(
    "Period (years)"
    , breaks = yrs.freqs
    , labels = yrs.labels
    ) +
  scale_y_log10()

plot2 <- ggplot(data = subset(spec.df)) + geom_path(aes(x = freq, y = spec,
                                                        color = kernel)) + scale_x_log10("Period (years)", breaks = yrs.freqs, labels = yrs.labels) +
  scale_y_log10()

grid.arrange(plot1, plot2)

# plot of chunk unnamed-chunk-9

# When you smooth the periodogram, then the log spacing on frequency is less necessary.

# It is unsurprising that smoothing is a good thing when the true spectral density is smooth, and smoothing is a bad thing when the true spectral density is not smooth. Here, smoothing seems to be a good thing everywhere except for the annual frequency, and it's harmonics. The spikes probably shouldn't be smoothed, but it is what it is.

# What if we repeat with SSA?

k = kernel("daniell", c(9, 9, 9))
smooth.spec <- spec.pgram(nino$SSA, kernel = k, taper = 0, plot = FALSE)
# spec.df <- as.data.frame(smooth.spec)
spec.df <- data.frame(freq = smooth.spec$freq, spec = smooth.spec$spec)
ggplot(data = subset(spec.df)) + geom_line(aes(x = freq, y = spec)) + scale_x_continuous("Period (years)",
                                                                                         breaks = yrs.freqs, labels = yrs.labels) + scale_y_continuous()

# plot of chunk unnamed-chunk-10
# The effect of tapering

# Besides windowing, there is one other 'trick' commonly done when spectral estimating, called tapering. Before describing tapering, let's discuss the problem.

# When you estimate a periodogram, you are implicitly making the assumption that your time series is circular, i.e. that you could wrap the time series around and just keep time marching on until infinity. Obviously, this isn't so. If you wrap the time series around, there will be a jump where the end meets the start again. This jump is spurious, but it will propagate itself through all the frequencies, contaminating them.

# The solution is to downweight the beginning and end of the data. This way, when you calculate the periodogram, you'll be giving more weight to the middle, and less weight to the ends. There is still the jump at the end, but it has very little weight, so it's effect is diminished. This downweighting is called tapering. But how much do you downweight? 5% at each end? 10%? 50% (i.e. the whole thing)?

k = kernel("daniell", c(9, 9))
smooth.spec <- spec.pgram(nino$SSA, kernel = k, taper = 0, plot = FALSE)

spec.df <- data.frame(freq = smooth.spec$freq, `0%` = smooth.spec$spec)
names(spec.df) <- c("freq", "0%")
# Add other tapers
spec.df[, "10%"] <- spec.pgram(nino$SSA, kernel = k, taper = 0.1, plot = FALSE)$spec
spec.df[, "30%"] <- spec.pgram(nino$SSA, kernel = k, taper = 0.3, plot = FALSE)$spec

spec.df <- melt(spec.df, id.vars = "freq", value.name = "spec", variable.name = "taper")
plot1 <- ggplot(data = subset(spec.df)) + geom_path(aes(x = freq, y = spec,
                                                        color = taper)) + scale_x_continuous("Period (years)", breaks = yrs.freqs,
                                                                                             labels = yrs.labels) + scale_y_log10()

plot2 <- ggplot(data = subset(spec.df)) + geom_path(aes(x = freq, y = spec,
                                                        color = taper)) + scale_x_log10("Period (years)", breaks = yrs.freqs, labels = yrs.labels) +
  scale_y_log10()

grid.arrange(plot1, plot2)

# plot of chunk unnamed-chunk-11

# In practice, a 5% (from each side) often works pretty well. Tapering is less important the longer your time series is, but it can be very important in short series.

# I'm not going to cover confidence intervals. The default plotting shows a confidence interval. But, in general, it is difficult to construct meaningful confidence intervals of spectral density estimates.

k <- kernel("daniell", c(2))
spec.df[, "10%"] <- spec.pgram(nino$SSA, taper = 0.05)$spec

# plot of chunk unnamed-chunk-12

# There are another set of spectral density estimates called “multitaper” estimates. Multitaper estimates can have pretty good localization in time. Multitaper esimates have two smoothing parameters, though. In the software, they are called “NW” and “k”. Typically, k is set equal to \( 2NW-1 \), though, so you typically worry about NW only. For any 'true' frequency signal, it will be resolved to within \( \pm NW \) frequency intervals. (kinda like a moving average, only better behaved) This makes it pretty easy to determine how much smoothing you are getting.

# One of the nice things about R's implementation is that confidence intervals are shown:

library('multitaper')
mt.spec <- spec.mtm(nino$SSA, nw = 16, k = 2 * 16 - 1, jackknife = TRUE, dtUnits = "month")

## Warning: Time series is not a ts object and dT is not set. Frequency array
## and axes may be incorrect.

# plot of chunk unnamed-chunk-13

# multitaper can resolve frequencies to about +/- NW/N Hz. i.e 16/1518 Hz
# k is typically equal to 2NW - 1.  Higher k is smoother
mt.spec <- spec.mtm(nino$SST, nw = 16, k = 2 * 16 - 1, jackknife = TRUE, deltat = 1/12,
                    dtUnits = "year")

# plot of chunk unnamed-chunk-13
# Time-Frequency estimation

# One of the potential shortcomings of spectral analysis is the assumption that the time-series structure is stationary. You might want to evaluate this empirically.

# Intuitively, you could cut your time series into different segments and calculate the periodgram separately for each one. Note, that since each interval is now shorter, you will have (1) less resolution between frequencies, and (2) you won't be able to detect low frequency stuff as easily.

# Now, you could imagine letting those segments overlap. This will allow you to see how periodogram is changing at various times. Finally, rather than just choosing segments, (where every datapoint in a segment gets a “weight” of 1, and every data point outside gets a weight of 0), you could imagine choosing segments by smoothly weighting points; giving more weight to the nearby time points, and less weight to the distant time points. This is precistly what wavelets do.

# There are many types of wavelets. Not all of them estimate the periodogram. Some of them estimate, slope, for example. But one that estimates the periodogram is called the “morlet” wavelet. And the resulting plot is called a spectrogram.

library('dplR')
wave.out <-
  dplR::morlet(
    y1 = nino$SST
    , x1 = nino$Year # seq_along(y1)
    , p2 = 8
    , dj = 0.1
    , siglvl = 0.95 # significance level
    )
# p2=6 <=> estimate out to 2^8 = 256 months dj <=> controls the frequency
# resolution hack the period estimate to be in years, not months
wave.out$period <- wave.out$period/12
levs <- quantile(wave.out$Power, c(0, 0.25, 0.5, 0.75, 0.95, 1))

wavelet.plot(
  wave.out
  , wavelet.levels = levs
  , crn.ylim = c(22.5, 30)
  )

# plot of chunk unnamed-chunk-14



# I had to specify the y axis limit for the time series - it wasn't displaying properly otherwise.


# We see that the annual component is strong at all time periods. There is a strong component at 3-7 years. That would be what we call El Nino. But it is noticeably absent between 1920 and 1960. This seemed to be a period of weakening in the El Nino/La Nina cycle. As far as I know, we don't quite understand why this is, yet. There also seems to be something going on at 12-16 years. Hmmm.

# We can also calculate the “averaged” wavelet. If we calculate the average across all times, we should get another estimate of the spectral density function.

wave.avg <- data.frame(power = apply(wave.out$Power, 2, mean), period = (wave.out$period))
plot(wave.avg$period, wave.avg$power, type = "l")

# plot of chunk unnamed-chunk-15

# Note that we have plotted here period, rather than frequency. Thus, the high frequency stuff is on the left, not the right.

# That's all!