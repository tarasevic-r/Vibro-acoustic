# Title: Fit Model - K-means with library 'NbClust'
# Review: 2020-02-04T1542 AU



### Do the easy way with nBclust:
# fviz_nbclust() function: Elbow, Silhouhette and Gap statistic methods
library('factoextra')
library('NbClust')

img_W <- 800 # width
img_H <- 800 # height


## Elbow method ####
p_wss <-
  factoextra::fviz_nbclust(d, kmeans, nstart = 25, method = "wss") +
  geom_vline(xintercept = 4, linetype = 2) +
  labs(subtitle = "Elbow method")

png('../3_figures/p_kmeans_nbclust_wss.png', width = img_W, height = img_H)
p_wss
dev.off()


# Silhouette method ####
p_silhouette <-
  factoextra::fviz_nbclust(d, kmeans, nstart = 25, method = "silhouette") +
  labs(subtitle = "Silhouette method")

png('../3_figures/p_kmeans_nbclust_silhouette.png', width = img_W, height = img_H)
p_silhouette
dev.off()


### Gap statistic ####
# nboot = 500 for your analysis (# nboot = 50 to keep the function speedy)
# Use verbose = FALSE to hide computing progression.
set.seed(1235)
p_gap <-
  factoextra::fviz_nbclust(d, kmeans, nstart = 25, method = "gap_stat", nboot = 50) +
  labs(subtitle = "Gap statistic method")

png('../3_figures/p_kmeans_nbclust_gap.png', width = img_W, height = img_H)
p_gap
dev.off()
