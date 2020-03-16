# Title: Plot density of time series
# Review: 2020-01-31T1416 AU


## Plot density of time series
png('../3_figures/05_density.png', width=1024, heigh=768)
plot(
  density(d$value)
  , main = 'Density plot'
)
dev.off()
