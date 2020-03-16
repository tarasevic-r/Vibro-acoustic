## generate-signal.R
# Review: 2020-02-21 T11:29 RT
# Output: tt (time vector), xt (value vector)


### Signal parameters
t0 <- 0
t1 <- 1
N <- 2^11
dt <- 1/N
Fs <- 1/dt
Fn <- Fs / 2
set.seed(7)


## Time sequence
tt <- seq(t0 + dt, t1, by=dt)

## Define Frequencies
f1 <- 0.5
f2 <- 5
f3 <- 11.67
f4 <- 44
f5 <- 23
f6 <- 113

## Generate signal

# A. Signal with three frequencies of same strength:
# s_orig <- 6*sin(2*pi*f1*tt)  +  12*sin(2*pi*f2*tt) + sin(2*pi*f3*tt)# + 4*sin(2*pi*f3*tt) + 2*sin(2*pi*f5*tt)# +  3*sin(2*pi*f5*tt)
s_orig <- 2*sin(2*pi*f1*tt)  +  4*sin(2*pi*f2*tt) + 8*sin(2*pi*f3*tt) + 4*sin(2*pi*f5*tt) #+ 2*sin(2*pi*f5*tt)# +  3*sin(2*pi*f5*tt)
s2_orig <- 2*sin(2*pi*f6*tt) + 2*sin(2*pi*f2*tt) + sin(2*pi*f3*tt)# + sin(2*pi*f4*tt) +  3*sin(2*pi*f5*tt)

# plot signals without noise
plot(s_orig, type = 'l', main=paste("1st signal,  2*", f1, "+", f2, "+", f3, "Hz"))
# plot(s2_orig, type = 'l', main=paste("2nd signal,  2*", f1, "+", "2*", f2, "+", f3, "Hz"))

# noise with a signal to noise ratio of 2)
noise <- rnorm(length(s_orig), 0, sd=sqrt(var(s_orig))/6)
# plot noise
plot(noise, type = 'l', main = "random noise")
# add noise to signals
s <- s_orig + noise
# s2 <- s2_orig + noise
# s <- s[1:1024]
# plot signals with noise
plot(s, type = 'l', main=paste("1st signal,  2*", f1, "+", f2, "+", f3, "Hz + noise"))
# plot(s2, type = 'l', main=paste("2nd signal,  2*", f1, "+", "2*", f2, "+", f3, "Hz + noise"))

# s <- c(s,s2)
