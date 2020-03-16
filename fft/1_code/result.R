## Result.R
# 2020-01-13T1037 AU


## prepare results
result <-
  data.frame(
      file_size = 2^m
    , k = k
    , Data_Window = data.window
    , from = idx.from
    , to = idx.to
    , FFT_Threshold = threshold_FT
    , Distance = dist_fft
    , sample_id = sample_id
  )
