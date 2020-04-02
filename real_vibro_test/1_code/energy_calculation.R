

h=1 

# setwd("../../emd_wt")
# Empty table for energy results
energija <- data.frame()
index <- data.frame()

while((to+slide) <= length(s_orig)) {
  cat(h, ' / ', round(length(s_orig) / slide - 3), '\n')
  s <- s_orig[from:to]
  
  # select best mother wavelet (lowest Shannon entropy)
  source("family_selection.R")
  # source("threshold.R")
  source("sub-band_energy.R")
  energija <- rbind(energija, t(sub_energy))
  index <- rbind(index, best_index)
  
  to = to+slide
  from=from+slide
  h=h+1
}
# plot.ts(index)#, type ='b')
# energija <- cbind(energija, index)
colnames(energija) <- NULL # set column names
rownames(energija) <- NULL # set column names
dim(energija)
# energija = cbind(energija, index)
# energija = energija[,-17]
# write energy to csv
write.csv(round(energija,2), file = "../4_data/energy.csv")
cat('\n', 'energies saved as energy.csv', 
    '\n','--------------------------------',
    '\n', "sub-band energy calculatoin DONE!")

