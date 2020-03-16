rm(list=ls())

library("TSdist")

# Load ifft samples data
data <- read.csv("df_master_m=14_k=11_threshold=0.1.csv", sep = ',', header = T)
# df_master_m=16_k=10_threshold=0.1
# 
d <- data.frame(y=data$y, i_y=data$i_y, sample=data$sample)
results <- data.frame()

# Iterate x[i] samples
for (i in 1:(max(d$sample))) {
  
  sample_1 = d[d$sample == i,]
  
# Iterate y[j] samples and calculate distance between sample[i] and sample[j]
  for (j in 1:max(d$sample)){
    
    if(i==j) next #skip if i = j
    
    sample_2 = d[d$sample == j,]
# Calculate distance between samples
    distance <- round(EuclideanDistance(sample_1$i_y, sample_2$i_y))
# Print results    
    cat('sample',i, '&', 'sample',j, '\t', 'Euclidean distance is:', distance, '\n')
  }
  

}



sample_1 <- d[d$sample == 1,]
sample_7 <- d[d$sample == 7,]
plot(sample_1$i_y, type = 'l', col = "gold")
lines(sample_7$i_y, col = "brown")
