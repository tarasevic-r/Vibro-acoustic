library(wavethresh)

coefs <- list()

# function for wavelet decomposition and Shannon entropy calculation
wavelet_entropy <- function(signal, N, family = "DaubExPhase" ) {
  
  # perform wavelet decomposition Daubechies extremal phase wavelet with 9 vanishing moments
  swd <- wd(signal, filter.number = N, family = family)
  
  nthresh = nlevelsWT(swd)-1
  
  # wavelet decomposition C and D coeficients 
  for (k in 0:nthresh) {
    coefs <- list(list(accessD(swd, level = k)),coefs)
  }
  
  coefs <- list(list(accessC(swd, level = 0)),coefs)
  coefs <- unlist(coefs)
  
  # plot.ts(coefs)
  
  # calculate Shannon entropy for coeficients
  EntropyB <- Shannon.entropy(abs(coefs)/max(abs(coefs)))/length(coefs) # less is better
  
  return(EntropyB)
}

