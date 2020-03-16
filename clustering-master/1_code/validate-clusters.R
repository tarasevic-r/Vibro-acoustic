# Title: Validate Cluster
# Review: 2020-02-03T1725 AU

## CH-index
plot(
  x = 1:10
  , y = ch[1:10]
  , type='l'
  , main='Calinzki-Harabasz index'
  , sub = 'max value preferred'
  , col = 'blue' #rainbow(round(ch %% 10, 0))
)

