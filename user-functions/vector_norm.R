# Title: User Function `vector_norm`
# Review: 2020-01-31T1244 AU


## Vector Norm
# <https://github.com/fabnavarro/rwavelet/blob/master/R/normvec.R>
# to be modified

normvec <- function(x) {
  ## perform a singulal value decomposition (SVD): SVD works by reducing a matrix A of rank R to a matrix of rank k and is applicable for both square and rectangular matrices.
  svd1 <- svd(x)
  
  ## return maximum
  return(max(svd1$d))
}

## SVD:: https://rpubs.com/aaronsc32/singular-value-decomposition-r