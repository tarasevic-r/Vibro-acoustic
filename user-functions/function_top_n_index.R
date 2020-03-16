# Title: Function `top_n_index`
# Review: 2020-02-13T1555 AU


## Function `top_n_index`
# returns index of N largest sorted values from vector `x`
top_n_index <- function(x, n) {
  return( order(x, decreasing = T)[1:n] )
}

### Example:
## create vector
# x <- c(1,2,0,5)
## call function and get index 
# idx <- top_n_index(x, 2)
## review index
# idx
## review top N largest values from original vector
# x[idx]
## check if values are larger than the rest
## (warning for different length vectors)
# x[idx] > x[-idx]
