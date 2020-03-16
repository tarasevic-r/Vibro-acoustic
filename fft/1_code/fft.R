# fft.R
# Review: 2020-01-24T1030 AU


## load data
# df <-
#   read.csv(
#     '../4_data/d3.csv'
#     , header=T
#   )


## check length for normalization of coefficients
N <- length(df$x)


## perform Fast Fourier Transform
# - use detrended data window
# - normalize coefficients
# s <- df$detrended
FTs <- stats::fft(df$detrended) / N


## Prcoess FFT coefficients
mag <- sqrt(Re(FTs)^2+Im(FTs)^2)*2/ n
phase <- atan(Im(FTs)/Re(FTs))
Re_FTs <- Re(FTs)
Im_FTs <- Im(FTs)


## Exclude FFT coefficients after Nyquist rate for frequency
# FTs <- FTs[2:(Fn+1)]


# ## save FFT coefficients to file
# write(
#   FTs
#   , file='../4_data/FTs__full.csv'
#   , ncolumns = 1
#   # , row.names = T
# )
