# proper wavelet selection
# based on Shanon entropy

library(wavethresh)

# wavelets family list
waveletFamily <- list(c("DaubExPhase",1),
                      c("DaubExPhase",2),
                      c("DaubExPhase",3),
                      c("DaubExPhase",4),
                      c("DaubExPhase",5),
                      c("DaubExPhase",6),
                      c("DaubExPhase",7),
                      c("DaubExPhase",8),
                      c("DaubExPhase",9),
                      c("DaubExPhase",10),
                      c("DaubLeAsymm",10),
                      c("DaubLeAsymm",9),
                      c("DaubLeAsymm",8),                      
                      c("DaubLeAsymm",7),
                      c("DaubLeAsymm",6),
                      c("DaubLeAsymm",5),                      
                      c("DaubLeAsymm",4),                      
                      c("Lawton",3),
                      c("LittlewoodPaley",
                        length(s)),
                      c("LinaMayrand",5.4))

waveletPacket <- list(c("DaubExPhase",10),
                      c("DaubLeAsymm",10))


# levels 
levels <- 1:9
# empty data frame for results
baseSelect <- data.frame(WaveletFam = character(), Entropy=numeric(), stringsAsFactors = FALSE)

for(i in waveletFamily){
  coefs <- list()
  # for(j in 1:length(s)){
  waveletDecomp = wd(family = i[1]
                     , data = s
                     ,filter.number = i[2])
  nthresh = nlevelsWT(waveletDecomp)-1
  for (k in 0:nthresh) {
    coefs <- list(list(accessD(waveletDecomp, level = k)),coefs)
  }
  coefs <- list(list(accessC(waveletDecomp, level = 0)),coefs)
  # }
  
  
  coefs <- unlist(coefs)
  # calculate entropy
  EntropyB <- Shannon.entropy(abs(coefs)/max(abs(coefs)))/512
  # bind results
  baseSelect <- rbind(
    baseSelect
    ,data.frame(waveletFam = paste(i[1],i[2])
                , Entropy = EntropyB
                , stringsAsFactors = FALSE))
  
}

# change plot parameters
op <- par(mar=c(5,10,4,2))

# plot entropy results for each family (low is better)
barplot(baseSelect$Entropy, horiz = T, names.arg = c(baseSelect$waveletFam), las=1, col=1:16)
# set default plot parameters
rm(op)

# select family name with lowest entropy
min_entrpy <- which.min(baseSelect$Entropy)
fam <- baseSelect$waveletFam[min_entrpy]

family <- strsplit(fam, " ", perl=T)      
best_family <- family[[1]][1]
best_index <- as.numeric(family[[1]][2])

