# Title: Time Series - Stationarity - library `tseries`
# Review: 2020-01-31T1454 AU


#### Data ####

## Generate data (example)
N <- 100 # sample index
x <- rnorm(1:N) # series



#### Stationarity Test ####

## Confidence level
alpha <- 0.05


## load library
suppressPackageStartupMessages(
  library('tseries') # time series analysis and computational finance
)


## Test time series stationarity using Augmented-Dick-Fuller test
x_adf <-
  tseries::adf.test(
    x
    , k = 0 # the lag order to calculate the test statistic
  )#$p.value


## Output review
str(x_adf)
# x_adf$statistic
# x_adf$p.value


## print test results
cat(
  'Series', x_adf$data.name
  , 'stationarity with', x_adf$method
  , 'returned'
  , 'statistic', x_adf$statistic, 'and p-value', x_adf$p.value
  , '\n'
  , 'Series', x_adf$data.name, 'is'
  , ifelse(
    x_adf$p.value <= alpha
    , 'stationary.'
    , 'non-stationary.'
  )
  , '\n'
)
