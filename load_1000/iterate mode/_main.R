# Load 1000 time series files
# 2020-01-21 T13:33 RT

rm(list=ls())

# Print task
source("task.R")

my_dir1 <- "C:/Users/user2/Desktop/code/load_1000/iterate mode/"

# Function for mode calculation; Mode_f(x)
source("Mode_function.R")

# Function for statistics calculation; statistics(file_index, sample_index, time, value)
source("statistics_function.R")

# Number of files to load
N = 1000

# Get required file names in directory
# pattern = '_R([0-9]+).H5'
source("Generate_file_names.R")


# Iterate through all files and calculate main statistics
source("iterate_files_with_mode.R")

# Export results
source("export_results.R")

# Print results
head(results)

setwd(my_dir1)
