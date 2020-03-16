# Title: Cross-correlation Function
# Review: 2020-01-22T1538 AU


## review object `acf`
# str(acf_d)


## elements of `acf` objects:
# acf_d$type # correlation or covariance
# acf_d$lag[,,1] # lag index
# acf_d$acf[,,1]  # vector of acf coefficients
# acf_d$n.used # sample size
# acf_d$series # series input
# acf_d$snames # series labels # empty


## define index for sample of size data window
idx <- 3
data_window <- 100
from_to <- (idx*data_window+1):(idx*data_window + data_window +1)


## sample a portion of data
X <- d$value[data.window]


# lag.max: whichever is less: 20 or file size divided by four
my_lag_max <- min( length(X)/4, 20 )



#### * Cross-correlation ####
# Review: 2020-01-22T1506 AU

## Input: two series
x <- d$value[from_to]
y <- d$value[from_to + data_window] # next data window




## check value ranges for chart
xlim_min <- min(min(x),min(y))
xlim_max <- max(max(x),max(y))

## draw a chart with both lines
par(mfrow=c(1,1))
plot(x, type='l', col = 'red') #, xlim = c(xlim_min, xlim_max), ylim = c(ylim_min, ylim_max))
lines(y, col='blue')


## estimate cross-correlation between two series
ccf_xy <-
  stats::ccf(
    x
    , y
    , lag.max = my_lag_max
    , plot = T
  )


## review results
ccf_xy


## get significant lags
ccf_xy_idx <- which( abs(ccf_xy$acf[,,1]) > 0.2 )


## if found at least one significant lag:
if(length(ccf_xy_idx) > 0) {
  
  ## print info
  cat(
    'AU: strong correlation coefficients:'
    , length(ccf_xy_idx)
    , '.\n'
  )
  
  ## get significant values for identified lags
  ccf_xy_value <-
    ## convert to numeric
    as.numeric(
      ccf_xy$acf[ ccf_xy_idx ]
    )
  
  ## merge results
  ccf_xy_key <-
    data.frame(
      cbind(
        'lag' = ccf_xy$lag[ ccf_xy_idx ]
        , 'ccf' = ccf_xy_value
      )
    )
}

