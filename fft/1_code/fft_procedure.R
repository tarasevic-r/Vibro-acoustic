## fft-procedure.R
# Review: 2020-01-13T1204 AU


source('data-window.R')
# - read data from file
# - choose data window from sample data
# - save sample to d2.csv

source('detrend.R')
# - create linear model
# - detrend series
# - save model coefficients to d3.csv
# - save data to d3.csv
# source('detrend__plot.R')

source('fft.R')
# - perform Fast Fourier Transform
# - save fft coefficients with detrended data window to d4.csv
# source('fft__plot.R')
# - calculate magnitude and angle
# - plot Frequency Magnitude

source('fft_filter.R')
# - filter fft coefficients using threshold
# source('fft_filter__plot.R')

source('fft_inverse.R')
# - perform Inverse Fast Fourier Transform
# - filter fft coefficients using threshold
# source('fft_inverse__plot.R')
# - plot Frequency Magnitude
# - plot Filtered Signal

source('trend.R')
# - append trend back to linear model
# - save detrended data window to d3.csv
# source('trend__plot.R')


df$sample <- sample_id
df$dw <- data.window


## append CURRENT result to master data frame
df_master <-
  rbind(
    df_master
  , df
  )