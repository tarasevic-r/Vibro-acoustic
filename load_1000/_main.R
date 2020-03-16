# Load 1000 time series files
# 2020-01-21 T14:23 RT

rm(list=ls())

local_dir <- "C:/Users/user2/Desktop/code/load_1000/"
setwd(local_dir)
# Mode function
source("Mode_function.R")

# Function for statistics calculation; statistics(file_index, sample_index, time, value)
source("statistics_function.R")

# Set my directory 
my_dir <- scan(file = "dir.txt", what = "character")

# Iterate through all files and calculate main statistics
source("iterate_files.R")

#### ?????
# analysis 
source("analyze_raw.R")

# Iterate with P. (clean values)
P = P.
source("iterate_files_clean.R")

# analyze P. (clean data)
source("analyze_clean.R")

# Print results

head(results)

setwd(my_dir1)

# 
# demo <- sapply(results, sd)
# 
# plot(x = results$Sample_Index, y = results$Value_min, type = 'l'
#      , ylim = c(y_min, y_max), col = 'blue', main = 'MIN = blue   MAX = red')
# lines(x = results$Sample_Index, y = results$Value_max, col = 'darksalmon')
# 
# y_min <- min(results$Value_min, results$Value_max)
# y_max <- max(results$Value_max, results$Value_max)
# 
