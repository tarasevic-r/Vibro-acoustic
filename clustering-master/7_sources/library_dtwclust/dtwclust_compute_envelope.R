## Task: compute the envelopes for DTW lower bound calculations with a Sakoe-Chiba band for a given univariate time series using the streaming algorithm proposed by Lemire (2009).

# library('dtwclust')

data(uciCT)
H <-
  dtwclust::compute_envelope(
    x = CharTraj[[1L]]  # A univariate time series.
    , window.size = 18L # Window size for envelope calculation. See details.
  )
matplot(do.call(cbind, H), type = "l", col = 2:3)
lines(CharTraj[[1L]])
