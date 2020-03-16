# Title: Clustering Sensor Data ####
# Review: 2019-12-19T1224
# Chapter: Review Clusters


# load model
load('../5_models/model_kmeans.RData')


# review model structure
str(m)

# cluster counts
table(m$cluster)
# cluster proportions
round(prop.table(table(m$cluster))*100,2)

# variance explained
cat(
  'Such model can explain'
  , round((m$betweenss / m$totss) * 100, 2)
  , '% of data variance.\n'
)

# append cluster to prepared data
d_m <- data.frame(cbind(d, cluster = m$cluster))
d_m$cluster <- factor(d_m$cluster)
# export to file
write.csv(
  d_m
  , file='../5_models/kmeans_prepared_with_cluster.csv'
)

# plot raw data with clusters
plot(d_m[,6], col = d_m$cluster, type = 'b')
# lines(d[,2], col = m$cluster, type = 'o')

matplot(d_m, type = c("b"), pch=1,col = d_m$cluster ) #plot

# Fig 01
fpc::plotcluster(d, m$cluster)
# ref: <https://stats.stackexchange.com/questions/31083/how-to-produce-a-pretty-plot-of-the-results-of-k-means-cluster-analysis>

# Fig 03
pairs(d, col=c(1:7)[m$cluster])

# plot raw data with clusters
plot(
  d[,2]
  , col = m$cluster
  # , type = 'b'
)



## append cluster to raw data
# d_raw_sample_cluster <- cbind(d_raw_sample, cluster = m$cluster)
# d_raw_sample_cluster$cluster <- factor(d_raw_sample_cluster$cluster)
# export to file
write.csv(
  d_raw_sample_cluster
  , file='../5_models/kmeans_raw_with_cluster.csv'
)

# get cluster means
cluster_info <-
  aggregate(
    d_m[,1:(ncol(d_m)-1)]
    , by=list(d_m$cluster)
    , FUN=mean
  )
names(cluster_info)[1] <- c('cluster')
head(cluster_info)

# append group counts
cluster_counts <- data.frame(table(m$cluster))
names(cluster_counts)[1] <- c('cluster')
head(cluster_counts)

cluster_info <-
  merge(
    x = cluster_info
    , y = cluster_counts
    , by = "cluster"
    , all.x = T
  )


# plot bubble chart with `plotly`
library('plotly')

p <-
  plot_ly(
    cluster_info
    , x = ~min
    , y = ~max
    , color = ~cluster
    , type = 'scatter'
    , mode = 'markers'
    , marker = list(size = ~Freq, opacity = 0.5)
  ) %>%
  layout(
    title = 'Clustering results'
    , xaxis = list(showgrid = F)
    , yaxis = list(showgrid = F)
  )

p

# compare groups using parallel coordinates
library('MASS')
MASS::parcoord(group_means[2:ncol(group_means)], col=group_means[,1])





# end of chapter
cat('end of chapter.\n\n')
