
# Choose distance method
method = "euclidean" # "maximum", "manhattan", "canberra", "binary", "minkowski"

atstumas <- round(normalize(dist(statistika, method = method)),4)*100

# Write to csv
write.csv(as.matrix(atstumas), '../4_data/stat_dist.csv')
