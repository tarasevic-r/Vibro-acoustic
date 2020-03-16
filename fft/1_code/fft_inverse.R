# fft_inverse.R
# Review: 2020-01-13T1038 AU


## export strong FTs to file
# FTs <-
#   scan(
#     file='../4_data/FTs__strong.csv'
#     # , header = T
#   )

## convert back
# FTs <- as.complex(FTs$x)


## qc
# stopifnot(class(FTs)=='complex')


# head(FTs)


iFTs <-
  stats::fft(
    FTs
    , inverse = T
  )


# head(iFTs)


## export inverted FFT coefficients to file
# write.csv(
#   iFTs
#   , file='../4_data/iFTs__full.csv'
#   , row.names = F
# )


## calculate magnitude of inverted FFT coefficients
i_magnitude <-
  base::Mod(iFTs)


## export inverted FFT coefficients to file
# write.csv(
#   i_magnitude
#   , file='../4_data/iFTs__full.csv'
#   , row.names = F
# )


## append inverted magnitude to data frame
df$i_detrended <- i_magnitude

# head(df)
