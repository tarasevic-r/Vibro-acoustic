# Title: Import data in `HDF5` format and convert to date-time
# Review: 2020-01-31T1414 AU


### Import Data ####

suppressPackageStartupMessages(
  library('BiocManager') # for library `rhdf5`
)
suppressPackageStartupMessages(
  library('rhdf5') # load data in hdf5 format
)


## define sensor
sensor_id <- 'T7_800_R6292'


## load data to a data frame
d0 <-
  rhdf5::h5read(
    paste0("../2_raw-data/", sensor_id, ".H5")
    , "/promc.dataset.orig"
    , bit64conversion="double"
  )



### Format Data ####

## Round value to integer

d0$value <- as.integer(d0$value)



## Convert timestamp to date-time

suppressPackageStartupMessages(
  library('lubridate') # time series processing
)

d0$timestamp <-
  lubridate::as_datetime(
    as.numeric(d0$timestamp/1000000)
    , tz = "Asia/Yekaterinburg" # "GMT-3"
  )


