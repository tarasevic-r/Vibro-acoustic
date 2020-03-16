# Title: Clustering Sensor Data
# Review: 2020-01-08T2141 AU
# Chapter: Fit Model - DBSCAN


# load data from previous chapter
# load('../4_data/5.RData')


cat('DBSCAN introduction: ..\n')

# select features for clustering
# X <- 2 # value
# d <- data.frame(d[,X])
# names(d) <- 'value'
# head(d)



## Model parameters tuning

# pr <- class::knn(iris_train,iris_test,k=2)

my_k <- 2
my_minPts <- 0.05*memory_size
my_dbscan_results <- data.frame()
my_eps_list <- seq(0.01, 0.5, 0.02)

for (i in 1:length(my_eps_list)) {
  cat('i', i, '\t', 'eps:', my_eps_list[i], '\n')
  my_eps <- my_eps_list[i]
  
  
  my_ds <- 
    fpc::dbscan(
      d
      , eps = my_eps
      , MinPts = my_minPts
    )
  
  
  # my_ch <-
  #   round(
  #     fpc::calinhara(
  #       d
  #       , my_ds$cluster
  #     )
  #   , k = my_k
  # )
  
  
  my_dbscan_results <- 
    rbind(
      my_dbscan_results
      , cbind(
        'Points' = nrow(d)
        , 'eps' = my_ds$eps
        , 'minpts' = my_ds$MinPts
        , 'clusters' = length(unique(my_ds$cluster))
        # , 'ch' = my_ch
        # , 'ch_k' = my_k
      )
    )
}


#my dbscan results
my_dbscan_results

plot(my_dbscan_results$clusters, type='h')

plot(my_ds, d)

# d_ds <- d

# load selected data
# load('../4_data/2.RData')

# head(d)
d_ds <-
  cbind(
    d[-1,]
    , 'cluster' = my_ds$cluster
    , 'isseed' = my_ds$isseed
  )

# interactive plot:
plotly::plot_ly(
  x = d_ds$timestamp
  , y = d_ds$value
  , type = 'scatter'
  , mode = 'lines'
  , colors = unique(d_ds$cluster)
)


x11()
plot(
  x = d_ds$timestamp
  , y = d_ds$value
  , type= 'l'
  , col = d_ds$cluster
)
points(d_ds[d_ds$cluster == 1,], col='green')
points(d_ds[d_ds$cluster == 2,], col='blue')
points(d_ds[d_ds$cluster == 0,], col='red')



# my_ds$cluster
# my_ds$isseed


# metrics: CH


save(
  my_ds
  , file='../5_models/model_dbscan.Rdata'
)

# end of chapter
cat('DBSCAN model fit.\n\n')
