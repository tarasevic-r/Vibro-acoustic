# Title: Error detection in signal using FFT
# Review: 2020-01-15T1537 AU

rm(list=ls())

t0 <- 0
t1 <- 5
N <- 1000
tt <- seq(t0, t1, 1/N)
Fs <- 1/(tt[2] - tt[1])
Fn <- Fs / 2
xt <- 10 * sin(2*pi*10*tt) + 5*tt*sin(2*pi*2*tt) + 2*tt + 0.2*tt*tt
noise <- 2 * rnorm((t1-t0)*N+1) / 0.2 * tt
xt.noise <- xt + noise

par(mfrow=c(1,2))
plot(x = tt, y = xt, type='l', main='original')
plot(x = tt, y = xt.noise, type='l', main='with random noise')

fft_xt <- fft(xt)
fft_xt.n <- fft(xt.noise)

mag_xt <- abs(fft_xt)
mag_xt.n <- abs(fft_xt.n)

mag_xt <- as.numeric(scale(mag_xt))
mag_xt.n <- as.numeric(scale(mag_xt.n))

plot(mag_xt[2:Fn+1], type='h')
plot(mag_xt.n[2:Fn+1], type='h')

low_fft_xt <- which(mag_xt < 0.2)
low_fft_xt.n <- which(mag_xt.n < 0.2)

l1 <- length(low_fft_xt)
l2 <- length(low_fft_xt.n)
which.max(x = c(l1, l2))

# pg_xt <- TSA::periodogram(xt)
# pg_xt.n <- TSA::periodogram(xt.noise)
