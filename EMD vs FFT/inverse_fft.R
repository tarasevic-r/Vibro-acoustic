## Inverse FFT 
# 2020-01-04 T18:57 RT

# Inverse FFT 
iFTs1 <- fft(FTs1, inverse = T)/length(FTs1)
iFTs2 <- fft(FTs2, inverse = T)/length(FTs1)

# Get inverse FFT magnitude
i_magnitude1 <- Mod(iFTs1)
i_magnitude2 <- Mod(iFTs2)


par(mfrow=c(2,1))
par(bg = 'grey')

#plot and compare results
plot(scale(Re(iFTs1)), type ='l', col = 'gold', ylim = c(-3, 3), lwd = 3, ylab = 'amplitude', xlab = 't')
lines(scale(s), col = 'darkgreen', lwd = 2)
legend("bottomright",
       bty = 'n',
       legend = c("iFFT", "original signal", "noise = rnorm(length(s))"),
       text.col = c("gold", "darkgreen", "coral"),
       xpd=TRUE,
       inset=c(0,1),
       col = c("gold", "darkgreen", "coral"), lty = 7, lwd = 2
)

plot(scale(Re(iFTs2)), type ='l', col = 'gold', ylim = c(-3, 3), lwd = 3, ylab = 'amplitude', xlab = 't')
lines(scale(s), col = 'darkgreen', lwd = 2)
legend("bottomright",
       bty = 'n',
       legend = c("iFFT", "original signal", "noise = 15+(3*rnorm(length(s1))^1/8)*0.33*dw_size"),
       text.col = c("gold", "darkgreen", "coral"),
       xpd=TRUE,
       inset=c(0,1),
       col = c("gold", "darkgreen", "coral"), lty = 7, lwd = 2
)

# TSA::periodogram(s2_noise)
