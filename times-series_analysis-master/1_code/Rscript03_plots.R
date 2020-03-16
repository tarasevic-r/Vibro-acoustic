# Title: Plot sample
# Review: 2020-01-31T1704 AU


### Data Visualization ####

## Plot subset and export to file
png('../3_figures/03_data_sample.png', width=1024, heigh=768)
plot(
  x = d$timestamp
  , y = d$value
  , type = 'l'
  , main = 'Data subset'
  , xlab = 'timestamp'
  , ylab = 'value'
  , sub = paste('N=',length(d$value))
)
dev.off()


## Plot subset (interactive)
suppressPackageStartupMessages(
  library('plotly') # interactive charts
)

p_data_sample <-
  plotly::plot_ly(
    x = d$timestamp
    , y = d$value
    , type = 'scatter'
    , mode = 'lines'
  )

## export to file
plotly::orca(
  p_data_sample
  , '../3_figures/03_data_sample__plotly.png'
  , width = 1024
  , height = 768
)


## Plot full data and subset
png('../3_figures/03_data_full+sample.png', width=1024, heigh=768)
plot(
  x = d0$timestamp
  , y = d0$value
  , type = 'l'
  , main = 'Plot data and subset (green)'
  , xlab = 'timestamp'
  , ylab = 'value'
  , sub = paste0('N=',length(d0$value))
)
points(
  x = d$timestamp
  , y = d$value
  , col = 'green'
  , pch = 3 # 3 = +
)
dev.off()


## clean up
rm(d0, p_data__full, p_data_sample)