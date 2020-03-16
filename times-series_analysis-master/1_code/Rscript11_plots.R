# Title: Plot cross-correlation of two series
# Review: 2020-01-31T1708 AU


## Plot both series including cross-correlation info and export to file
png('../3_figures/11_cross-correlation.png', width=1024, heigh=768)
plot(
  x = ts1
  , type='l'
  , main = paste('Cross-correlation coefficient:', ro_xy, '(', ro_xy_type, ')')
  , ylim = c( min(min(ts1), min(ts2)), max(max(ts1), max(ts2)) )
  , xlab = NULL
)
lines(
  x = ts2
  , col='red'
)
dev.off()
