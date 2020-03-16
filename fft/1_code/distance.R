## distance.R
# Review: 2020-01-13T1026 AU

library('TSdist')

## calculate distance
# dist_FTs <-
#   ifelse(
#     is.null(Fn)
#     , sqrt(sum(Mod(FTs - iFTs)^2))
#     , sqrt(sum(Mod(FTs[2:(Fn+1)] - FTs[2:(Fn+1)])^2))
#   )


## Calculate the Fourier coefficient based distance using the default number of coefficients:

# library('TSdist')
# 
dist_fft <-
  TSdist::FourierDistance(
    x = scale(df$y)[,1]
    , y = scale(df$i_y)[,1]
  )

dist_fft <- round(dist_fft, 4)
  
# cat('Distance:', dist_fft, '\n')