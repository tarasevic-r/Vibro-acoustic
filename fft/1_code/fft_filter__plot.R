# fft-filter__plot.R
# Review: 2020-01-11T1621 AU


## Capture strong coefficients
magnitude <-
  base::abs(FTs)


plot(
  magnitude
  , type='h'
  , main = 'FT coefficients'
)
