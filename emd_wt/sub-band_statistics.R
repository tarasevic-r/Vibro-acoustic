s_wp <- wavethresh::wp(s, filter.number = best_index, family = best_family)
# s_wp <- wavethresh::wp(s[1:512], filter.number = best_index, family = best_family)
# s_wp <- wavethresh::wp(s[257:768], filter.number = best_index, family = best_family)
# s_wp <- wavethresh::wp(s[1025:1536], filter.number = best_index, family = best_family)

# empty list to store results
# names <- list("level_1","level_2","level_3","level_4","level_5")
names <- list("level_1","level_2","level_3","level_4","level_5","level_6","level_7"
              ,"level_8","level_9","level_10")#,"level_11")
# empty data frame for sub - bands energy results
results <- data.frame()

# cycle for sub band levels energy calculation
for(i in 1:length(names)) {
  cat("i: ",i, '\n')
  # i=1
  # cycle for nodes
  for(j in 0:(2^i-1)){
    cat("j: ",j, '\n')
    # j=1
    result <- nodes(wp = s_wp, level = s_wp$nlevels - i, node = j, calculate = F)  
    # add each node energy at certain level to data frame
    results <- rbind(results, result)
    colnames(results) = NULL
  }
  
  # add all level energies to list
  # colnames(results) <- NULL
  names[[i]] <- t(results)  
  results <- data.frame()
}


# level energy values to matrix
levels_value <- as.matrix(names) 

# levels_value[[8]][,256]

level_statistics <- data.frame()

#### define decomposition level (layer) ####
u=10
# lenght of number of sub bands at certain level
for(l in 1:2^u) {
  # l=1
  # calculate each sub band energy at certain level
  sub_statistic <- statistics_function(signal = levels_value[[u]][,l])
  colnames(sub_statistic) <- c("signal_length", "energie", "variance", "kurtosis", "skeweness", "rms")
  level_statistics <- rbind(level_statistics, sub_statistic)
  
}

# total level energie
total_eng <- sum(level_statistics$energie)
# energy ratio in sub-bands
level_statistics$energie <- round(level_statistics$energie/total_eng, 4)

head(level_statistics, n=10)
# stat1 <- level_statistics
# level_statistics_1 <- level_statistics
# plot.ts(level_statistics$kurtosis, type = 'l')
# save to csv
# write.csv(level_statistics, file = paste0("level_statistics.csv"))

