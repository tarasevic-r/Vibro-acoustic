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


#### * Partial autocorrelation with `pacf` ####
## Autocorrelation function estimation
# lag.max: whichever is less: 20 or file size divided by four
pacf_d <-
  stats::pacf(
    X
    , lag.max = my_lag_max
    , plot = T # draw a chart?
  )


## review acf results
# pacf_d


## review acf object
str(pacf_d)


## elements of acf object
pacf_d$type # correlation or covariance
pacf_d$lag[,,1] # lag index
pacf_d$acf[,,1]  # vector of acf coefficients
# pacf_d$n.used # sample size
# pacf_d$series # series input
# pacf_d$snames # series labels # empty


## get significant lags
pacf_idx <- which( abs(pacf_d$acf[,,1]) > 0.2 )
## print info
cat(
  'AU: strong correlation coefficients up to lag'
  , max(pacf_idx)
  , '.\n'
)
## filter for significant values
# get significant values for identified lags
pacf_val <- as.numeric( pacf_d$acf[ pacf_idx ] )
## merge results
pacf_d_key <-
  data.frame(
    cbind(
      'lag' = pacf_idx
      , 'pacf' = pacf_val
    )
  )


## export significant values to file
write.csv(
  pacf_d_key
  , file = '../4_data/d_sample_pacf.csv'
  , row.names = F
)