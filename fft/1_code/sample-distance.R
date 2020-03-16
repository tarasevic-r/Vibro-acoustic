## sample-distance.R
# Review: 2020-01-13T1527 AU


# cleanup
rm(list=ls())


## get data
d <-
  read.csv(
    file='../4_data/df_master_m=16_k=10_threshold=0.1.csv'
  )

m <- 16
k <- 10
threshold_FT <- 0.1


## prepare a separate file for distances
distances <- data.frame()


## check range
samples_min <- min(d$sample)
samples_max <- max(d$sample)


## prepare index
sample_idx_1 <- 1


for(sample_idx_1 in samples_min:samples_max) {
  # sample_idx_1 <- 1 # qc
  
  ## collect original value for specific sample
  i_y_1 <- d$i_y[d$sample == sample_idx_1]
  
  # cat('sample_idx_1:',sample_idx_1,'mean:',mean(i_y_1),'\n')
  
  ## rest internal counter
  sample_idx_2 <- 1
  
  while(sample_idx_2 <= samples_max) {
    # sample_idx_2 <- 1
    

    ## only run if the indices are different to avoid things like dist(1,1)
    if(sample_idx_2 > sample_idx_1) {
      ## collect original value for specific sample
      i_y_2 <- d$i_y[d$sample == sample_idx_2]
      
      distance <-
        TSdist::FourierDistance(
          as.numeric(scale(i_y_1))
          , as.numeric(scale(i_y_2))
        )
      
      result <-
        data.frame(
          m = 16
          , k = 10
          , sample_1 = sample_idx_1
          , sample_2 = sample_idx_2
          , distance = distance
        )
      
      cat(
        sample_idx_1, '&'#,'mean:',mean(i_y_1)
        , sample_idx_2, '='#,'mean:',mean(i_y_2),'\t'
        ,'distance:', round(distance)
        , '\n'
      )
      
      distances <-
        rbind(
          distances
          , result
        )
    }
    
    
    ## update second sample
    sample_idx_2 <- sample_idx_2 + 1
  }
}


## export results to file
write.csv(
  distances
  , file =
    paste0(
      '../4_data/'
      , 'df_master'
      ,'_m=',m # file size
      ,'_k=',k # data window size
      ,'_threshold=',threshold_FT
      , '_distances'
      ,'.csv'
    )
  , row.names = F # no row names
)