# Load data
# 2020-01-22 T11:30 RT

library("TSdist")

# Load ifft samples data
data <- read.csv("df_master_m=14_k=11_threshold=0.1.csv", sep = ',', header = T)

d <- data.frame(y=data$y, i_y=data$i_y, sample=data$sample)