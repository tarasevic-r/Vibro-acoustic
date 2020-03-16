# Title: pairwise distance in R
# Review: 2020-01-22T1526 AU
# URL: <https://www.r-bloggers.com/pairwise-distances-in-r/>


## function: pairwise distance in R
naive_distance <- function(A, B) {
  # A: matrix with obersvation vectors (nrow = number of observations)
  # B: matrix with another set of vectors (e.g. cluster centers)
  
  result = matrix(ncol = nrow(B), nrow = nrow(A))
  
  for (i in 1:nrow(A))
    for (j in 1:nrow(B))
      result[i,j] = sqrt( sum( ( A[i,] - B[j,] )^2 ) )
    
    return(result)
}

x <- as.matrix(c(1,2,3,4), ncol = 2)
y <- as.matrix(c(1,2,3,5), ncol = 2)

## call:naive_distance(x,y)
