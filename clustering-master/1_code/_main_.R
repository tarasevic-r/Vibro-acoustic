# Title: Clustering Sensor Data ####
# Review: 2020-02-04T1308 AU
# Chapter: _main_ file


# clean environment
rm(list=ls())


source('setup-project.R')
source('load-libraries.R')
source('user-functions_clustering.R')
source('load-data.R')
source('select-vars.R') # remove non-data
source('review-data.R')

# source('select-sample_sensor.R')
# source('visualize-data_sensor.R')

## review outliers with boxplot
# source('remove-outliers_boxplot.R')
source('remove-outliers.R')

source('prepare-data_min-max-scale.R')


# source('create-features.R') # AU: .. 20200107
# source('discretize-data.R') # AU: .. 20200107
# source('prepare-data_diff.R')  # AU: .. 20200107
# source('prepare-data_standardize.R')  # AU: .. 20200107

source('check-correlation.R')

## backup model data
save(d, file='../4_data/model_data.Rdata')

## fit kmeans
source('fit-model_kmeans_library-nbclust.R')



# source('fit-model_kmeans.R')     # AU: .. 20200107
# source('fit-model_dbscan.R')     # AU: .. 20200108


## Cluster Validation ####

# cross-validate- what result under random shuffle?
source('choose-optimal-model.R')  # AU: .. 20200107
source('fit-model_kmeans_final.R')  # AU: .. 20200107
source('review-final-clusters.R') # AU: .. 20200107

# Finish
cat('\n\nEnd of file.\n\n')
