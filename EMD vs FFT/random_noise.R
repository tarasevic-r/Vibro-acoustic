# Random noise generator
# 2020-01-16 T17:29 RT

# simple randomnoise
noise_1 <- rnorm(length(s))

# More complex noise
noise_2 <- 15+(3*rnorm(length(s1))^1/8)*0.33*dw_size

# Plot both noises
par(mfrow=c(2,1))
plot(noise_1, type = 'l', col = 'coral', main = "Simple random noise")
plot(noise_2, type = 'l', col = 'coral3', main = "More complex random noise")

par(mfrow=c(1,1))
