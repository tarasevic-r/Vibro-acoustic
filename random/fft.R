rm(list=ls())
par(mfrow=c(1,1))
library("swdft")
library("stats")
library("TSA")
library("signal")
library("spectral")
library("rhdf5")
library("GeneCycle")


x <- s1_noise

plot(x, type ='l')

fft.filter = function(x, threshold = 2)
{
  #perform FFT
  y.fft = fft(x)
  
  y.fft.filter = y.fft

  #all data points = 0 + 0i
  list <- order(Mod(y.fft.filter), decreasing = T)[threshold:length(y.fft.filter)]
  y.fft.filter[list] = 0 + 0i
  
  y.ifft = fft(y.fft.filter, inverse = TRUE)/length(y.fft.filter) 
  
  
  return(Re(y.ifft))
}

# xx <- fft.filter(x, 200, plot = T)
aa <- fft.filter(x)
# cc <- fft.filter(x, 60, plot = T)

par(mfrow=c(1,1))
plot(scale(x), type = "l", main = "Original  Data", col = 'darksalmon')
# lines(scale(cc), col='green')
# lines(scale(xx), col='blue')
lines(scale(aa), col='blue')


freq.data <- GeneCycle::periodogram(x)
harmonics <- 1:(length(x)/2)
