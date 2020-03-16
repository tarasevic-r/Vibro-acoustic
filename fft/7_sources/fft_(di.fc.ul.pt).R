# <http://www.di.fc.ul.pt/~jpn/r/fourier/fourier.html>
# file:///C:/AU/books/fft/Fourier%20Transform%20%20A%20R%20Tutorial.html

library(stats)

x <- c(1,1,1,1) # stationary
x <- c(1,2,3,4) # increasing trajectory
x <- c(4,0,0,0)

X.k <- fft(x) # get amount of each frequency k

X.k <- fft(x) / length(x)  # to normalize

time     <- 2                            # measuring time interval (seconds)
Fs <- 100                          # data acquisition frequency (Hz)
ts  <- seq(0,time-1/Fs,1/Fs) # vector of sampling time-points (s) 

x.n <- get.trajectory(X.k, ts, Fs)   # create time wave

plot(ts,x.n,type="l",ylim=c(-2,4),lwd=2)
abline(v=0:time,h=-2:4,lty=3); abline(h=0)

plot.harmonic(X.k,1,ts,Fs,"red")
plot.harmonic(X.k,2,ts,Fs,"green")
plot.harmonic(X.k,3,ts,Fs,"blue")

## Example
Fs <- 100                          # data acquisition (sample) frequency (Hz)
time     <- 6                      # measuring time interval (seconds)
ts       <- seq(0,time-1/Fs,1/Fs)  # vector of sampling time-points (s) 
f.0 <- 1/time

dc.component <- 1
component.freqs <- c(3,7,10)        # frequency of signal components (Hz)
component.delay <- c(0,0,0)         # delay of signal components (radians)
component.strength <- c(1.5,.5,.75) # strength of signal components

f <- function(t,w) { 
  dc.component + 
    sum( component.strength * sin(component.freqs*w*t + component.delay)) 
}

plot.fourier(f,f.0,ts=ts)

