


spectr <- spectr[!(spectr[,1] == 0),]
# order frequencies 
top <- order(spectr[,2], decreasing = T)
# check which of them are partial to 6
spectr <- spectr[top]
# nr <- which(spectr%%0.006==0)[1:8]    # for partial frequency
result_spectr <- 1000*spectr[1:9]

print(result_spectr)
