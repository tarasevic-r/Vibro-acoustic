# Load data

# count of full cycles (2*pi)
cycles <- pi
# sample size
n <- 256
# sampling period
dT <- 1 / 1000
# create time index
t1 <- seq(from = 0,to = 2^9, length = 2^6)
t2 <- seq(from = 0,to = 2^9, length = 2^4)
## noise parameters
mu_noise <- 0
sigma_noise <- 1
s_noise <- rnorm(t1, mu_noise, sigma_noise)
s_noise2 <- rnorm(t2, mu_noise, sigma_noise)


## generate signal
# signal <- sin(4*xt) + cos(2*xt) + s_noise
# signal2 <- sin(4*xt) + cos(2*xt) + 1.3*sin(7*xt) + s_noise
# signal2 <- 0.7*sin(16*xt) + cos(5*xt)+ sin(2*xt) + s_noise

# signals without noise
s_1 <- sin(43*t1) #+ s_noise
s_2 <- 0.52*sin(7*t2)# + s_noise2
s_3 <- s_1+s_2

s <- c(s_1,s_3,s_1,s_3)


# plot signal
plot(s_1, type = 'l')
plot(s_2, type = 'l')
plot(s_3, type = 'l')
plot(s, type = 'l', main = paste0("original signal s1+s2", "; dw = ",dw))
lines(y=s[129:133], x=c(129:133), col = 'red', lwd =3)

TSA::periodogram(s)
