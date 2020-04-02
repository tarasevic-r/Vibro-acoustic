# load data
s <- 
  rhdf5::h5read(
    "file name"
    , "/promc.dataset.orig"
    , bit64conversion="double")


# Converte date into POSIXct format
s$timestamp <-
  lubridate::as_datetime(
    as.numeric(s$timestamp/1000000)
    , tz = "Asia/Yekaterinburg" # "GMT-3"
  )

# subset
s_subset <- subset(s, s$timestamp > "2019-09-19 01:00:00"
                   & s$timestamp < "2019-09-22 23:59:00")