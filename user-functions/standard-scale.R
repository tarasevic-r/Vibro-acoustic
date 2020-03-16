# Title: User-Defined Functions - Standard Scale
# Review: 2020-02-04T1059 AU

## StandardScale
# subtract mean and divide by standard deviation
StandardScale <- function(x, na.rm = TRUE) {
  
  mean_x <- base::mean(x, na.rm = na.rm)
  sd_x <- stats::sd(x, na.rm = na.rm)
  
  return( ( x - mean_x ) / sd_x )
}

## example
x <- c(-1,0,1)
# StandardScale(x)
# [1] -1  0  1