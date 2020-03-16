# Title: Visualize raw data
# Review: 2020-01-31T1701 AU
# Input: d0
# Output: charts in 3_figures


### Data Visualization ####

## plot top frequencies
png('../3_figures/01_data.png', width=1024, heigh=768)
## Plot Data
plot(
  x = d0$timestamp
  , y = d0$value
  , type = 'l'
  , main = 'Raw data'
  , xlab = 'timestamp'
  , ylab = 'value'
  , sub = paste('N=',length(d0$value))
)
dev.off()


# Plot subset (interactive)
suppressPackageStartupMessages(
  library('plotly') # interactive charts
)

## create a chart for original data with `plotly`
p_data__full <-
  plotly::plot_ly(
    x = d0$timestamp
    , y = d0$value
    , type = 'scatter'
    , mode = 'lines'
  )


## export to file
plotly::orca(
  p_data__full
  , '../3_figures/01_data__plotly.png'
  , width = 1024
  , height = 768
)