# Title: Clustering Sensor Data
# Review: 2020-02-03T1650 AU
# Chapter: Evaluate Model
# URL: <https://www.datanovia.com/en/lessons/determining-the-optimal-number-of-clusters-3-must-know-methods/>


#### Elbow method: within cluster sums of squares ####
# AU: not as good as others
# wss: a small WSS is desired, but at least 80% of variance explained

# plot chart
plot(
  wss[1:20]
  , type="b"
  , xlab="Number of Clusters"
  , ylab="Within groups sum of squares"
)




### Silhouette (max) ####
# high Silhouette Score is desirable.
# The Silhouette Score reaches its global maximum at the optimal k.
# This should ideally appear as a peak in the Silhouette Value-versus-k plot.

# URL: <https://towardsdatascience.com/clustering-metrics-better-than-the-elbow-method-6926e1f723a6>
# Silhouette coefficient and BIC score (from the GMM extension of k-means) are better alternatives to the elbow method for visually discerning the optimal number of clusters.



plot(wss, type='o')
# lines(wss)



# select final k
k_final <- 2 # wss, # ch



# cleanup
# rm(d2) # raw data
