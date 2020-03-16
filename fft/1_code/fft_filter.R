# fft-filter.R
# Review: 2020-01-11T1623 AU


## load FT coefficients from file
# FTs <-
#   scan(
#     file='../4_data/FTs__full.csv'
#   )


## convert to proper format
# FTs <- as.complex(FTs$x)

## length of FTs
# length(FTs)

## review FTs
# head(FTs)#[2:(Fn+1)]
# tail(FTs)#[2:(Fn+1)]


## calculate magnitude of FTs
magnitude <-
  base::Mod(FTs)


## normalize magnitude with mix-max
normalize <-
  function(x, na.rm = TRUE) {
    ranx <- range(x, na.rm = na.rm)
    (x - ranx[1]) / diff(ranx)
  }
magnitude <-
  normalize(magnitude)


## identify cofficients below FFT threshold
idx_weak_FTs <-
  which(magnitude < threshold_FT)


# if any found, nullify
if(length(idx_weak_FTs) > 0) {
  0 ->
    FTs[idx_weak_FTs]
}


# ## export strong FTs to file
# write.csv(
#   FTs
#   , file='../4_data/FTs__strong.csv'
#   , row.names = F
# )
