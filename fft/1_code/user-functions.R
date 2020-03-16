## define-functions.R
# Review: 2020-01-10T167 AU

# returns the x.n time series for a given time sequence (ts) and
# a vector with the amount of frequencies k in the signal (X.k)
get.trajectory <- function(X.k,ts,acq.freq) {
  
  N   <- length(ts)
  i   <- complex(real = 0, imaginary = 1)
  x.n <- rep(0,N)           # create vector to keep the trajectory
  ks  <- 0:(length(X.k)-1)
  
  for(n in 0:(N-1)) {       # compute each time point x_n based on freqs X.k
    x.n[n+1] <- sum(X.k * exp(i*2*pi*ks*n/N)) / N
  }
  
  x.n * acq.freq
}



# plot a frequency spectrum of a given X_k
plot.frequency.spectrum <- function(X.k, xlimits=c(0,length(X.k))) {
  plot.data  <- cbind(0:(length(X.k)-1), Mod(X.k))
  
  # TODO: why this scaling is necessary?
  plot.data[2:length(X.k),2] <- 2*plot.data[2:length(X.k),2] 
  
  plot(plot.data, t="h", lwd=2, main="", 
       xlab="Frequency (Hz)", ylab="Strength", 
       xlim=xlimits, ylim=c(0,max(Mod(plot.data[,2]))))
}

# Plot the i-th harmonic
# Xk: the frequencies computed by the FFt
#  i: which harmonic
# ts: the sampling time points
# acq.freq: the acquisition rate
plot.harmonic <- function(Xk, i, ts, acq.freq, color="red") {
  Xk.h <- rep(0,length(Xk))
  Xk.h[i+1] <- Xk[i+1] # i-th harmonic
  harmonic.trajectory <- get.trajectory(Xk.h, ts, acq.freq=acq.freq)
  points(ts, harmonic.trajectory, type="l", col=color)
}


# specify distance function: L1
my_manhattan_dist <- 
  function(vector1, vector2){
    distance <- abs(vector1-vector2)
    distance <- sum(distance)
    
    return(distance)
  }
# call: my_manhattan_dist(x1, x2)


# specify distance function:
my_chebyshev_dist <-
  function(vector1, vector2){
    distance <- abs(vector1 - vector2)
    distance <- max(distance)
    
    return(distance)
  }
# call: my_chebyshev_dist(x1, x2)



## Normalize data using Min Max (exclude NA values)
normalize <-
  function(x, na.rm = TRUE) {
    ranx <- range(x, na.rm = na.rm)
    (x - ranx[1]) / diff(ranx)
  }
# call: normalize(x)