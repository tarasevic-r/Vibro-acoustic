# Title: Review data
# Review: 2020-02-04T1200 AU


## Data structure
# str(d)


## Data summary
# summary(d)


## notice how Mode_freq_t is a constant
idx_constants <- names(which(sapply(d, sd) == 0))

## if any found, remove from data
if(length(idx_constants) > 0) {
  d[,idx_constants] <- NULL
  cat('Constants: removed (', length(idx_constants), ').\n')
}



## identify features with variance lower than 1
idx_low_variance <- names(which(sapply(d, sd) < 1))

## if any found, remove from data
if(length(idx_low_variance) > 0) {
  d[,idx_low_variance] <- NULL
  cat('Low variance (<1): removed (', length(idx_low_variance), ').\n')
}