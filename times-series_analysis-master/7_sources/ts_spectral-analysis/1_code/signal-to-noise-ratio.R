# Title: Compute the signal-to-noise ratio (SNR) of a signal
# Review: 2020-01-27T1019 AU
# URL: https://www.rdocumentation.org/packages/bspec/versions/1.5/topics/snr

## Example

# load example data:
data(sunspots)
# compute the "plain" spectrum:
spec1 <- bspec::empiricalSpectrum(sunspots)
# plot the "plain" spectrum:
plot(
  power~frequency
  , data = spec1
  , log="y"
  , type="l"
  , main = 'Power Spectral'
  )

# plot Welch spectrum using segments of length 10 years:
spec2 <- bspec::welchPSD(sunspots, seglength=10)
lines(spec2$frequency, spec2$power, col="red")

# use 20-year segments and a flatter Tukey window:
spec3 <- bspec::welchPSD(sunspots, seglength=20, r=0.2)
lines(spec3$frequency, spec3$power, col="green")

# use 20-year segments and a flatter Tukey window:
spec4 <- bspec::welchPSD(sunspots, seglength=5, r=0.5)
lines(spec4$frequency, spec4$power, col="orange")

# URL: https://www.rdocumentation.org/packages/bspec/versions/1.5/topics/snr

library('bspec')

## Compute the SNR for a given signal and noise power spectral density.

## sample size and sampling resolution:
N       <- 1000
deltaT  <- 0.001


## For the coloured noise, use some AR(1) process;
# AR noise process parameters:
sigmaAR <- 1.0
phiAR   <- 0.9


## generate non-white noise
noiseSample <- rnorm(10*N)

# (autoregressive AR(1) low-frequency noise):
for (i in 2:length(noiseSample)) {
  noiseSample[i] <-
    phiAR*noiseSample[i-1] +
    noiseSample[i]
}


## convert to time series
noiseSample <- ts(noiseSample, deltat=deltaT)


## plot data
plot(noiseSample)


## estimate the noise power spectral density using welch's method
# Welch method: subdivide the data into segments, computing spectra for each, and averaging over the results.)
PSDestimate_mean <-
  bspec::welchPSD(
    x = noiseSample # time-series
    , seglength=1 # length of the subsegments to be used
    , method = 'mean' # averaging method
    , windowingPsdCorrection = F
  )

PSDestimate_median <-
  bspec::welchPSD(
    x = noiseSample # time-series
    , seglength=1 # length of the subsegments to be used
    , method = 'median' # averaging method
    , windowingPsdCorrection = F
  )

# str(PSDestimate)

plot(
  power~frequency
  , data = PSDestimate_mean
  , type='l'
  , main = 'Noise Power Spectrum estimate (Welch method)'
  , sub = 'data = PSDestimate'
  )
lines(
  power~frequency
, data = PSDestimate_median
, col = 'green'
)


## generate a (sine-Gaussian) signal:
t0    <- 0.6
phase <- 1.0
t <- ts((0:(N-1))*deltaT, deltat=deltaT, start=0)
signal <- exp(-(t-t0)^2/(2*0.01^2)) * sin(2*pi*150*(t-t0)+phase)
plot(signal, type='l')


## compute the signal's Signal-To-Noise ratio (SNR):
SNR <-
  bspec::snr(
    signal
    , psd=PSDestimate_mean$power
  )
