# swdft.R

library('swdft')
# N <- 100
window_size <- 16
# x_random <- rnorm(n=N, mean=0, sd=1)
a <- swdft::swdft(x=query, n=window_size)

amod <- Mod(a$a)^2

plot(a)

plot(a, col="tim.colors", title="SWDFT using the 'tim.colors' colorscale")

sampling_frequency <- 100
plot(a, freq_type="hertz", fs=sampling_frequency)

plot(a, freq_type="fraction")