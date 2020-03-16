# Title: Select sample of raw data
# Review: 2020-01-31T1703 AU


### Data Sample ####

## Subset data for a specific period
d <-
  base::subset(
    d0 # original file
    , timestamp > "2019-03-01 00:00:00" &
      timestamp < "2019-04-01 00:00:00"
  )


## check if data was samples correctly
stopifnot(length(d) > 0)


## export sample to file
write.csv(
  d
  , file = '../4_data/d_sample.csv'
  , row.names = F
)
