# plot results
# 2020-01-22 T11:32 RT


sample_1 <- d[d$sample == 1,]
sample_7 <- d[d$sample == 7,]
plot(sample_1$i_y, type = 'l', col = "gold")
lines(sample_7$i_y, col = "brown")
