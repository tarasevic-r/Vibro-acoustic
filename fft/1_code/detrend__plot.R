## detrend__plot.R
# Review: 2020-01-11T1313 AU


library('ggplot2')
library('gridExtra')

## create a chart for original data
p1 <-
  ggplot2::ggplot(df, aes(x = x, y = y)) +
  geom_point() +
  geom_line(data = myfit, color = "blue")

## create a chart for detrended data
p2 <-
  ggplot2::ggplot(df, aes(x = x, y = detrended)) +
  geom_point() +
  geom_line(data = myfit, aes(y = detrended), color = "blue")

## plot both charts in one row
gridExtra::grid.arrange(
  p1
  , p2
  , nrow = 1
)


## plot original, predicted and predicted after detrending
plot(sample, type='l', col='green')
lines(pred.lm.sin$y, col='red')
lines(pred.lm.sin$detrended, col='blue')