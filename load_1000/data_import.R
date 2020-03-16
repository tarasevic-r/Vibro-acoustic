# data import

setwd(my_dir)

# Load all files on by one
P <- 
  rhdf5::h5read(
    "C:/Users/user2/Desktop/T7_800_R6292.H5"
    , "/promc.dataset.orig"
    , bit64conversion="double")

P$timestamp <-
  as_datetime(
    as.numeric(P$timestamp/1000000)
    , tz = "Asia/Yekaterinburg" # "GMT-3"
  )