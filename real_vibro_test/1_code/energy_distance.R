# calculate distances between samples

method = "euclidean" # "maximum", "manhattan", "canberra", "binary", "minkowski"

dista <- dist(energija, method = method)

# save distances matrix
write.csv(round(as.matrix(dista),2), file = "../4_data/distance.csv")
