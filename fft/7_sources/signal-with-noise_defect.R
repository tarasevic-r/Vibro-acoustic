t0 <- 0
t1 <- 1 # final time
dt <- 0.01
N <- 200
f1 <- 20 # device
fe <- 20*3 # device
tt <- seq(t0, t1, by=1/N)
Fs <- 1/dt
Fn <- length(tt)/2

n.xt <- 2*tt + sqrt(0.2*tt*tt)
xt <- sin(2*pi*f1*tt) + sin(4*pi*f1*tt) + n.xt
## error for defect
n.nt <- 0.2*n.xt # growing with time
# plot(n.nt, type='h')
## defect signal
nt <- sin(2*pi*fe*tt) + n.nt

## compoisite signal: original (with error 1) + noise (with error 2)
Xt <- xt + nt


## Plot charts
par(mfrow=c(3,1))
plot(tt, xt, type='l', main='original')
plot(tt, nt, type='l', main='noise (defect)')
plot(tt, Xt, type='l', main='original+noise')

## FFT and plot coefficients
par(
  bg='darkgrey'
  , mfrow=c(1,1)
)
plot(
  Mod(Re(fft(xt)/length(tt)))[2:(Fn+1)]
  , type='h'
  , col = 'green'
  , lwd = 3
  , main = 'FFT coefficients (green=orig)'
)
lines(
  Mod(Re(fft(nt)/length(tt)))[2:(Fn+1)]
  , col = 'orange'
  , type='h'
  , lwd = 3
)
lines(
  x = 0:(length(Xt)-1)
, y = rep(0.05, length(Xt))
, col = 'red'
, lty = 5
, lwd = 2
)
