# Title: Function `null_vector`
# Review: 2020-02-12T1538 AU


## Inputs:
# df = data frame
# x = name of index column in data frame `df`
# x = name of values column in data frame `df`

## Function `null_vector`
# returns vector with values `y` at positions `x`
null_vector <- function(df, x, y) {
  
  ## values
  values <- df[,y]
  
  ## index
  index <- df[,x]

  ## prepare vector of length of data values
  vector_length <- length(values)
  
  # vector of 0
  v <- c(rep(0, vector_length))
  
  # data sets m-th element to vectors n-th 
  v[index] <- values[index]
  
  # return vector of 0 and m-th bin from data set
  return(v)
}

## prepare null vector `v0` and fill with values Y at index X, when given:
# * length `L`=16
# * magnitudes = 10, 5, 2, 1
# * frequency_index = 2, 4, 8, 16


## Example: backwards, start with correct example
## prepare a vector
# d <- c(0, 10, 0, 5, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1)
# idx <- which(d == 0)
# plot(d, type='h', lwd=5)

## Example
# null_vector(d1, 'frequency_index', 'magnitude')