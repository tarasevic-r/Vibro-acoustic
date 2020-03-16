# Title: Simple Moving Average for _n_ Periods
# Review: 2020-01-22T1222 AU
# A Part of Data Transformations


## user-function: Smoothing by moving average
# parameters: n, number of periods to consider
simple_moving_average_n <-
  function(x, n) {
    return(
      as.numeric(
        stats::filter(
          x
          , rep(1/n, n)
          , sides = 1
          )
        )
      )
  }


## define number of periods to consider
n <- 30


## Calculate moving average using specific number of points
sma_n <- simple_moving_average_n(d$value, n)


## Convert to integer (no decimal digits)
sma_n <- as.integer(sma_n)


## create a new data frame from sample data and calculated moving average
d_sma <-
  cbind(
    d
    , sma_n
    )


## fix the name after calculus
names(d_sma)[3] <- "value_sma"


## preview data frame with calculated moving average
head(d_sma)


## exclude first n-1 rows containing NA after averaging
d_sma <- d_sma[-c( 1:(n-1) ),]
# d_sma <- d_sma[rowSums(is.na(d_sma)) == 0,]


## export sample to file
write.csv(
  d_sma
  , file = '../4_data/d_sample_sma.csv'
  , row.names = F
)


## comparison chart of original and averaged value (ggplot)
library('ggplot2')

r08_fig01a <-
  ggplot2::ggplot(d_sma, aes(x=d_sma$timestamp)) + 
  geom_line(aes(y = d_sma$value ), col="green") + 
  geom_line(aes(y = d_sma$value_sma), colour="orange")


## draw a figure
r08_fig01a


## output chart to file
png(
  file = '../3_figures/r08_fig01a_original-averaged_ggplot.png'
  , width = 800
  , height = 600
)
r08_fig01a
dev.off()


## interactive comparison chart of original and averaged value (plotly)
library('plotly')

r08_fig01b <-
  plot_ly(
    d_sma
    , x = ~timestamp
    , y = ~value
    , type = 'scatter'
    , mode = 'lines+markers'
    , name = 'value'
  ) %>%
  add_trace(
    y = ~value_sma
    , name = 'value_sma'
    , mode = 'lines'
  )


## draw a figure
r08_fig01b

## export plotly figure to png (static)
# plotly::orca(
#   r08_fig01b
#   , file = "../3_figures/r08_fig01b_original-averaged_plotly.png"
#   )

## export plotly figure to html (interactive)
htmlwidgets::saveWidget(
  r08_fig01b
  , file = "../3_figures/r08_fig01b_original-averaged_plotly.html"
  )
