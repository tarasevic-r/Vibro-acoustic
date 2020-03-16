# Title: Clustering Sensor Data ####
# Review: 2020-01-07T1439 AU
# Chapter: Visualize Data


## load data
# load('../4_data/1.RData')


## preview data
head(d, 3)


## Variable: timestamp ####
x <- 'timestamp'


# format variable
d[,x] <-
  lubridate::as_datetime(
    as.numeric(d[,x]/1000000)
    , tz="Asia/Yekaterinburg"#"GMT-3"
  )

## statistics
# quantiles
qq_x <-
  quantile(
    d[,x]
    , probs = seq(0, 1, 0.01)
  )
# plot quantiles
plot(
  qq_x
  , type='o'
  , main = paste0(x, ': quantiles chart')
)

# plot data
plot(
  d[,x]
  , main = paste0(x, ': scatter plot')
)
# AU: uneven time periods

# plot data
# boxplot(
#   d[,x]
#   , main = x
# )

# outliers do not apply for date time


## Variable: Value ####
x <- 'value'

# data preview
head(d[,x], 10)

# round value
d[,x] <- round(d[,x], 0)

# quantiles
qq_x <-
  quantile(
    d[,x]
    , probs = seq(0, 1, 0.01)
  )
# qq_x

# plot quantiles
plot(
  qq_x
  , type='o'
  , main = paste0(x, ': quantiles chart')
)
# AU: more than 80% of data is above 6795

# plot data
hist(
  d[,x]
  , main = paste0(x, ': histogram')
  # , breaks = 256
)
# AU: bimodal distribution

# density plot
plot(
  density(d[,x])
  , main = paste0(x, ': density chart')
  # , breaks = 256
)
# AU: trimodal distribution; the right mode is dominant

# plot data with boxplot
# boxplot(
#   d[,x]
#   , main = x
# )
# AU: does not make sense, unless separated

# check outliers and save to a separate list
# cat(length(boxplot.stats(d[,x])$out), 'outliers found of', nrow(d) ,'\n')


## Overall review: ####
# basic statistics
summary(d)

# plot data with feature distribution, density and correlation
# PerformanceAnalytics::chart.Correlation(d)

# interactive plot:
plotly::plot_ly(
  x = d$timestamp
  , y = d$value
  , type = 'scatter'
  , mode = 'lines'
)


# save data in R format
save(
  d
  , file='../4_data/3.Rdata'
)


# cleanup
rm(qq_x, x)


# end of chapter
cat('data visualized.\n\n')
