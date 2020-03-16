# Title: User Function `mode_f`
# Review: 2020-01-31T1255 AU

## Test
# x <- c(1,0,1,0,1,0,1,0)

## return top mode frequency for vector x
Mode_f <- function(x) {
  Mx <- unique(x)
  return(Mx[which.max(tabulate(match(x,Mx)))])
}
## use: Mode_f(x)