# Anomaly detection 
# 2020-01-22 T11:21 RT

rm(list=ls())

# Read data
source("Read data_01.R")

# Converte date into POSIXt format
source("converte_date_into_POSIXt_02.R")

# Converte data to tibble format
source("converte_to_tibble_03.R")

# time series decomposition into "seasonal", "trend" and "remainder" components
source("ts_decomposition_04.R")

# recompose back time series with ploted anomaly points
source("ts_recompose_05.R")

# extract actual anomaly data points
source("extract_actual_anomaly_data_points_06.R")

# extract data without anomaly data points
source("extract_NOT_anomaly_data_points_07.R")

# normalization function
source("normalize.R")

# plot results
source("plot_results_08.R")