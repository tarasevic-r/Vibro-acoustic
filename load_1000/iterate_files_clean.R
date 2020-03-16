# Iterate through all files and calculate main statistics
# 2020-01-21 T14:36 RT

# Create empty table for results
results_clean <- data.frame()




## Iterate all files
# for (idx in 1:N) {
#   print(idx)

# data set size
N = length(P$value)

# data window size
dw = 2048
slide = dw/4

# set starting sample index
j = 1

# Data window start in data set
from = 1
# Data window end in data set
to = dw

# total_iteration <- floor((N-dw)/slide) + 1 


# iterate every data window size sample
while (to <= N) {
  
  # data window size sample for time
  t.sample <- P$timestamp[from:to]
  
  # cat('iteration ', j, 'of', total_iteration, '\n')
  
  # data window size sample for value
  x.sample <- P$value[from:to]
  
  # Calculate statistics
  result <- statistics(
    sample_index = j
    , time =  t.sample
    , value = x.sample
    , from = from
    , to = to
  )
  
  
  # Add result to results
  results_clean <- rbind(results_clean, result)
  
  
  j = j + 1
  # move to next sample
  from = from + slide
  to = to + slide
}


