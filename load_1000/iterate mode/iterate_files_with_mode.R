# calculate dw size samples statistics for every file
# 2020-01-22 T12:36 RT


# Load required packages
library('rhdf5')
library('lubridate')

# Create empty table for results
results <- data.frame()

# Emprty table for files that contains less than 10000 data points
bad_results <- data.frame()


# set my files directory
setwd(my_dir)

# data window size
dw = 2000

# file index
for (i in 1:N) {
  print(i)
  
  # load data
  P <- 
    rhdf5::h5read(
      file_names[i]
      , "/promc.dataset.orig"
      , bit64conversion="double")
  
  # print data set length
  cat(file_names[i], 'length is:', length(P$timestamp), '\n')
  
  # Check if data contains at least 1000 rows 
  if (length(P$timestamp) < 10000) {
    
    bad_result <- data.frame(
      Name = file_names[i]
      , Length = length(P$timestamp)
    )
    
    # table of bad files
    bad_results <- rbind(bad_results, bad_result)
    
  }
  else {
    # Converte date into POSIXct format
    P$timestamp <-
      as_datetime(
        as.numeric(P$timestamp/1000000)
        , tz = "Asia/Yekaterinburg" # "GMT-3"
      )
    
    # set starting sample index
    j = 0
    to = 1
    
    # iterate every data window size sample
    while (to+dw <= length(P$timestamp) ) {
      
      # Data window start in data set
      from = j * dw + 1
      
      # Data window end in data set
      to = j * dw + dw
      
      # data window size sample for time
      t.sample <- P$timestamp[from:to]
      
      # data window size sample for value
      x.sample <- P$value[from:to]
      
      # Calculate statistics
      result <- statistics(
        file_index = i
        , sample_index = j
        , time =  t.sample
        , value = x.sample
      )
      
      # Add one iteration results to all results
      results <- rbind(results, result)
      
      # move to next sample
      j = j + 1
      
    }
  }
}
# set directory of current script
setwd(my_dir1)


