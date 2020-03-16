## detrend.R
# Review: 2020-01-11T1313 AU


## load data: sample of signal size of data window
# df <-
#   read.csv(
#     file = '../4_data/d2.csv'
#     , header = T
#   )


## assign DF
df <- s.dw


# create new data frame from a sequenced index (x) and sample (y)
# df <-
#   data.frame(
#     x = seq_along(y)
#     , y = df$y
#     )


# Samples
N <- length(df$x)


# Check if data matches data window
stopifnot(N == data.window)


# Nyquist frequency
Fn <- N/2


## Phase intervals ???
# L <- df$x[N] - df$x[1]


## Phase
# omega <- 2*pi/L


## create a linear time model to calculate trend for value variable y
lm.trend <-
  lm(
    formula = y ~ x
    , data = df
  )


# linear model coefficients
# lm.trend$coefficients


## save model
# write(
#   lm.trend$coefficients
#   , file='../4_data/lm.model_coefficients.csv'
# )


## calculate detrended part and append to data
df$detrended <-
  round(df$y - lm.trend$fitted.values)


head(df)


## export detrended signal data window to file
# write.csv(
#   df
#   , file='../4_data/d3.csv'
#   , row.names = F
# )



# # fit a linear model based on Euler's formula for wave expression
# lm.sin <-
#   lm(
#     y ~ x +
#       sin(omega*x) + cos(omega*x) +
#       sin(2*omega*x) + cos(2*omega*x) +
#       sin(3*omega*x) + cos(3*omega*x) +
#       sin(4*omega*x) + cos(4*omega*x) +
#       sin(5*omega*x) + cos(5*omega*x) +
#       sin(6*omega*x) + cos(6*omega*x) +
#       sin(7*omega*x) + cos(7*omega*x) +
#       sin(8*omega*x) + cos(8*omega*x) +
#       sin(9*omega*x) + cos(9*omega*x) +
#       sin(10*omega*x) + cos(10*omega*x)
#     , data = df
#   )
# 
# summary(lm.sin)
# 
# # prepare data frame for testing consisting of index length N
# pred.lm.sin <-
#   data.frame(
#     x = seq(df$x[1], df$x[N], by = 1)
#     )
# 
# # predict and append predicted value (y) to prediction data frame
# pred.lm.sin$y <-
#   predict(
#     lm.sin
#     , newdata = pred.lm.sin
#     )
# 
# # model with reviewed coefficients
# lm.sin.2 <-
#   lm(
#     detrended ~
#       sin(omega*x) + cos(omega*x) +
#       sin(2*omega*x) + cos(2*omega*x) +
#       sin(3*omega*x) + cos(3*omega*x) +
#       sin(4*omega*x) + cos(4*omega*x) +
#       sin(5*omega*x) + cos(5*omega*x) +
#       sin(6*omega*x) + cos(6*omega*x) +
#       sin(7*omega*x) + cos(7*omega*x) +
#       sin(8*omega*x) + cos(8*omega*x) +
#       sin(9*omega*x) + cos(9*omega*x) +
#       sin(10*omega*x) + cos(10*omega*x)
#     , data = df
#   )
# 
# 
# str(lm.sin.2)
# # predict using detrended model
# pred.lm.sin$detrended <-
#   predict(
#     lm.sin.2
#     , newdata = myfit
#   )
# 
