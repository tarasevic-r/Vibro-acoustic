# fft__plot.R
# Review: 2020-01-11T1645 AU


magnitude <-
  base::abs(FTs)


# visualize FT coefficients

plot(
  magnitude
  , type ='h'
  , main = 'FT coefficients'
)
# 
# barplot(
#   magnitude
#   , main = 'FT coefficients'
# )
