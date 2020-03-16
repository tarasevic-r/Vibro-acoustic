# Title: Unsupervised Learning - Clustering Fuzzy C Means
# Review: 2020-01-22T1243 AU

#######################################################

require('ppclust')
#require('dplyr')

#######################################################

## Loading the dataset
data(iris)
X <- iris[,-5]
Y <- iris[,5]
X[1:5,]

#######################################################

## Plot the data
pairs(X, col=Y)

#######################################################

## Correlation

### Correlation (numeric)
cor(X)

### Correlation (visual)
require('psych')
psych::pairs.panels(
  X
  , method = "pearson"
)

#######################################################

## Fuzzy C-Means

# (FCM) is a soft custering algorithm proposed by Bezdek (1974; 1981). Unlike K-means algorithm in which each data object is the member of only one cluster, a data object is the member of all clusters with varying degrees of fuzzy memberhip between 0 and 1 in FCM. Hence, the data objects closer to the centers of clusters have higher degrees of membership than objects scattered in the borders of clusters.

m.fcm <-
  ppclust::fcm(
    X
    , centers=3
  )

## Fuzzy Membership Matrix
as.data.frame(m.fcm$u)[1:6,]


## cluster prototypes matrices
### Initial cluster prototype matrices
m.fcm$v0

### Final cluster prototype matrices
m.fcm$v

### Model summary
summary(m.fcm)


### Model improvement ####
## Run FCM with Multiple Starts

m.fcm <-
  ppclust::fcm(
    X
    , centers = 3
    , nstart = 2 # integer: number of starts for clustering; default = 1
  )

m.fcm$func.val
m.fcm$iter

m.fcm$best.start


summary(m.fcm)


#### Model Charts ####

## Pairwise Scatter Plots

ppclust::plotcluster(
  m.fcm
  , cp=1
  , trans=T
)


### Cluster Plot with fviz_cluster from library `factoextra`

require('factoextra')

m.fcm2 <-
  ppclust::ppclust2(
    m.fcm
    , "kmeans"
  )


factoextra::fviz_cluster(
  m.fcm2
  , data = X
  , ellipse.type = "convex"
  , palette = "jco"
  , repel = T
)

### Cluster Plot with clusplot

m.fcm3 <-
  ppclust::ppclust2(
    m.fcm
    , "fanny"
  )

cluster::clusplot(
  scale(X)
  , m.fcm3$cluster
  , main = "Cluster plot of Iris data set"
  , color=T
  , labels = 2
  , lines = 2
  , cex = 1
)


#### VALIDATION OF CLUSTERING ####
require('cluster')
require('fclust') # cluster validation indexes


## generate a model
m.fcm4 <-
  ppclust::ppclust2(
    m.fcm
    , "fclust"
    )

### Fuzzy Silhouette Index
idxsf <-
  fclust::SIL.F(
    m.fcm4$Xca
    , m.fcm4$U
    , alpha=1
    )
paste("Fuzzy Silhouette Index: ",idxsf)


### Partition Entropy
idxsf <-
  fclust::PE(m.fcm4$U)
paste("Partition Entropy: ", idxsf)

### Partition Coefficient
idxpc <-
  fclust::PC(m.fcm4$U)
paste("Partition Coefficient : ", idxpc)

### Modified Partition Coefficient
idxmpc <- fclust::MPC(m.fcm4$U)
paste("Modified Partition Coefficient :",idxmpc)


## gap index ####

# install.packages('clusterSim')
library('cluster')
library('clusterSim')


## cluster model 1
cl.pam.1 <- cluster::pam(X, 3) 

## cluster model 2
cl.pam.2 <- cluster::pam(X, 4)

## merge cluster models 1 and 2
cl.pam.all <- cbind(cl.pam.1$clustering, cl.pam.1$clustering)

## calculate gap index for all cluster solutions
idx.gap <-
  clusterSim::index.Gap(
    X
    , cl.pam.all
    , reference.distribution="unif"
    , B=10
    , method="pam"
    )

cat('gap index:', idx.gap)




cl2 <- cluster::pam(X, 5)

## Davies-Bouldin's (DB) index #####
idxdb <-
  clusterSim::index.DB(
    X
    , cl2$clustering
    , centrotypes = "centroids"
    )

cat('Davies-Bouldin\'s (DB) index:', idxdb$DB)


## Calinski-Harabasz (CH) pseudo F-statistic ####

cl.pam.3 <- cluster::pam(X,3)

## calculate 
idx.G1 <- clusterSim::index.G1(X, cl.pam.3$clustering)
  
cat('Calinski-Harabasz (CH) pseudo F-statistic:', idx.G1)
