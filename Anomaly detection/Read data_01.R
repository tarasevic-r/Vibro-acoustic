# Read and subset data
# 2020-01-22 T10:48 RT

df <- read.csv("C:/Users/user2/Desktop/T7_800_R6292.csv", sep = ",", header = T)
head(df)

# Subset data
subset <- subset(
  df
  , as.POSIXct(df$timestamp) >= as.POSIXct('2019-01-16 02:37:54') 
  & as.POSIXct(df$timestamp) <= as.POSIXct('2019-03-15 13:45:00'))


