# Title: Cross-correlation of two series
# Review: 2020-01-31T1705 AU


## definition
cat('In probability and statistics, the term `cross-correlations`` refers to the correlations between the entries of two random vectors X and Y. [Wiki]\n')


## Prepare series 1
ts1 <- d$value[1:100]


## Prepare series 2
ts2 <- d$value[101:200]


#### INTERPOLATE HERE #####



## calculate correlation coefficient between two time series and round it
ro_xy <-
  base::round(
    stats::cor(
      x = ts1
      , y = ts2
      )
    , 2
    )


## strength of correlation
if (abs(ro_xy) < 0.1) {
  ro_xy_type <- 'no cross-correlation'
} else if (abs(ro_xy) > 0.2) {
  ro_xy_type <- 'weak'
} else if(abs(ro_xy) > 0.4) {
  ro_xy_type <- 'strong'
}

## print info to user
cat(ro_xy_type, ':', ro_xy)
