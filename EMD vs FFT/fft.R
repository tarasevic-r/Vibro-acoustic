library(stats)


# Perform and Normalise FFT
FTs1 = fft(s1_noise)
FTs2 = fft(s2_noise)


# Calculate magnitude of FTs
magnitude1 <- base::Mod(FTs1)
magnitude2 <- base::Mod(FTs2)

# Plot magnitudes
par(mfrow=c(3,1))
plot(normalize(base::Mod(fft(s))), type = 'l', col = 'darkgreen'
     , main = 'original FFT coeficients magnitude')

plot(normalize(magnitude1), type = 'l', col = 'darkgreen'
     , main = "simple noised FFT coeficients magnitude")

plot(normalize(magnitude2), type = 'l', col = 'darkseagreen4'
     , main = "complex noised FFT coeficients magnitude")

par(mfrow=c(1,1))
