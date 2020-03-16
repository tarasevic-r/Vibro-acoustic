# Extract main harmonics, 10hz, 20hz, 40hz
main_magnitude_1 <- c(magnitude1[11], magnitude1[21], magnitude1[41])
main_magnitude_2 <- c(magnitude2[11], magnitude2[21], magnitude2[41])

# Null original FFT coeficients
FTs1 <- rep(0, 100)
FTs2 <- rep(0, 100)

# Keep main harmonics of original signal
FTs1[c(11, 21, 41)] <- main_magnitude_1
FTs2[c(11, 21, 41)] <- main_magnitude_2

