
# calculate "mean" category value of one energy subset
mean_cat = round(colMeans(categor),2)
mean_cat = scale(as.data.frame(mean_cat))
plot(mean_cat, type = 'h', ylab="mean category", main = "Mean category over slide")
