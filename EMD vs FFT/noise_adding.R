# Add noise on signals
s1_noise = s + noise_1
s2_noise = s + noise_2


par(mfrow=c(2,1))

# Plot signal with added simple noise
plot(normalize(s), type = 'l', col = 'darkgreen', lwd=2)
lines(normalize(s1_noise), col = 'coral', lwd=2)
legend("bottomright",
       bty = 'n',
       legend = c("original signal", "signal with simple noise"),
       text.col = c("darkgreen", "coral"),
       lwd = 2, lty = 7, col = c("darkgreen", "coral"),
       xpd=TRUE, 
       inset=c(0,1)
)

# Plot signal with added complex noise
plot(normalize(s), type = 'l', col = 'darkgreen', lwd=2)
lines(normalize(s2_noise), col = 'coral', lwd=2)
legend("bottomright",
       bty = 'n',
       legend = c("original signal", "signal with complex noise"),
       text.col = c("darkgreen", "coral"),
       lwd = 2, lty = 7, col = c("darkgreen", "coral"),
       xpd=TRUE,
       inset=c(0,1)
)

par(mfrow=c(1,1))
