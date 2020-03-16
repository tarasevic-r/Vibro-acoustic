# Title: Clustering Sensor Data
# Review: 2020-02-04T0919 AU
# Chapter 1. Load data


# file location
data_period_dir <- '' # dbBFxx.HDF5.201909/' # 2019.01.16-2019.04.19/'
bf_id <- '' # dbBF01.HDF5/' # blast furnace

# file name
file_prefix <- 'stats_samples_'
sensor_id <- 'T10_801_R094' # 'T1_803_R032' # 'T7_800_R6292'
file_ext <- '.csv' # '.h5'

# prepare file name and cleanup
file_name <- paste0(file_prefix, sensor_id, file_ext)

# prepare file path
file_path <- paste0(project_dir, raw_data_dir, data_period_dir, bf_id, file_name)
rm(raw_data_dir, data_period_dir, bf_id, file_name)


# load data using specified file path
if(file_ext == '.H5') {
  d <-
    rhdf5::h5read(
      file_path
      , "/promc.dataset.orig"
      , bit64conversion = "double"
    )
} else if (file_ext == '.csv') {
  d <- read.csv(
    file_path
    , row.names = 1
  )
}


# dataset size
dim(d)


# stop if less than 300 rows
stopifnot(nrow(d) > min_rows)


# save loaded data in R format
# save(d, file='../4_data/1.RData')


# cleanup
rm(file_path, min_rows)


# end of chapter
cat('Data loaded.\n')
