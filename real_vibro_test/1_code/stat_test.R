
s_wp <- wavethresh::wp(s, filter.number = best_index, family = best_family)

# empty list to store results
# names <- list("level_1","level_2","level_3","level_4","level_5")
names <- list("level_1","level_2","level_3","level_4","level_5","level_6","level_7"
              ,"level_8","level_9","level_10","level_11", "level_12")

# empty data frame for sub - bands energy results
results <- data.frame()

# cycle for sub band levels energy calculation
for(i in 1:length(names)){
  # cat("i: ",i, '\n')
  # cycle for nodes
  for(j in 0:(2^(i-1)-1)){
    # cat("j: ",j, '\n')
    result <- nodes(s_wp, level = s_wp$nlevels - i, node = j, calculate = F )  
    # add each node energy at certain level to data frame
    results <- rbind(results, result)
  }
  
  # add all level energies to list
  # colnames(results) <- "Energy"
  names[[i]] <- results  
  results <- data.frame()
}

# level energy values to matrix
levels_energy <- as.matrix(names) 

# choose level u
# u = 4

# all levels energy should be equal
# ENG <- do.call(sum, names[u])#/2^u

# ENG_1 <- ENG/100

### change signal and calculate energy 

### calculate energy only at that level sub bands
sub_energy <- data.frame()
sub_stat = names[[u]] #level u-1
# lenght of number of sub bands at certain level
# len <- length(t(names[[u]]))

# sub_energy <- names[[u]]/ENG
# colnames(sub_energy) <- "energy"
# 
# plot energy results
# # 
# plot(x=c(1:len),y = t(sub_energy), type="b", pch=18, col='brown', lwd = 2
#      , xlim = c(0,length(t(sub_energy))+1), ylim=c(0,1)
#      , xlab="sub-bands", ylab = "energy", main = "Energy distribution")

