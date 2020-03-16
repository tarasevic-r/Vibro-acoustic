
# W - wavelet coefficients (high pass filter, detail coefficients) - mother wavelet
# The detail coefficients represent the output of the high pass filter (difference filter) of the DWT.

# V - scale coefficients (low pass filter, approximation coefficients) - father wavelet
# The approximation coefficients represent the output of the low pass filter (averaging filter) of the DWT.

# all levels detail wavelet decomposition spectrogram
see <- seewave::spec(wd@W$W1, f=256, main = '1st level WD spectrogram')
abline(v=by, lty= 2, col = "darkgrey")
see <- seewave::spec(wd@W$W2, f=128, main = '2nd level WD spectrogram')
abline(v=by, lty= 2, col = "darkgrey")
see <- seewave::spec(wd@W$W3, f=64, main = '3rd level WD spectrogram')
abline(v=by, lty= 2, col = "darkgrey")
see <- seewave::spec(wd@W$W4, f=32, main = '4th level WD spectrogram')
abline(v=by, lty= 2, col = "darkgrey")
see <- seewave::spec(wd@W$W5, f=16, main = '5th level WD spectrogram')
abline(v=by, lty= 2, col = "darkgrey")

# empty table for WD low pass frequencies 
results_V <- data.frame()
i=1
while(i <= wd@level-2){
  # cat("f=",1024/2^i )
  spec <- seewave::spec(data.frame(wd@V[i]), f=1024/2^i)
  spec <- spec[!(spec[,1] == 0),]
  # order frequencies 
  top <- order(spec[,2], decreasing = T)
  # check which of them are partial to 6
  spec <- spec[top]
  # nr <- which(spec%%0.006==0)[1:8]
  result_V <- 1000*spec[1:8]

  results_V <- rbind(results_V, result_V)
  i=i+1
}

# empty table for WD high pass frequencies 
results_W <- data.frame()
i=1
while(i <= wd@level-2){
  # cat("f=",1024/2^i )
  spec <- seewave::spec(data.frame(wd@W[i]), f=1024/2^i)
  spec <- spec[!(spec[,1] == 0),]
  # order frequencies 
  top <- order(spec[,2], decreasing = T)
  # check which of them are partial to 6
  spec <- spec[top]
  # nr <- which(spec%%0.006==0)[1:8]
  result_W <- 1000*spec[1:8]
  
  results_W <- rbind(results_W, result_W)
  i=i+1
}

# clear column names
colnames(results_W) <-NULL
# transpouse table
# set column names
row.names(results_W) <- c("W1","W2","W3","W4","W5","W6","W7")

# clear column names
colnames(results_V) <-NULL
# transpouse table
# set column names
row.names(results_V) <- c("V1","V2","V3","V4","V5","V6","V7")


print(results_V)
print(results_W)

