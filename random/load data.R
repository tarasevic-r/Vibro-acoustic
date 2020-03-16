# load data
P <- 
  rhdf5::h5read(
    "file name"
    , "/promc.dataset.orig"
    , bit64conversion="double")


# Converte date into POSIXct format
P$timestamp <-
  lubridate::as_datetime(
    as.numeric(P$timestamp/1000000)
    , tz = "Asia/Yekaterinburg" # "GMT-3"
  )

# subset
P_subset <- subset(P, P$timestamp > "2019-09-19 01:00:00"
                   & P$timestamp < "2019-09-22 23:59:00")