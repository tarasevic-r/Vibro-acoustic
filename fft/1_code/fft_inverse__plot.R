# fft_inverse__plot.R
# Review: 2020-01-10T2301 AU


## Plot Original Fourier Transform Coefficients
# Data is scaled
plot(
  scale(df$detrended)
  , type = 'l'
  , col = 'green'
  , main = 'Original and Principal Fourier Transform Coefficients'
  , sub = 'Data is scaled'
)
## Also add lines for Principal Fourier Transform Coefficients 
# Data is scaled
lines(
  scale(df$i_detrended)
  , col='red'
)

## Conclusion 1: NORMALIZATION IS IMPORTANT.
## Conclusion 2: library `pracma` is not necessary.