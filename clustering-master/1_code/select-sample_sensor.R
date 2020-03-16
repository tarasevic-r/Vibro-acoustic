# Title: Select sample
# Review: 2020-02-04T0915 AU



# load data in R format
# load('../4_data/1.RData')


# starting_index <- 1000 # for data selection


# subset data by count of data points using sample_size:
# d <- d[starting_index:(starting_index + sample_size - 1), ]


# subset data by time interval:
# d <- subset(
#   d
#   , timestamp > "2019-03-07 12:00:00"
#   & timestamp < "2019-04-07 12:00:00"
# )
# 
# # case 2: decrease / accident
# d <- subset(
#   d
#   , timestamp > "2019-03-18 06:00:00"
#   & timestamp < "2019-03-22 12:00:00"
# )


## sample records by `sample_size`
# {
# stop if data contains less rows than sample size
# stopifnot(dim(d)[1] >= sample_size)

# idx <- sample(1:nrow(d), nrow(d) * 0.1, replace = F)
# 
# # select number of rows equal to sample size
# d <- d[idx,]
# 
# d <- d[order(d$timestamp),]
# 
# stopifnot(dim(d)[1] >= sample_size)

# cleanup
# rm(sample_size) # raw data
# }


# save selected data in R format
# save(
#   d
#   , file='../4_data/2.RData'
# )


# cleanup
# rm(
#   d # data
#   , starting_index # local
#   , sample_size # done
# )
# 

# end of chapter
# cat('data selected.\n\n')
