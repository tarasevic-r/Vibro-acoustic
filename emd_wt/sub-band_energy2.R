s2_wp <- wavethresh::wp(s, filter.number = best_index, family = best_family)

# # sub-band energy calculation function
# nodes <- function(wp, level, node ){
#   # get node coefficients
#   nodes <- getpacket.wp(wp, level = level, index = node)
#   # if sub - band length is greater or equal to 8, calculate energy
#   if(length(nodes)/2 >= 8){
#     
#     # W <- getpacket.wp(wp, level = level, index = node)
#     sum(abs(nodes)^2)
#   } 
#   # print error if lenght is less
#   else{cat(" Error! \n Max freq we can detect in this node is:\t"
#              ,length(getpacket.wp(s_wp, level = level, index = node))/2, "Hz" )}
# }

# example:
# nodes(s_wp, level = 8, node = 1)

# empty list to store results
names <- list("level_1","level_2","level_3","level_4","level_5")

# empty data frame for sub - bands energy results
results2 <- data.frame()

# cycle for sub band levels energy calculation
for(i in 1:length(names)) {
  cat("i: ",i, '\n')
  # cycle for nodes
  for(j in 0:(2^i-1)){
    cat("j: ",j, '\n')
    result <- nodes(s2_wp, level = s2_wp$nlevels - i, node = j )  
    # add each node energy at certain level to data frame
    results2 <- rbind(results2, result)
  }
  
  # add all level energies to list
  colnames(results2) <- "Energy"
  names[[i]] <- results2 
  results2 <- data.frame()
}

# level energy values to matrix
levels_energy2 <- as.matrix(names) 

# all levels energy should be equal
ENG2 <- do.call(sum, names[1])




### change signal and calculate energy 


### take 4th or 5th level and plot all sub bands
### calculate energy only at that level sub bands

sub_energy2 <- data.frame()
len <- length(t(names[[3]]))
for(l in 1:len) {
  
  energy2 <- names[[3]][l,]/ENG2
  sub_energy2 <- rbind(sub_energy2, energy2)
  
}
colnames(sub_energy2) <- "energy_2"

# test_1 <- sub_energy

opa <- par(mar = c(5, 4, 1.4, 0.2))
# plot energy results
plot(x=c(1:len),y = t(sub_energy), type="b", pch=18, col='brown', lwd = 2
     , xlab="sub-bands", ylab = "energy", main = "Energy distribution"
     , ylim=c(0,max(sub_energy, sub_energy2)))

lines(x=c(1:len),y = t(sub_energy2), lty=2, lwd = 2, col = 'green', type ='b', pch=19)

legend("topright", legend=c("1st signal energy distribution", "2nd signal energy distribution"),
       col = c("brown", "green"), lty=1:2, lwd=2, cex=0.6, horiz = T, bty='n')
# rm(opa)
# distance between signals energy 
sub_energy <- c(t(sub_energy))
sub_energy2 <- c(t(sub_energy2))

cat(" Manhattan distance between two signals: \n"
    ,dist(rbind(sub_energy, sub_energy2), method = "manhattan"), "\n")
rm(opa)

