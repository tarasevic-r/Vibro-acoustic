# Title: Clustering Sensor Data
# Review: 2020-01-28T1614 AU
# Chapter: Transform data


# load data from previous chapter
load('../4_data/2.RData') # 2 = selected


# notify user about preparation steps
cat('data preparation: initializing\n')
{
  # data differences
  # cat('\t data differences\n')
  # {
  #   d <-
  #     data.frame(
  #       sapply(
  #         d
  #         , diff
  #       )
  #     )
  #   # 
  #   # write.csv(d, 'diff.csv')
  #   # check if data was normalized correctly and average is close to 0
  #   # stopifnot( 0 - mean(d) < 0.01 )
  # }
  # head(d)
  # hist(d[,2])
  # plot(density(d[,2]))
  # mean(d[,2])
  
  # scale data
  cat('\t 1. normalization (scale data between -1 and 1)\n')
  {
    d <-
      data.frame(
        scale(
          x = d
          , center = T
          , scale = T
        )
      )
    
    # d <- data.frame(sapply(d, scale))
    # # check if data was normalized correctly and average is close to 0
    # stopifnot( 0 - mean(d) < 0.01 )
  }
}
cat('data preparation: complete\n')


# preview prepared data
head(d)


# save loaded data in R format
save(
  d
  , file='../4_data/5.Rdata'
)


# end of chapter
cat('data transformed.\n\n')
