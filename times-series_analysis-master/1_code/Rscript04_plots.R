# Title: Plot top frequencies
# Review: 2020-01-31T1705 AU


## plot top frequencies
png('../3_figures/04_top-frequencies.png', width=1024, heigh=768)
plot(
  table(time_diff)[1:20]
  , type = 'h'
  , main = 'Top (20) Frequencies'
  , xlab = 'Mode of Frequency'
  , ylab = 'Count'
)
dev.off()