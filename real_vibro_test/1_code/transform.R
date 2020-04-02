rownames(energija) = NULL

# empty vector
vec=c(1:length(energija[1,]))

#transform energy sub-bands by row
for(i in 1:length(energija[,1])){
  
  # i=500
  vec = cbind(vec, t(energija[i,]))
  
}
# plot.ts(t(energija[8,]))

# delet first row (1:128)
vec = vec[,2:(length(energija[,1])+1)]
dim(vec)
# vec=statistika
