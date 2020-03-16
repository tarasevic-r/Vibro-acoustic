# Iterate all samples and write distances results
# 2020-01-22 T11:31 RT


# Empty table for results
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