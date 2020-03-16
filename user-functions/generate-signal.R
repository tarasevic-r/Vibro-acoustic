## generate-signal.R
# Review: 2020-01-27T1504 AU
# Output: tt (time vector), xt (value vector)


### Signal parameters
t0 <- 0
t1 <- 1
N <- 1000
dt <- 1/N
Fs <- 1/dt
Fn <- Fs / 2


## Time sequence
tt <- seq(t0 + dt, t1, by=dt)


## Define Frequencies
f1 <- 2
f2 <- 20
f3 <- 100


## Generate signal

# A. Signal with three frequencies of same strength:
xt <- sin(2*pi*f1*tt) + sin(2*pi*f2*tt) + sin(2*pi*f3*tt)

# B. Signal with three frequencies with random strength:
# xt <- sin(2*pi*f1*tt) + 0.8*sin(2*pi*f2*tt) + 0.6*sin(2*pi*f3*tt)

