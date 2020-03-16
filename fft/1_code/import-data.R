## import-data.R
# Review: 2020-01-13T1027 AU
# Input: raw data file
# Output: signal s, integer sample of raw data


# library('BiocManager')
# BiocManager::install('rhdf5')

## load data using specified file path
s0 <-
  rhdf5::h5read(
    '../2_raw-data/x1.H5'
    , "/promc.dataset.orig"
    , bit64conversion = "double"
  )


# data set dimensions: rows and columns
# dim(s0)


# rename features to x (timestamp) and y (value)
names(s0) <- c('x', 'y')


# reset timestamp to 1
s0$x <- seq(1, length(s0$y), 1)


## round y
s0$y <- round(s0$y, 1)


## export prepared data to file
write.csv(
  s0
  , file='../4_data/d1.csv'
  , row.names = F
)


## review sampled series
# head(s0)
