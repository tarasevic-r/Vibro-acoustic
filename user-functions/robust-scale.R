# Title: User-Defined Functions - Robust Scale
# Review: 2020-02-04T1051 AU


## RobustScale (exclude NA values)
# Subtract the median and divide by the interquartile range (75% value - 25% value)

RobustScale <- function(x, na.rm = TRUE) {

  median_x <- stats::median(x, na.rm = na.rm)
  q3_x <- stats::quantile(x, 0.75, na.rm = na.rm)
  q1_x <- stats::quantile(x, 0.25, na.rm = na.rm)
  
  return( ( x - median_x ) / ( q3_x - q1_x ) )
}

## example
# x <- c(-5,-1,0,1,5)
# RobustScale(x)
# [1] -2.5 -0.5 0.0 0.5 2.5