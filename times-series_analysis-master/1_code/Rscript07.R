# Title: Linear interpolation of time series
# Review: 2020-01-14T1608 AU


## export data to file
d <- 
  read.csv(
    file = '../4_data/data-sample.csv'
    , header = T
  )


### Data Processing ####

### Linear interpolation of time series

## indicate interpolation step
interpolation_step <- 4 # 4 seconds


## create a discrete timestamp between min datetime and max datetime split by interpolation step
time_interpolated <-
  seq(
    d$timestamp[1]
    , d$timestamp[length(d)]
    , by = interpolation_step  # indicate the needed quantity of seconds
  )


## create timestamp index
time_interpolated_index <-
  cbind(
    timestamp = time_interpolated
    , time_index = c(1:length(time_interpolated))
  )


## preview
# head(d_interpolated)


## merge time index with selected data
d_interpolated_index <-
  merge(
    time_interpolated_index
    , d
    , by='timestamp'
    , all=TRUE
  )


## preview
# head(d_interpolated_index)


### linear interpolation of values ####

library('zoo')

## interpolate data, keep NA
d_interpolated_index$value_interpolated <-
  zoo::na.approx(
    object = d_interpolated_index$value # object in which NAs are to be replaced
    , na.rm = F
  )


## preview
# head(d_interpolated_index)
# summary(d_interpolated_index)



# delete rows with missing values NA 
a <-
  d_interpolated_index[rowSums(is.na(d_interpolated_index)) == 0,]


summary(a)


## P_subset parameter graph with linear interpolation
plot(
  x = d$timestamp
  , y = d$value
  , type = "l"
  , col = "blue"
  , lwd = "1"
  , xlab = "Timestamp"
  , ylab = "Value"
  , main = "P subset plot/linear interpolation"
)
points(
  x = time_interpolated_index$timestamp
  , y = time_interpolated_index$value_interpolated
  , type = "l"
  , col = "red"
  , lwd = "1"
)
