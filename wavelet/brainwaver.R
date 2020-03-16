library(waveslim)


## Haar
signal_harr <- mra(signal, "la8", 4, "dwt")
signal_harr2 <- mra(signal2, "la8", 4, "dwt")
names(signal_harr) <- c("d1", "d2", "d3", "d4", "s4")
names(signal_harr2) <- c("d1", "d2", "d3", "d4", "s4")

par(mfcol=c(6,1), pty="m", mar=c(5-2,4,4-2,2))
plot.ts(signal, axes=FALSE, ylab="", main="(a)", col = 'darkblue')
lines(signal2, axes=FALSE, col = 'red', lwd =1.5)

for(i in 1:5) {
  plot.ts(signal_harr[[i]], axes=FALSE, ylab=names(signal_harr)[i], col = 'darkblue')
  lines(signal_harr2[[i]], axes=FALSE,col = 'red', lwd = 1.5)
}








###################################################
library("brainwaver")

wave <- wave.trans(signal, wf = "la8")
names(wave) <- c("w1", "w2", "w3", "w4", "v4")

par(mfcol=c(6,1), pty="m", mar=c(5-2,4,4-2,2))
plot.ts(signal, ylab="",  main ="(a)")

for(i in 1:5)
  plot.ts(wave[[i]], ylab=names(wave)[i])


plot.ts(wave[[4]])
plot(wave$s5, type ='l')
