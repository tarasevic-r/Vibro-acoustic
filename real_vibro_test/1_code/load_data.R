# setwd("../data/2nd_test")

# load rhdf5 format
# source("load_rhdf5.R")

s <- data.frame()
getwd()
for(i in 900:length(file_names)) {
  
  print(i)
  data = read.table(paste0("../../2nd_test/",file_names[i]))[,1]

    s <- as.numeric(c(s, data))
}

s_orig = s

