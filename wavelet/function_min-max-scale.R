# Title: User-Defined Functions - Min Max Scale
# Review: 2020-02-12T1418 AU

## MinMaxScale (exclude NA values)
# Subtract the minimum value and divides by range (the difference between the original maximum and original minimum)

MinMaxScale <- function(x, na.rm = TRUE) {
  min_x <- min(x, na.rm = na.rm)
  max_x <- max(x, na.rm = na.rm)
  return( ( x - min_x ) / (max_x - min_x ) )
}

# ### Example:
# ## create vector
# x <- c(-1,1,-2,2)
# ## run function on vector
# MinMaxScale(x)
# # [1] 0.25 0.75 0.00 1.00