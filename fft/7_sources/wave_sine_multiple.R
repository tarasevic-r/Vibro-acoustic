#### https://blog.octo.com/time-series-features-extraction-using-fourier-and-wavelet-transforms-on-ecg-data/

# https://betterexplained.com/articles/an-interactive-guide-to-the-fourier-transform/
# https://riptutorial.com/r/example/14464/fourier-series

# Review: 2020-01-15T1059 AU

rm(list=ls())


## DataParameters for geenrating process
t0 <- 0 # time from
t1 <- 2 # time to
N <- 1000 # samples
tt <- seq(t0, t1, 1/N) # generate time index
Fs <- 1/(tt[2] - tt[1])     # sampling frequency
Fn <- Fs / 2                # Nyquist frequency


## Generate three waves
xt.2 <- 3   * sin(2*pi*2*tt)
xt.3 <- 6   * sin(2*pi*3*tt)
xt.5 <- 1.5 * sin(2*pi*5*tt)
## Composite wave
xt <- xt.2 + xt.3 + xt.5


## plot parameters
# par(mfrow=c(3,1))
layout(matrix(c(1,2,3,4,5,5,5,5), nrow=4, ncol=2, byrow = F))
## plot all waves
plot(x = tt, y = xt, col='black', type='o')
plot(x = tt, y = xt.2, col = 'blue', type = 'o')
plot(x = tt, y = xt.3, col = 'red', type = 'o')
plot(x = tt, y = xt.5, col = 'green', type = 'o')

## Range (min and max)
range(xt)
range(xt.2)
range(xt.3)
range(xt.5)


## Perform FFT
fft_xt <- round(fft(xt) / N, 2)
fft_xt.2 <- fft(xt.2) / N
fft_xt.3 <- fft(xt.3) / N
fft_xt.5 <- fft(xt.5) / N


## Frequency magnitudes
mag_xt <- abs(fft_xt)[2:Fn]
mag_xt.2 <- abs(fft_xt.2)[2:Fn]


par(mfrow=c(1,1))
plot(
  x = 1:20 # first 20 frequencies
, y = mag_xt[1:20] # first 2 magnitudes
, type='h'
)

F_selected <- 1:10

barplot(
  mag_xt[F_selected] # first 2 magnitudes
  , horiz = T
  , xlim = c(0, max(mag_xt[F_selected])+1)
  , names.arg = F_selected
  , xlab = 'Magnitude'
  , ylab = 'Frequencies'
)



# plot(mag_xt.2, type='h')

# 
# par(mfrow=c(2,2))
# p1 <- TSA::periodogram(wave.1)
# p2 <- TSA::periodogram(wave.2)
# p3 <- TSA::periodogram(wave.3)
# p4 <- TSA::periodogram(full.wave)
# 
# FT <- fft(full.wave) / length(full.wave)
# plot(Mod(Re(FT[2:(length(full.wave)/2)+1])), type='h')
# 
# p <- p4
# dd = data.frame(freq=p$freq, spec=p$spec)
# order = dd[order(-dd$spec),]
# top_frequencies = head(order, 3)
# 
# # display the 2 highest "power" frequencies
# # top_frequencies
# # convert frequency to time periods
# time = 1/top_frequencies$f
# time
