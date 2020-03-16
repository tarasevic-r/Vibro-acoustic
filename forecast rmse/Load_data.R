# Load data
# 2020-01-22 T10:25 RT

library(rhdf5)
library(lubridate)



# load data
P =
  h5read("C:/users/user2/Desktop/T9_802_R3166.H5",
         
         "/promc.dataset.orig", bit64conversion="double")
dim(P)

# The selection of subsets of parameters on a time interval

# timestamp conversion from seconds to date and time
P$timestamp <- 
  as_datetime(
    as.numeric(P$timestamp/1000000)
    , tz = "Asia/Yekaterinburg" # "GMT-3"
    )

# P_with_date <- data.frame(timestamp_date,P$value)
# subset of the P parameter in the time interval
P_subset <- subset(P, P$timestamp > "2018-08-24 11:00:00"
                   & P$timestamp < "2018-08-24 11:20:00")

n_diffs <- forecast::ndiffs(P_subset$value)

x <- P_subset$value

