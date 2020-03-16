# Title: User Function `max_power_2`
# Review: 2020-01-31T1215 AU


## check maximum power of 2 for given vector
max_power_2 <- function(x) {
  
  stopifnot(class(x) == 'numeric')
  

  ## initiate counter
  m <- 1
  

  ## estimate length of given object
  length_x <- length(x)
  

  ## while data is longer than the 2^m 
  while(length_x >= 2^m) {

	## print status
    cat('m=', m, 'rows=', 2^m, '\t')
    

    ## if data length matches perfectly with some 2 power of `m`
    if (length(s0$y) == 2^m) {
      
	  ## assign `m` to be one less
      m_max <- m

      ## if data length is already bigger, substract one
    } else if (length(s0$y) < 2^m) {
      
	  ## assign `m` to be one less
      m_max <- m - 1
	  
    } else {
      
	  ## assign `m` to be the maximum `m`
      m_max <- m
    }
    

    ## iterate next m
    m <- m + 1
    
    cat('m_max', m_max, '\n')
  }
  
  
  ## output info
  cat('m_max:', m_max, 'or', 2^m_max, 'rows')
  

  ## return result
  return(m_max)
}