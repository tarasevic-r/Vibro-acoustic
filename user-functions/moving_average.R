# Title: Calculate Moving Average for vector x
# Review: 2020-02-05T1532 AU
# Input: x

# URL: <https://stackoverflow.com/questions/743812/calculating-moving-average>


moving_average <- function(x, n = 3) {

  ma <- stats::filter(x, rep(1 / n, n), sides = 2)

  return(ma)
}
