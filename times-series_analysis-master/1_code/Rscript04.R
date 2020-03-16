# Title: Calculate mode of time series
# Review: 2020-01-31T1705 AU


## calculate time difference
time_diff <-
  diff(d$timestamp)


## round frequencies
time_diff <-
  round(time_diff)


## calculate mode using user-defined function `mode_f`
cat(
  'Mode of time change frequency is', Mode_f(time_diff)
  , '\n'
)
