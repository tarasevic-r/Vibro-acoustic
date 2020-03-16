## detrend.R
# Review: 2020-01-13T1038 AU


# load data: sample of signal size of data window
# df <-
#   scan(
#     file = '../4_data/lm.model_coefficients.csv'
#     # , header = T
#     )


## Extract linear model coefficients
a <- lm.trend$coefficients[1]
b <- lm.trend$coefficients[2]


## Trend data
df$i_y <-
  a +
  df$x * b +
  df$i_detrended


# head(df$i_y)

## create new data frame from a sequenced index (x) and sample (y)
# df <-
#   data.frame(
#     x = seq_along(y)
#     , y = df$y
#     )
