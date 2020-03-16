# Title: Clustering Sensor Data
# Review: 2020-02-03T1727 AU
# Chapter: Fit Model - k-means

# load data from previous chapter
# load('../4_data/4.RData')

## load statistics
# d0 <- read.csv('../2_raw-data/statistics_df.csv', header=T)

## remove sample id
# d0 <- d0[,-1]

# head(d0)
## exclude
# d0 <- d0[,-2]



cat('K-Means introduction: define k clusters such that total within-cluster variation is minimum.\n')

# select features for clustering
d <- dn

# Model parameters
min_k <- 2
max_k <- 20
length(seq(min_k, max_k))
my_iter_max = 100
my_nstart = 25 # repeat times

# calculate within-sum-of-squares metric
wss <- ( nrow(d) - 1) * sum( apply(d, 2, var) )
ch <- 0


# iterate through interval of centers
for (i in min_k:max_k) {
  my_model <- 
    kmeans(
      d
      , centers = i
      , iter.max = my_iter_max
      , nstart = my_nstart
    )
  
  # metrics: WSS
  wss[i] <- sum(my_model$withinss)
  
  # metrics: CH
  ch[i] <- round(fpc::calinhara(d, my_model$cluster), 2)
}

# export metric as .csv file
write.csv(wss, file='../5_models/kmeans_train_wss.csv')
write.csv(ch, file='../5_models/kmeans_train_ch.csv')


# end of chapter
cat('end of chapter.\n\n')
