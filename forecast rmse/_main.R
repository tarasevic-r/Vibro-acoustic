# Iterate forecasting one data point and check rmse
# # 2020-01-22 T10:37 RT

rm(list=ls())
# Load data
source("Load_data.R")

# split data into train and test sampels
source("train_test_split.R")

# Iterate forecasting by 1 data point and save results to table
source("forecast_results.R")

# Check forecasting accuracy and how it changes in forecast horizont
source("rmse_check.R")
