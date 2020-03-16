# Title: vector L-2 norm |x|
# Review: 2020-01-15T1215 AU
# URL: <http://mathworld.wolfram.com/L2-Norm.html>

# Based on "Comparing Time-Series Clustering Algorithms in R Using the dtwclust Package", chapter 2.4 Shape-based distance

require(stats)

# vector `l^2 norm` |X| is a vector norm for a complex vector X = [x_1,..,x_n]
# by formula: |X|_2 = {sqrt}( {sum;k=1;n} (|x_k|^2) ), |x_k| = complex modulus



## Domain setup
T <- 5 # total time
dt <- 0.01 # sampling period, seconds
N <- T/dt # samples
F <- 1/dt # frequency
df <- 1/T

freq<-5 #Hz
tt <- seq(0,T,by=dt) #also try ts function

#CREATE OUR TIME SERIES DATA
y <- 10*sin(2*pi*freq*tt) +4* sin(2*pi*20*tt)

#CREATE OUR FREQUENCY ARRAY
f <- 1:length(t)/T

#FOURIER TRANSFORM WORK
Y <- fft(y)
mag <- sqrt(Re(Y)^2+Im(Y)^2)*2/n
mag <- sqrt(Mod(Y)^2)*2/n
phase <- atan(Im(Y)/Re(Y))
Yr <- Re(Y)
Yi <- Im(Y)

#PLOTTING
layout(matrix(c(1,2), 2, 1, byrow = TRUE))
plot(t,y,type='l',xlim=c(0,T))
plot(f[1:length(f)/2],mag[1:length(f)/2],type='l')


## generate a vector
# https://onestepafteranother.wordpress.com/signal-analysis-and-fast-fourier-transforms-in-r/


### calculate vector norm

## define function
norm_l2 <- function(x) {
  return(sqrt(sum(Mod(x^2))))
}

## calculate L2 norm for FFT coefficients
(norm_l2_x <- norm_l2(Y))
