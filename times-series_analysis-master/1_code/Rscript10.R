# Title: Fast Fourier Transform
# Review: 2020-01-22T1612 AU

timesub <- as.numeric(as.POSIXct(d$timestamp),origin="1970-01-01")*1000000
subP <- data.frame(timesub,'value' = d$value)
head(subP)

h1 <- subP$timesub[2:nrow(subP)]
hn <- subP$timesub[1:nrow(subP) - 1]
hd <- (h1 - hn) / 1000000
hsd <- 1/min(hd)
n <- nrow(subP)
v <- subP$value

for (m in 1:30) {
  # m <- 1 # qc first round
  m <- m + 1 # qc iterate
  cat('m:', m)
  
  ## if row records is smaller than 2^m
  if (n <= 2^m) {
    cat('n <= 2^m:', n <= 2^m)
    
    ## row difference between 2^m and original series
    g <- 2^m - n
    
	## iterate all rows
    for (j in 1:(n+g)) {
      # j <- 1
      #j <- j + 1
	  
	  ## while row index is less than row number
      if ( j <= n ) {
        v[j] <- v[j]
      } else {
        v[j] <- 0
      }
    }
    break
  }
  # } else {
  #   m <- m+1
  #   }
}

n <- n + g
n


## prepare time index
Hs1=(0:((n/2)-1)) * hsd/(n/2)
# plot(Hs1)


## Perform Fast Fourier Transform
Z1 <- fft(v)/length(v)
# Z1 <- Z1

## calculate amplitude
mag <- abs(Re(Z1))

## extract phase
phase <- Im(Z1)

hss <- data.frame(Hs1, mag)


## choose number N of Fourier Coefficient to draw
FT_max <- 10

phss <-
  plot_ly(
    x=hss$Hs1[1:FT_max]
    , y=hss$mag[1:FT_max]
    , type = "scatter"
    , mode = "lines+markers"
  )
phss
