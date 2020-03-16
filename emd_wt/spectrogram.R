# Signal spectrogram 
by <- seq(0,0.512, 0.006)
par(mfrow=c(1,1), bg="lightgrey")

# plot signal spectrum (based on fft)
s_fir <- seewave::fir(s, f=Fs, to = f_input)
spectr <- seewave::spec(s_fir, f=Fs, PSD=T)
Sys.sleep(2)
plot(spectr, type ='l', xlim=c(0,0.03))
# abline(v=by, lty= 2, col = "red")
# spec <- spec[-1,]

