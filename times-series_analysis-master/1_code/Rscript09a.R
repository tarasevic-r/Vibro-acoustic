# Title: Autocorrelation Function
# Review: 2020-01-22T1512 AU


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


#### * Autocorrelation function estimation ####
acf_d <-
  stats::acf(
    X
    , lag.max = my_lag_max
    , plot = T # draw a chart?
  )


## review acf results
# acf_d


## filter for significant values
# get significant lags
acf_idx <- which( acf_d$acf[,,1] > 0.2 )

## print info
cat(
  'AU: strong correlation coefficients up to lag'
  , max(which( acf_d$acf[,,1] > 0.2 ))
  , '.\n'
)


# get significant values for identified lags
acf_val <- as.numeric( acf_d$acf[ acf_idx ] )
## merge results
acf_d <-
  data.frame(
    cbind(
      'lag' = acf_idx
      , 'acf' = acf_val
    )
  )


## export significant values to file
write.csv(
  acf_d
  , file = '../4_data/d_sample_acf.csv'
  , row.names = F
)