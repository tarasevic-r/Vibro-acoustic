s_wp <- wavethresh::wp(s, filter.number = best_index, family = best_family)
# s_wp <- wavethresh::wp(s[1:512], filter.number = best_index, family = best_family)
# s_wp <- wavethresh::wp(s[257:768], filter.number = best_index, family = best_family)
# s_wp <- wavethresh::wp(s[385:896], filter.number = best_index, family = best_family)
# s_wp <- wavethresh::wp(s[513:1024], filter.number = best_index, family = best_family)

# empty list to store results
# names <- list("level_1","level_2","level_3","level_4","level_5")
names <- list("level_1","level_2","level_3","level_4","level_5","level_6","level_7"
              ,"level_8","level_9","level_10","level_11")

# empty data frame for sub - bands energy results
results <- data.frame()

# cycle for sub band levels energy calculation
for(i in 1:length(names)){
  cat("i: ",i, '\n')
  # cycle for nodes
  for(j in 0:(2^(i-1)-1)){
    cat("j: ",j, '\n')
    result <- nodes(s_wp, level = s_wp$nlevels - i, node = j )  
    # add each node energy at certain level to data frame
    results <- rbind(results, result)
  }
  
  # add all level energies to list
  colnames(results) <- "Energy"
  names[[i]] <- results  
  results <- data.frame()
}

# level energy values to matrix
levels_energy <- as.matrix(names) 

# choose level u
u = 8

# all levels energy should be equal
ENG <- do.call(sum, names[u])#/2^u

# ENG_1 <- ENG/100

### change signal and calculate energy 

### calculate energy only at that level sub bands
sub_energy <- data.frame()
# lenght of number of sub bands at certain level
len <- length(t(names[[u]]))
# for(l in 1:len) {
#   # calculate each sub band energy at certain level
#   energy <- names[[u]][l,]/ENG
#   sub_energy <- rbind(sub_energy, energy)
# }

sub_energy <- names[[u]]/ENG
colnames(sub_energy) <- "energy"
# sum(sub_energy)
# 
# # plot energy results
plot(x=c(1:len),y = t(sub_energy), type="b", pch=18, col='brown', lwd = 2
     , xlab="sub-bands", ylab = "energy", main = "Energy distribution", xlim = c(0,15))



# write csv
# write.csv(round(sub_energy, 4), "test.csv")


# 
# lines(x=c(1:len),y = t(test_1), lty=2, lwd = 2, col = 'green', type ='b', pch=19)
# 
# legend("topright", legend=c("1st signal energy", "2nd signal energy"),
#        col = c("green", "brown"), lty=2:1, lwd=2)
# 
# # distance between signals energy 
# dist(rbind(t(sub_energy), t(test_1)))

# 
# summary(sub_energy)
# summary(sub_energy2)
# 
# sqrt(sum(sub_energy^2)/length(sub_energy))
# sqrt(sum(sub_energy2^2)/length(sub_energy2))
# 
# ener <- as.numeric(sub_energy$energy)
# plot(ener, type = 'b', lwd=2, col='blue')
# round(mean(sqrt(ener^2)), 2)
# summary(ener)
# 


