# Title: FFT Data Window Analysis - Report
# Review: 2020-01-13T1449 AU

rm(list=ls()) # clean up

source('import-data.R')
# - read data from original file
# - reset timestamp from 1
# - round value to 0.1
# - save data to d1

# source('user-functions.R')
# - load user-defined functions


## iterate data size
m_min <- 14 # 2^16 = 131072
# TBC rename to m
m_max <- 16 # 2^16 = 65536


for(m in m_min:m_max) {
  # m <- 14 # qc
  cat('m:', m, '=', 2^m, 'samples', '\n')
  
  
  ## sample 2^m rows
  s <- s0[1:2^m,]
  
  
  ## choose data window size
  # source('max-k.R')
  k_min <- 10 # 2^10 = 1024
  k_max <- k_min + 3 # (2^13 = 8192)
  
  
  ## data window iteration step size depends on file size and sample size = number of experiments
  # data.window_step_max <- 2^m_max / 2^k_min
  # data.window_step_min <- 2^m_min / 2^k_max
  # data.window_step <- data.window_step_max/data.window_step_min
  
  
  ## iterate data window size from 2^k_min to 2^k_max
  # for(k in k_min:k_max) {
  # qc
  k <- k_min
  
  data.window <- 2^k
  
  cat('k:', k, '=', 'data.window:', data.window, '\n')
  
  
  ## prepare threshold grid
  # threshold_FT_grid <-
  #   seq(
  #     from = 0.0
  #     , to = 0.5
  #     , by = 0.05
  #   )
  
  threshold_FT <- 0.1
  
  
  ## iterate threshold -- 20200113T1138 AU: skip for now
  #for(idx_threshold in 1:length(threshold_FT_grid)) {
  # idx_threshold = 5 # qc
  
  # cat('threshold is', threshold_FT_grid[idx_threshold], '\n')
  
  ## define threshold for FFT coefficients
  #threshold_FT <- threshold_FT_grid[idx_threshold]
  
  
  ## set data window indices
  idx.from <- 1
  idx.to <- idx.from + data.window - 1
  
  # signal: 1 2 3 4 5 6 7 8 9
  # s.dw:   1 2 3 4 5
  #           1 2 3 4 5
  #             1 2 3 4 5
  #               1 2 3 4 5
  #                 1 2 3 4 5
  
  sample_id <- 1L # integer
  
  df_master <- data.frame()
  
  
  ## iterate while data window sample end index is not equal to with data end index
  while(idx.to <= length(s$y)) {
    
    cat('idx.from:', idx.from, '\t', 'idx.to:', idx.to, '\n')
    
    
    source('fft_procedure.R')
    
    # source('distance.R')
    # - calculate distance between two series
    
    # source('result.R')
    # - prepare result of this round
    
    ## append result of this round to general pool of results
    # results <- rbind(results, result)
    #} # -- iterate thereshold
    
    
    ## A) update index: brute force (every step)
    # idx.from <- idx.from + 1
    # idx.to <- idx.to + 1
    
    ## B) update index: window size
    idx.from <- idx.from + data.window
    idx.to <- idx.to + data.window
    
    ## C) update index: data window step size
    # idx.from <- idx.from + data.window / data.window_step
    # idx.to <- idx.to + data.window / data.window_step
    
    
    ## update sample id
    sample_id <- sample_id + 1
    
    
    cat('.')
    # cat('idx.from:',idx.from,'\t','idx.to:',idx.to,'\n')
  } # -- iterate row index
  
  
  ## export results to file
  write.csv(
    df_master
    , file =
      paste0(
        '../4_data/'
        , 'df_master'
        ,'_m=',m # file size
        ,'_k=',k # data window size
        ,'_threshold=',threshold_FT
        ,'.csv'
      )
    , row.names = F # no row names
  )
  
  
  cat('\n')
  # } # -- iterate k
  
  cat('\n\n')
} # -- iterate m


# ## export results to file
# write.csv(
#   results
#   , file='../4_data/results.csv'
#   , row.names = T # keep rowc names
# )
