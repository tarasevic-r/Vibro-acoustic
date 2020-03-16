library(wavethresh)


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
  EntropyB <- round(Shannon.entropy(abs(coefs)/max(abs(coefs)))/length(coefs), 3) # less is better
  
  return(EntropyB)
}
# empty coeficients list
coefs <- list()

# Calculate and store entropy with different Daubechie wavelet vanishing moments (1 to 10)
entropy <- data.frame()
for (i in 1:10){
  print(i)
  entropy_all <- data.frame()
  
  # call function for wd and entropy
  entropy_1 <- wavelet_entropy(s_3, N=i)
  entropy_2 <- wavelet_entropy(s_3_3, N=i)
  entropy_all <- cbind(entropy_1, entropy_2)
  
  entropy <- rbind(entropy, entropy_all)

  }

# print results
entropy



#### results ####
# we splited all data set into two equal length samples calculated Shannon entropy and stored
# results into table.
# noticed, that in both samples entropy was equal or very similar
# test was performed with and without noise, equal and different amplitudes

